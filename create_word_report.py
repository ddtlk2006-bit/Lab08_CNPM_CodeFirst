import docx
from docx.shared import Inches, Pt, RGBColor
from docx.enum.text import WD_ALIGN_PARAGRAPH
from docx.enum.table import WD_TABLE_ALIGNMENT
from docx.oxml import OxmlElement, parse_xml
from docx.oxml.ns import nsdecls, qn

doc = docx.Document()

# Page setup
for section in doc.sections:
    section.top_margin = Inches(0.8)
    section.bottom_margin = Inches(0.8)
    section.left_margin = Inches(0.8)
    section.right_margin = Inches(0.8)

# Set Normal style
style_normal = doc.styles['Normal']
style_normal.font.name = 'Calibri'
style_normal.font.size = Pt(11)
style_normal.font.color.rgb = RGBColor(0x22, 0x22, 0x22)

with open('BAOCAO_LAB08_ASP_NET_CORE.md', 'r', encoding='utf-8') as f:
    lines = f.readlines()

in_code = False
code_lines = []
table_lines = []

def flush_table(t_lines):
    if not t_lines:
        return
    rows_data = []
    for l in t_lines:
        cells = [c.strip() for c in l.strip().strip('|').split('|')]
        # Skip separator row like |:---|:---|
        if any(set(c).issubset({':', '-'}) for c in cells):
            continue
        rows_data.append(cells)
    
    if not rows_data:
        return
        
    num_cols = max(len(r) for r in rows_data)
    table = doc.add_table(rows=len(rows_data), cols=num_cols)
    table.alignment = WD_TABLE_ALIGNMENT.CENTER
    table.style = 'Table Grid'
    
    for r_idx, row in enumerate(rows_data):
        for c_idx, cell_value in enumerate(row):
            if c_idx < num_cols:
                cell = table.cell(r_idx, c_idx)
                cell.text = cell_value
                if r_idx == 0:
                    shading_elm = parse_xml(r'<w:shd {} w:fill="D9E1F2"/>'.format(nsdecls('w')))
                    cell._tc.get_or_add_tcPr().append(shading_elm)
                    for p in cell.paragraphs:
                        for run in p.runs:
                            run.font.bold = True
    doc.add_paragraph()

for line in lines:
    raw = line.rstrip('\r\n')
    
    # Check table
    if raw.startswith('|') and raw.endswith('|'):
        table_lines.append(raw)
        continue
    else:
        if table_lines:
            flush_table(table_lines)
            table_lines = []

    if raw.startswith('```'):
        if in_code:
            in_code = False
            # Output code block
            t = doc.add_table(rows=1, cols=1)
            t.alignment = WD_TABLE_ALIGNMENT.CENTER
            cell = t.cell(0, 0)
            shd = parse_xml(r'<w:shd {} w:fill="F2F2F2"/>'.format(nsdecls('w')))
            cell._tc.get_or_add_tcPr().append(shd)
            p = cell.paragraphs[0]
            p.paragraph_format.space_before = Pt(4)
            p.paragraph_format.space_after = Pt(4)
            run = p.add_run('\n'.join(code_lines))
            run.font.name = 'Consolas'
            run.font.size = Pt(9.5)
            doc.add_paragraph()
            code_lines = []
        else:
            in_code = True
            code_lines = []
        continue

    if in_code:
        code_lines.append(raw)
        continue

    if raw.startswith('# '):
        h = doc.add_heading(raw[2:], level=1)
        h.paragraph_format.space_before = Pt(12)
        h.paragraph_format.space_after = Pt(6)
    elif raw.startswith('## '):
        h = doc.add_heading(raw[3:], level=2)
        h.paragraph_format.space_before = Pt(10)
        h.paragraph_format.space_after = Pt(4)
    elif raw.startswith('### '):
        h = doc.add_heading(raw[4:], level=3)
        h.paragraph_format.space_before = Pt(8)
        h.paragraph_format.space_after = Pt(2)
    elif raw.startswith('#### '):
        h = doc.add_heading(raw[5:], level=4)
        h.paragraph_format.space_before = Pt(6)
        h.paragraph_format.space_after = Pt(2)
    elif raw.startswith('- ') or raw.startswith('* '):
        doc.add_paragraph(raw[2:], style='List Bullet')
    elif raw.strip() == '---':
        p = doc.add_paragraph()
        p.paragraph_format.space_after = Pt(6)
        r = p.add_run('—' * 35)
        r.font.color.rgb = RGBColor(0xAA, 0xAA, 0xAA)
    elif raw.strip() == '':
        pass
    else:
        doc.add_paragraph(raw)

if table_lines:
    flush_table(table_lines)

doc.save('BAOCAO_LAB08_ASP_NET_CORE.docx')
print('Successfully saved BAOCAO_LAB08_ASP_NET_CORE.docx')

