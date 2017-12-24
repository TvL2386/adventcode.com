package main

import (
	"strings"
	"fmt"
	"strconv"
	"io/ioutil"
)

func main() {
	data, error := ioutil.ReadFile("input")

	if error != nil {
		panic(error)
	}

	input := string(data)
	sum := 0

	chars := strings.Split(input, "")
	offset := len(chars) / 2

	for i := 0; i<len(chars); i++ {
		peekIndex := i + offset

		if peekIndex >= len(chars) {
			peekIndex -= len(chars)
		}

		if chars[i] == chars[peekIndex] {
			value, _ := strconv.Atoi(chars[i])
			sum += value
		}
	}

	fmt.Println(sum)
}