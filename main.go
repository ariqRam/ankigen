package main

import (
	"bytes"
	"encoding/xml"
	"fmt"
	"io"
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

	byteValue, _ := io.ReadAll(xmlFile)
	var dict utils.JMdict

	d := xml.NewDecoder(bytes.NewReader(byteValue))
	d.Strict = false
	err = d.Decode(&dict)
	if err != nil {
		panic(err)
	}

	fmt.Println(dict.Entries[206000])
}
