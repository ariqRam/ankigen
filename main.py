import xml.etree.ElementTree as ET

tree = ET.parse('JMdict_e.xml')
root = tree.getroot()

print(root[1000].find("sense").find("gloss").text)