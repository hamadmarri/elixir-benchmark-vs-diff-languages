# Elixir Benchmark vs other languages

The test is Depth First Search **DFS** on order of integer numbers
from 1 to 10. Simply push to the stack next generation of numbers
and pull. This method test the performance of a language on the following: -

* Loop speed
* Pushing and pulling from a list / stack
* Check equality of two lists / arrays

The entropy is 10 numbers, and the maximum digits is 10. The current code
is after some optimization. First Elixir was faster than Go about 3x, until 
I changed the default slice capacity in Go. After that Go become faster by 2x.
So, it seems that the Go's slice initial capacity has much effects in performance.

Anyway, with final optimization on Elixir, Go, and Java, Elixir is in this test
is faster than Java by about 2x, and slower than Go by 1.3x

It is quite surprizing how Elixir is comparable with a complied language such
as Go. Next I am planning to test C++ or C to see how far we are from almost
optimum speed.

## Results

* Go average: 17.28828s ~17.3s
* Elixir average: 22089813us ~22.1s - 1.3x slower than Go
* Java average: 41.5353454s ~41.5s - 2.4x slower than Go and 1.9x slower than Elixir

## Summary
Even thought some benchmarks on the Internet shows that Elixir might be not fast on computation or calculation tasks, Elixir in the DFS test is almost as a compiled 
language. Notice that the test DFS in this example is simple. I like Elixir as a
beautiful Functional Programming and the fact that it is based on Erlang technology.
I was wishing before implementing GO that Elixir at least be slower no more than 4x
or at least a linear (not exponential) differences. I am surprized that Elixir/Erlang at least in this test shows that it is not a slow languages as usually shown in different benchmarks in the Internet. You can clone this repo and test. Please see
the full results, build/run commands in results.txt files. If you have any optimized
modification on either language please do not hesitate to Pull Request. Moreover, if
you like to share your benchmarks on your machine I will be happy to share it as well
as separate branch such as bench-yourname.

Thank you

Hamad


