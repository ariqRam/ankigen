package utils

import (
	"fmt"
	"os"

	"github.com/ikawaha/kagome-dict/ipa"
	"github.com/ikawaha/kagome/v2/tokenizer"
)

func Tokenize(filepath string) []string {

	dat, err := os.ReadFile(filepath)
	if err != nil {
		panic(err)
	}
	sentence := string(dat)

	t, err := tokenizer.New(ipa.Dict(), tokenizer.OmitBosEos())
	if err != nil {
		panic(err)
	}

	// wakati
	fmt.Println("---wakati---")
	seg := t.Wakati(sentence)
	return seg
}
