package utils

import (
	"fmt"

	"github.com/ramdhanyA/ankigen/gosseract"
)

func Tessy() {
	client := gosseract.NewClient()
	err := client.SetTessdataPrefix("/opt/homebrew/share/tessdata")
	if err != nil {
		panic(err)
	}
	err = client.SetLanguage("jpn")
	fmt.Println(client)
	if err != nil {
		panic(err)
	}
	defer client.Close()
	client.SetImage("./hard-stock.png")
	text, err := client.Text()
	if err != nil {
		panic(err)
	}
	fmt.Println("OCR text is: ", text)
}
