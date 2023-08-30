package utils

import (
	"fmt"
	"github.com/otiai10/gosseract/v2"
)

func Tessy() {
	client := gosseract.NewClient()
	defer client.Close()
	client.SetImage("path/to/image.png")
	text, _ := client.Text()
	fmt.Println(text)
	// Hello, World!
}
