package utils

import (
	"encoding/xml"
)

type JMdict struct {
	XMLName xml.Name `xml:"JMdict"`
	Entries []Entry  `xml:"entry"`
}

type Entry struct {
	XMLName        xml.Name       `xml:"entry"`
	Sequence       int            `xml:"ent_seq"`
	ReadingElement ReadingElement `xml:"r_ele"`
	KElement       KElement       `xml:"k_ele"`
	Sense          Sense          `xml:"sense"`
}

type ReadingElement struct {
	XMLName xml.Name `xml:"r_ele"`
	Reb     string   `xml:"reb"`
}

type Sense struct {
	XMLName xml.Name `xml:"sense"`
	Glosses []string `xml:"gloss"`
}

type KElement struct {
	XMLName xml.Name `xml:"k_ele"`
	Keb     string   `xml:"keb"`
}
