import xml.etree.ElementTree as ET

tree = ET.parse('JMdict_e.xml')
root = tree.getroot()

def lookup(word: str):
    for entry in root.findall("entry"):
        try:
            if entry.find('k_ele').find('keb').text == word:
                return entry
        except AttributeError:
            continue