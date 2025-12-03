from openpyxl import load_workbook
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

if consolidate:
    parts = defaultdict(lambda: {'designators': [], 'data': None, 'quantity': 0})
    
    for row in data[1:]:
        if any(cell for cell in row):
            part_key = str(row[2]) if len(row) > 2 and row[2] else 'N/A'  # part number
            designator = str(row[1]) if len(row) > 1 and row[1] else ''  # designator
            
            parts[part_key]['designators'].append(designator)
            parts[part_key]['data'] = row
            parts[part_key]['quantity'] += 1
    
    markdown = "# BOM (Bill of Materials) - Consolidated\n\n"
    markdown += "| " + " | ".join(selected_headers + ["Quantity"]) + " |\n"
    markdown += "|" + "------------|" * (len(selected_headers) + 1) + "\n"
    
    for part_key, info in sorted(parts.items()):
        row = info['data'][:]
        if len(row) > 1:
            row[1] = ', '.join(sorted(info['designators']))
        
        row_str = []
        for cell in row:
            if isinstance(cell, (int, float)) and cell != 0:
                row_str.append(f"{currency}{cell:.2f}")
            else:
                row_str.append(str(cell) if cell else 'N/A')
        markdown += "| " + " | ".join(row_str + [str(info['quantity'])]) + " |\n"
else:
    markdown = "# BOM (Bill of Materials)\n\n"
    markdown += "| " + " | ".join(selected_headers) + " |\n"
    markdown += "|" + "------------|" * len(selected_headers) + "\n"
    
    for row in data[1:]:
        if any(cell for cell in row):
            row_str = []
            for cell in row:
                if isinstance(cell, (int, float)) and cell != 0:
                    row_str.append(f"{currency}{cell:.2f}")
                else:
                    row_str.append(str(cell) if cell else 'N/A')
            markdown += "| " + " | ".join(row_str) + " |\n"

with open("BOM_consolidated.md", "w", encoding="utf-8") as f:
    f.write(markdown)

print("BOM saved to BOM_consolidated.md")