package main

import (
	"fmt"
	"time"
)

type Stack [][]int

const entropy = 10
const max_digit = 10

func (s *Stack) IsEmpty() bool {
	return len(*s) == 0
}

func (s *Stack) Push(e []int) {
	*s = append(*s, e)
}

func (s *Stack) Pop() []int {
	index := len(*s) - 1
	element := (*s)[index]
	*s = (*s)[:index]
	return element
}

func init_ch(s *Stack) {
	for i := 1; i <= entropy; i++ {
		e := make([]int, 1)
		e[0] = i
		s.Push(e)
	}
}

func is_solution(item []int, solution []int) bool {
	if len(item) != len(solution) {
		return false
	}
	for i, v := range item {
		if v != solution[i] {
			return false
		}
	}
	return true
}

func gen_ch(s *Stack, parent_items []int, stat int) int {

	if len(parent_items) >= max_digit {
		// fmt.Println("max digit")
		return stat
	}

	for i := 1; i <= entropy; i++ {
		ch := make([]int, 1, 11) //, len(parent_items)+1)
		ch[0] = i
		ch = append(ch, parent_items...)
		// fmt.Printf("ch %v\n", ch)

		// fmt.Printf("ch after append %v\n", ch)
		s.Push(ch)
	}
	// fmt.Printf("current stack %v\n", s)

	return stat + entropy
}

func solve(s *Stack, solution []int, stat int) {
	for {
		// fmt.Printf("current stack %v\n", s)
		if s.IsEmpty() {
			fmt.Printf("q IS EMPTY!, QUITTING!, count: %d\n", stat)
			return
		}

		item := s.Pop()
		// fmt.Printf("solving %v\n", item)

		if is_solution(item, solution) {
			fmt.Printf("FOUND A SOLUTION %v, count: %d\n", item, stat)
			return
		}

		stat = gen_ch(s, item, stat)
		// solve(s, solution, stat)
	}
}

func main() {
	for i := 0; i < 10; i++ {
		var stack Stack
		solution := []int{7, 7, 7, 7, 7, 7, 7, 5, 10}

		s := time.Now().UnixMicro()
		init_ch(&stack)
		fmt.Printf("init stack %v \n", stack)

		solve(&stack, solution, len(stack))
		e := time.Now().UnixMicro()
		df := float64(e-s) / 1000 / 1000

		fmt.Printf("time: %fs\n", df)
	}
}
