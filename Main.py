import random

def generate_svg():
    # Define as constantes para configurar a imagem
    WIDTH = 1920
    HEIGHT = 1080

    # Inicia o arquivo SVG
    svg = f'<svg width="{WIDTH}" height="{HEIGHT}"\n'
    svg += 'xmlns="http://www.w3.org/2000/svg" version="1.1">\n'

    # Gera elementos aleatórios e adiciona-os ao arquivo SVG
    for i in range(random.randint(1, 1000)):
        x = random.randint(0, WIDTH)
        y = random.randint(0, HEIGHT)
        element_type = random.choice(['circle', 'rect', 'line'])
        color = ''.join([random.choice('0123456789ABCDEF') for j in range(6)])
        if element_type == 'circle':
            r = random.randint(1, min(WIDTH, HEIGHT)/5)
            svg += f'<circle cx="{x}" cy="{y}" r="{r}" fill="#{color}"/>\n'
        elif element_type == 'rect':
            w = random.randint(1, min(WIDTH, HEIGHT)/5)
            h = random.randint(1, min(WIDTH, HEIGHT)/5)
            svg += f'<rect x="{x}" y="{y}" width="{w}" height="{h}" fill="#{color}"/>\n'
        elif element_type == 'line':
            x2 = random.randint(0, WIDTH)
            y2 = random.randint(0, HEIGHT)
            svg += f'<line x1="{x}" y1="{y}" x2="{x2}" y2="{y2}" stroke="#{color}"/>\n'

    # Fecha o arquivo SVG
    svg += '</svg>'

    # Escreve o arquivo SVG
    with open('output.svg', 'w') as f:
        f.write(svg)

generate_svg()