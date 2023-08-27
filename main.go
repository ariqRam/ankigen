package main

import (
	"fmt"
	"os"
	"strings"

	"github.com/ikawaha/kagome-dict/ipa"
	"github.com/ikawaha/kagome/v2/tokenizer"

	"foosoft.net/projects/jmdict"
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
	fmt.Println(seg)

	reader := strings.NewReader("東京")

	dict, res, err := jmdict.LoadJmdict(reader)

	if err != nil {
		panic(err)
	}
	fmt.Println(dict)
	for k, v := range res {
		fmt.Println(k, "value is", v)
	}

	// tokenize
	// fmt.Println("---tokenize---")
	// tokens := t.Tokenize("すもももももももものうち")
	// for _, token := range tokens {
	// 	features := strings.Join(token.Features(), ",")
	// 	fmt.Printf("%s\t%v\n", token.Surface, features)
	// }
}
