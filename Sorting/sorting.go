package main

func mergesort(arr []int, mergeArr []int, low, high int) {
	if low == high {
		return
	}
	p := low + (high - low) / 2

	mergesort(arr, mergeArr, low, p)
	mergesort(arr, mergeArr, p + 1, high)

	merge(arr, mergeArr, low, p, high)
}

func merge(arr, mergeArr []int, low, p, high int) {
	first := low
	second := p

	i := low
	for first < p && second < high {
		if arr[first] < arr[second] {
			mergeArr[i] = arr[first]
			first++
		} else {
			mergeArr[i] = arr[second]
			second++
		}
		i++
	}
	for first < p {
		mergeArr[i] = arr[first]
		first++
		i++
	}
	for second < high {
		mergeArr[i] = arr[second]
		second++
		i++
	}
	for i := low; i < high; i++ {
		arr[i] = mergeArr[i]
	}
}
