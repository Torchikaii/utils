from openpyxl import load_workbook, Workbook
from collections import defaultdict
import os
import ast

excel_file = "BOM.xlsx"
if not os.path.exists(excel_file):
    print(f"Error: {excel_file} not found in current directory")
    exit(1)

wb = load_workbook(excel_file)
ws = wb.active
headers = [cell.value for cell in ws[1]]

print("Which columns you want to keep:")
recommended = [2, 3, 8, 12]  # description, designator, part_number, price
for i, header in enumerate(headers):
    tag = " (recommended)" if i in recommended else ""
    print(f"{i}: {header}{tag}")

selected = ast.literal_eval(input("Enter column indices as list (e.g., [2,3,8,12]): "))
currency = input("Which currency format did you exported in altium?: ")
consolidate = input("Do you want to consolidate parts? (y/n): ").lower() == 'y'

data = []
for row in ws.iter_rows(values_only=True):
    if any(cell is not None for cell in row):
        data.append([row[i] if i < len(row) else None for i in selected])

selected_headers = [headers[i] for i in selected]

new_wb = Workbook()
new_ws = new_wb.active

if consolidate:
    parts = defaultdict(lambda: {'designators': [], 'data': None, 'quantity': 0})
    
    for row in data[1:]:
        if any(cell for cell in row):
            part_key = str(row[2]) if len(row) > 2 and row[2] else 'N/A'  # part number
            designator = str(row[1]) if len(row) > 1 and row[1] else ''  # designator
            
            parts[part_key]['designators'].append(designator)
            parts[part_key]['data'] = row
            parts[part_key]['quantity'] += 1
    
    new_ws.append(selected_headers + ["Quantity"])
    
    total_cost = 0
    for part_key, info in sorted(parts.items()):
        row = info['data'][:]
        if len(row) > 1:
            row[1] = ', '.join(sorted(info['designators']))
        
        for i, cell in enumerate(row):
            if isinstance(cell, (int, float)) and cell != 0 and len(row) > 3 and i == 3:
                total_cost += cell * info['quantity']
        
        new_ws.append(row + [info['quantity']])
    
    new_ws.append([])
    new_ws.append([f"Total BOM Cost: {currency}{total_cost:.2f}"])
else:
    new_ws.append(selected_headers)
    
    for row in data[1:]:
        if any(cell for cell in row):
            new_ws.append(row)

new_wb.save("BOM_consolidated.xlsx")
print("BOM saved to BOM_consolidated.xlsx")