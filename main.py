import utils.dict as dict
import utils.ocr as ocr

for idx, expl in zip(range(1,5), dict.lookup("全部").find("sense").findall("gloss")):
    print(f"{idx} - {expl.text}")

print(ocr.read("hard-stock.png"))