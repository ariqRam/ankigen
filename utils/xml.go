package utils

import (
	"encoding/xml"
)

type JMdict struct {
	XMLName xml.Name `xml:"JMdict"`
	Entries []Entry  `xml:"entry"`
}

type Entry struct {
	XMLName  xml.Name `xml:"entry"`
	Sequence int      `xml:"ent_seq"`
}
