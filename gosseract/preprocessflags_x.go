package gosseract

// #cgo CXXFLAGS: -std=c++0x
// #cgo LDFLAGS: -lleptonica -ltesseract
// #cgo CPPFLAGS: -Wno-unused-result
// #cgo darwin LDFLAGS: -L/usr/local/lib -lleptonica -ltesseract
// #cgo !darwin LDFLAGS: -L/usr/local/lib -lleptonica -ltesseract
import "C"
