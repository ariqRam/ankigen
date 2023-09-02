import xml.etree.ElementTree as ET

tree = ET.parse('JMdict_e.xml')
root = tree.getroot()

# print(root[1000].find("sense").find("gloss").text)

def lookup(word: str):
    for entry in root.findall("entry"):
        try:
            if entry.find('k_ele').find('keb').text == word:
                return entry
        except AttributeError:
            continue

for idx, expl in zip(range(1,5), lookup("全部").find("sense").findall("gloss")):
    print(f"{idx} - {expl.text}")