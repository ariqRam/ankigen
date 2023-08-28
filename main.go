package main

import (
	"encoding/xml"
	"fmt"
	"io/ioutil"
	"os"

	"github.com/ramdhanyA/ankigen/utils"
)

func main() {

	xmlFile, err := os.Open("./JMdict_e.xml")

	if err != nil {
		panic(err)
	}

	defer xmlFile.Close()

	// processed := utils.Tokenize("./input.txt")

	// fmt.Println(processed)

	byteValue, _ := ioutil.ReadAll(xmlFile)
	var dict utils.JMdict

	err = xml.Unmarshal(byteValue, &dict)
	if err != nil {
		panic(err)
	}

	fmt.Println(dict.Entries)

	for i := 0; i < len(dict.Entries); i++ {
		fmt.Println(dict.Entries[i])
	}

	// tokenize
	// fmt.Println("---tokenize---")
	// tokens := t.Tokenize("すもももももももものうち")
	// for _, token := range tokens {
	// 	features := strings.Join(token.Features(), ",")
	// 	fmt.Printf("%s\t%v\n", token.Surface, features)
	// }
}
