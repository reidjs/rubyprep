# Running Rspec Tests

Let's get started on the first exercise. Navigate to the `exercises`
directory and open up `lib/00_hello.rb`; this is where you'll be
writing your code. Also open up `spec/00_hello_spec.rb`; this contains
the tests you want your code to pass.

### Watching Things Fail

Make sure you've navigated to the `exercises` directory in your terminal
and run the command `bundle exec rspec spec/00_hello_spec.rb`. You should
get a lovely error!

If you ended up with the not-so-lovely error `bundle: command not found`,
make sure you installed rspec as specified in the [previous reading][rspec]

Otherwise, go ahead and scroll to the top of output. You should see something
like this:

  ``` bash
  the hello function
    says hello (FAILED - 1)

  Failures:

    1) the hello function says hello
       Failure/Error: hello.should == "Hello!"
       NameError:
         undefined local variable or method `hello' for #<RSpec::Core::ExampleGroup::Nested_1:0x000001009b8808>
       # ./hello/hello_spec.rb:5:in `block (2 levels) in <top (required)>'

  ```

[rspec]: ./installing_rspec


We'll get started by running some rspec tests
and watching them fail horribly.
Head to your terminal and enter the command:
        bundle exec rspec spec/00_hello_spec.rb

You should get a lovely error!
If you get "bundle: command not found",
head back to the rspec reading and install rspec.

Otherwise, scroll to the top of the output,
and you should end up with something like this:


## Running RSpec Tests

All these commands should be run from the `exercises` folder.

To run all the specs for a day:

```sh
~$ bundle exec rspec
```

To run just one spec file, you can pass an [optional] filename argument:

```sh
~$ bundle exec rspec spec/00_hello_spec.rb
```

To run a single test (or a set of tests), you can append the line number
to the filename argument:

```sh
~$ bundle exec rspec spec/00_hello_spec.rb:105
```
