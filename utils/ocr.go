package utils

import (
	"fmt"

	"github.com/ramdhanyA/ankigen/gosseract"
)

func Tessy() {
	client := gosseract.NewClient()
	defer client.Close()
	client.SetImage("./image.jpg")
	text, _ := client.Text()
	fmt.Println(text)
	// Hello, World!
}
