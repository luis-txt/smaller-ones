package main

func mergesort(arr []int, mergeArr []int, low, high int) []int {
	if low == high {
		return arr
	}
	p := low + (high - low) / 2

	mergesort(arr, mergeArr, low, p)
	mergesort(arr, mergeArr, p + 1, high)

	merge(arr, mergeArr, low, p, high)

	return arr
}

func merge(arr, mergeArr []int, low, p, high int) {
	first := low
	second := p + 1

	i := low
	for first < p + 1 && second < high + 1 {
		if arr[first] < arr[second] {
			mergeArr[i] = arr[first]
			first++
		} else {
			mergeArr[i] = arr[second]
			second++
		}
		i++
	}
	for first < p + 1 {
		mergeArr[i] = arr[first]
		first++
		i++
	}
	for second < high + 1 {
		mergeArr[i] = arr[second]
		second++
		i++
	}
	for i := low; i < high + 1; i++ {
		arr[i] = mergeArr[i]
	}
}
