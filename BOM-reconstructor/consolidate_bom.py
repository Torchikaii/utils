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

data = []
for row in ws.iter_rows(values_only=True):
    if any(cell is not None for cell in row):
        data.append([row[i] if i < len(row) else None for i in selected])

selected_headers = [headers[i] for i in selected]
parts = defaultdict(lambda: {'rows': [], 'quantity': 0})

for row in data[1:]:
    if any(cell for cell in row):
        key = str(row[0]) if row[0] else 'N/A'
        parts[key]['rows'].append(row)
        parts[key]['quantity'] += 1

markdown = "# BOM (Bill of Materials) - Consolidated\n\n"
markdown += "| " + " | ".join(selected_headers + ["Quantity"]) + " |\n"
markdown += "|" + "------------|" * (len(selected_headers) + 1) + "\n"

for key, info in sorted(parts.items()):
    row = info['rows'][0]
    row_str = []
    for cell in row:
        if isinstance(cell, (int, float)) and cell != 0:
            row_str.append(f"{currency}{cell:.2f}")
        else:
            row_str.append(str(cell) if cell else 'N/A')
    markdown += "| " + " | ".join(row_str + [str(info['quantity'])]) + " |\n"

with open("BOM_consolidated.md", "w", encoding="utf-8") as f:
    f.write(markdown)

print("Consolidated BOM saved to BOM_consolidated.md")