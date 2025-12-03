from openpyxl import load_workbook
from collections import defaultdict
import os

def consolidate_bom(excel_file):
    wb = load_workbook(excel_file)
    ws = wb.active
    
    data = []
    for row in ws.iter_rows(values_only=True):
        if any(cell is not None for cell in row):
            data.append(row)
    
    if not data:
        return "No data found"
    
    # Group by part number
    parts = defaultdict(lambda: {'designators': [], 'description': '', 'price': 0, 'quantity': 0})
    
    for row in data[1:]:  # Skip header
        if len(row) > 12:
            designator = str(row[3]) if row[3] else ''
            part_number = str(row[8]) if row[8] else 'N/A'
            description = str(row[2]) if row[2] and row[2] != 'None' else 'N/A'
            price = row[12] if row[12] else 0
            
            parts[part_number]['designators'].append(designator)
            parts[part_number]['description'] = description
            parts[part_number]['price'] = price
            parts[part_number]['quantity'] += 1
    
    # Create consolidated markdown
    markdown = "# BOM (Bill of Materials) - Consolidated\n\n"
    markdown += "| Designators | Part Number | Description | Unit Price | Quantity | Total Price |\n"
    markdown += "|-------------|-------------|-------------|------------|----------|-------------|\n"
    
    total_cost = 0
    for part_number, info in sorted(parts.items()):
        designators = ', '.join(sorted(info['designators']))
        description = info['description'][:50] + "..." if len(info['description']) > 50 else info['description']
        unit_price = f"€{info['price']:.3f}" if info['price'] else 'N/A'
        quantity = info['quantity']
        total_price = f"€{info['price'] * quantity:.2f}" if info['price'] else 'N/A'
        
        if info['price']:
            total_cost += info['price'] * quantity
        
        markdown += f"| {designators} | {part_number} | {description} | {unit_price} | {quantity} | {total_price} |\n"
    
    markdown += f"\n**Total BOM Cost: €{total_cost:.2f}**\n"
    return markdown

# Run consolidation
excel_file = "BOM.xlsx"
markdown_file = "BOM_consolidated.md"

if not os.path.exists(excel_file):
    print(f"Error: {excel_file} not found in current directory")
    exit(1)

result = consolidate_bom(excel_file)

os.makedirs(os.path.dirname(os.path.abspath(markdown_file)), exist_ok=True)
with open(markdown_file, "w", encoding="utf-8") as f:
    f.write(result)

print(f"Consolidated BOM saved to {markdown_file}")