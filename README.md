# ruby-dsa
A test suite to practice implementations of core algorithms in ruby.

## Usage
- `ruby dsa.rb [init|reset|restore]`
    - `init` creates empty implementations in the imps/ directory
    - `reset` archives current implementations to archive/ and replaces them with empty implementations
    - `restore` restores the most recently archived implementations

## Extension
Add to lib/tests using `test_template.rb` as a reference. ruby-dsa will dynamically 
read from the lib/tests directory to create the empty implementation files and run
their tests.

## Structure
- lib/tests
    - Where files that run tests go
- lib/test_helpers
    - Helper module and utility classes for tests and implementations
- imps/
    - Where the implementations go. Empty starter files are dynamically created by ruby-dsa
- archive/
    - Where archived implementations go, saved in directories named the date of archival.
