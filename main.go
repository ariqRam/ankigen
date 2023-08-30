package main

import (
	"bytes"
	"encoding/xml"
	"fmt"
	"io"
	"os"

	"github.com/ramdhanyA/ankigen/utils"
	"golang.org/x/exp/slices"
)

func main() {

	xmlFile, err := os.Open("./JMdict_e.xml")

	if err != nil {
		panic(err)
	}

	defer xmlFile.Close()

	processed := utils.Tokenize("./input.txt")

	fmt.Println(processed)

	byteValue, _ := io.ReadAll(xmlFile)
	var dict utils.JMdict

	d := xml.NewDecoder(bytes.NewReader(byteValue))
	d.Strict = false
	err = d.Decode(&dict)
	if err != nil {
		panic(err)
	}

	for _, element := range processed {
		idx := slices.IndexFunc(dict.Entries, func(e utils.Entry) bool { return e.KElement.Keb == element })
		if idx == -1 {
			continue
		}

		entry := dict.Entries[idx]

		fmt.Println(entry.KElement.Keb, entry.ReadingElement.Reb, entry.Sense.Glosses)
	}

}
