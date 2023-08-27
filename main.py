import MeCab

input = open("./input.txt", "r").read()

wakati = MeCab.Tagger("-Owakati")
result = wakati.parse(input)


print(result)
