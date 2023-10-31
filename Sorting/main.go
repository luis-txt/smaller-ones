package main

import (
	"fmt"
	"math/rand"
)

func main() {
	const l = 30
	arr := createNumbers(l)
	fmt.Println("Input: ", arr)
	var mergeArr [l]int
	res := mergesort(arr, mergeArr[:], 0, len(arr) - 1)
	fmt.Println("Output: ", res)
}

func createNumbers(length int) []int {
	arr := make([]int, length)

	for i := 0; i < length; i++ {
		arr[i] = rand.Intn(100)
	}
	return arr
}
