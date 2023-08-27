package main

import (
	"fmt"
	"os"

	"github.com/ikawaha/kagome-dict/ipa"
	"github.com/ikawaha/kagome/v2/tokenizer"
)

func main() {
	t, err := tokenizer.New(ipa.Dict(), tokenizer.OmitBosEos())
	if err != nil {
		panic(err)
	}

	dat, err := os.ReadFile("./input.txt")
	if err != nil {
		panic(err)
	}

	sentence := string(dat)

	// wakati
	fmt.Println("---wakati---")
	seg := t.Wakati(sentence)
	for _, word := range seg {
		fmt.Println(word)
	}

	// tokenize
	// fmt.Println("---tokenize---")
	// tokens := t.Tokenize("すもももももももものうち")
	// for _, token := range tokens {
	// 	features := strings.Join(token.Features(), ",")
	// 	fmt.Printf("%s\t%v\n", token.Surface, features)
	// }
}
