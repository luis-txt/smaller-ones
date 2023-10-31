package main

import (
	"math/rand"
	"testing"
)

func TestMergesort(t *testing.T) {
	const l = 100000000
	t.Log("Creating ", l, " numbers...")
	arr := createNumbers(l, l)
	//fmt.Println("Input: ", arr)
	t.Log("Sorting numbers...")
	var mergeArr [l]int
	res := mergesort(arr, mergeArr[:], 0, len(arr) - 1)
	//fmt.Println("Output: ", res)
	t.Log("Checking numbers...")
	sorted := isSorted(res)
	if !sorted {
		t.Errorf("Not sorted correctly!")
	} else {
		t.Log("Is sorted correctly!")
	}
}

func BenchmarkMergesort(b *testing.B) {
	for i := 0; i < b.N; i++ {
		b.StartTimer()
		arr := createNumbers(b.N, b.N)
		mergeArr := make([]int, b.N)
		b.StartTimer()
		res := mergesort(arr, mergeArr[:], 0, len(arr) - 1)
		b.StopTimer()
		sorted := isSorted(res)
		if !sorted {
			b.Errorf("Not sorted correctly!")
		}
	}
}

func createNumbers(length, max int) []int {
	arr := make([]int, length)

	for i := 0; i < length; i++ {
		arr[i] = rand.Intn(max)
	}
	return arr
}

func isSorted(arr []int) bool {
	for i, e := range arr[:len(arr) - 1] {
		if e > arr[i + 1] {
			return false
		}
	}
	return true
}
