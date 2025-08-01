# dsa.rb
A CLI test suite to practice implementations of core algorithms in Ruby.

## Objective
Cement ability to implement core algorithms through repetition.

This test suite is not like LeetCode. In fact, it's more of a prerequisite to LeetCode.

The test cases are not exhaustive in the spirit of checking for runtime performance, 
scalability, etc. Implementations are generalized, so that through practice using this 
tool, the user can avoid having to think about the algorithmic pattern, and instead 
focus on its application to the problem at hand.

## Getting Started
1. `git clone` and `cd` into this repo
2. You may need to `chmod +x dsa.rb` to make dsa.rb executable
3. `dsa.rb init` to create empty files in imps/
4. By default, dsa.rb supports BFS, Binary Search, DFS, and two Sliding Window algorithms. 
Each file in imps/ should implement a single method with the following signatures:
    - *BFS*: a method named `bfs` receiving a `lib/test_helpers/node` and target value,
    returning the node containing the value equal to the target value or nil if not found
    - *Binary Search*: a method named `binary_search` receiving an array and a target value,
    returning the index of the array corresponding to the target value or nil if not found
    - *DFS*: a method named `dfs` receiving a `lib/test_helpers/node` and a target value,
    returning the node containing the value equal to the target value or nil if not found
    - *Fixed Sliding Window*: a method named `fixed_sliding_window` receiving an array and
    a window size, returning the maximum sum of any sub array with a length matching the
    window size
    - *Variable Sliding Window*: a method named `variable_sliding_window` receiving an array
    and a maximum sum, returning the greatest length of any subarray matching the maximum sum
5. Example implementations are available in example_imps/
6. Write your implementations! `vim imps/`
7. Run `dsa.rb` to test your implementations!

Tip - `Node` has two fields: `value` containing its value, and `neighbors` which is
an array of `Node` containing the node's neighbors.

## Usage:
- `dsa.rb [run|init|reset|restore|clean|help]`
    - `run` or no args runs the tests
    - `init` creates empty implementations in the imps/ directory. This will not override existing files.
    - `reset` archives current implementations to archive/ and replaces them with empty implementations
    - `restore` restores the most recently archived implementations
    - `clean` deletes the contents of the imps/ and archive/ directories
    - `help` print this message

The usage loop looks like this:

_write imps_

`dsa.rb`

`dsa.rb reset`

_repeat_

Start your day with `dsa.rb` if you're prepping for interviews. Try to get to the point
where you can implement all five default algorithms in less than 10 minutes!

## Extension
Add new algorithms to lib/tests using `test_template.rb` as a reference. `dsa.rb` 
will dynamically read from the lib/tests directory to create the empty implementation 
files and run their tests.

If you wish to contribute to dsa.rb itself: make your changes, update/add tests, ensure
they pass with `rake`, and open a pr.

## Structure
- lib/tests
    - Where files that run tests go
- lib/test_helpers
    - Helper module and utility classes for tests and implementations
- imps/
    - Where the implementations go. Empty starter files corresponding to lib/tests are dynamically created by `dsa.rb`
- archive/
    - Where archived implementations go, saved in directories named the date of archival
- test/
    - Tests for dsa.rb itself. Ran with `rake`

## Learning Ruby
If you're interested learning more about Ruby programming, I highly recommend the 
[pickaxe](https://pragprog.com/titles/ruby5/programming-ruby-3-3-5th-edition/).
