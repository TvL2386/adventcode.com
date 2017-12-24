package main

import (
	"io/ioutil"
	"strings"
	"fmt"
	"strconv"
)

func main() {
	data, error := ioutil.ReadFile("input")

	if error != nil {
		panic(error)
	}

	input := string(data)
	lines := strings.Split(input, "\n")
	sum := 0

	for _, line := range lines {
		items := strings.Split(line, "\t")
		min, max := 0, 0

		for index, item := range items {
			number, _ := strconv.Atoi(item)

			if index == 0 {
				min = number
				max = number
			} else if number < min {
				min = number
			} else if number > max {
				max = number
			}
		}

		sum += max-min
	}

	fmt.Println(sum)
}