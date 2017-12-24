package main

import (
	"io/ioutil"
	"strings"
	"fmt"
	"strconv"
)

type spreadsheetRow struct {
	numbers []int
}

func (s *spreadsheetRow) result() int {
	for index, number := range s.numbers {
		for index2, number2 := range s.numbers {
			if index == index2 {
				continue
			}

			if number % number2 == 0 {
				return number / number2
			}
		}
	}

	return 0
}


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

		numbers := make([]int, len(items))

		for index, item := range items {
			numbers[index], _ = strconv.Atoi(item)
		}

		s := spreadsheetRow{numbers: numbers}
		sum += s.result()

	}

	fmt.Println(sum)
}