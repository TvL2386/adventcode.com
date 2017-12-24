package main

import (
	"strings"
	"fmt"
	"strconv"
	"io/ioutil"
)

func readFile(file string) (string) {
	data, error := ioutil.ReadFile(file)
	if error != nil {
		panic(error)
	}

	return string(data)
}

func main() {
	sum := 0
	input := readFile("input")

	chars := strings.Split(input, "")

	for i := 0; i<len(chars); i++ {
		peekIndex := i+1

		if peekIndex == len(chars) {
			peekIndex = 0
		}

		if chars[i] == chars[peekIndex] {
			value, _ := strconv.Atoi(chars[i])
			sum += value
		}
	}

	fmt.Println(sum)
}