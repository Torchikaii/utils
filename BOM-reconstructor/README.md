# BOM Reconstructor

## Quick Start

1. Install: `pip install openpyxl`
3. Place `BOM.xlsx` in this directory (rename BOM file if different name)
4. Run: `python consolidate_bom.py` (for Markdown) or `python consolidate_bom_excel.py` (for Excel)
5. Enter column indices: `[2,3,8,12]`
6. Enter currency: `$`
7. Consolidate? `y` or `n`

## About

Converts Altium Designer BOM Excel files to Markdown or consolidated Excel format with component consolidation.

## Features

- **Interactive column selection** - Choose which columns to export
- **Component consolidation** - Group identical components and combine designators
- **Currency formatting** - Apply custom currency symbols to price columns
- **Total cost calculation** - Automatic BOM cost summation
- **Dual output formats** - Markdown tables or Excel files

## Consolidation Logic

When consolidation is enabled, the system:

1. **Groups components** by exact column name match:
   - Primary: `Name` column
   - Fallback: `Manufacturer Part Number 1` column

2. **Combines designators** from the `Designator` column into comma-separated lists

3. **Calculates totals** using `Supplier Unit Price 1` column if present

4. **Adds quantity column** showing count of consolidated components

## Required Columns for Consolidation

- **`Name`** OR **`Manufacturer Part Number 1`** (component identifier)
- **`Designator`** (component references like R1, C2, etc.)
- **`Supplier Unit Price 1`** (optional, for cost calculation)

## Output Files

- **Markdown**: `BOM_consolidated.md`
- **Excel**: `BOM_consolidated.xlsx`

## Example

Input Excel with multiple rows for same component:
```
Name: RES_1K, Designator: R1
Name: RES_1K, Designator: R2
Name: RES_1K, Designator: R3
```

Consolidated output:
```
Name: RES_1K, Designator: R1, R2, R3, Quantity: 3
```