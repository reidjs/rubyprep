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
make sure you installed rspec as specified in the [previous reading][rspec].

[rspec]: ./installing_rspec

Otherwise, let's take a look at the output. At the bottom, you should see
something like this:

  ``` bash
  Finished in 0.00186 seconds (files took 0.14132 seconds to load)
  3 examples, 3 failures

  Failed examples:

  rspec ./spec/00_hello_spec.rb:106 # the hello function says hello
  rspec ./spec/00_hello_spec.rb:112 # the greet function says hello to someone
  rspec ./spec/00_hello_spec.rb:116 # the greet function says hello to someone else
  ```
This is a summary of the rspec tests. We can see that there were three tests,
and we failed all of them. At the bottom, it specifies which tests we failed.
This is a nice overview, but if you want to see what actually went wrong, you'll
have to scroll to the top. You should see this error:

  ``` bash
  1) the hello function says hello
     Failure/Error: expect(hello).to eq("Hello!")
     NameError:
       undefined local variable or method `hello' for #<RSpec::ExampleGroups::TheHelloFunction:0x000000016b1920>
     # ./spec/00_hello_spec.rb:5:in `block (2 levels) in <top (required)>'
  ```

So, what can we tell from this error message?
0. We wanted the `hello` function to say hello.
0. Specifically, we expected it to output the string `"Hello!"`
0. It didn't, ie, we had a failure/error. Good.
0. `hello` was undefined
0. The actual test can be found in the `00_hello_spec.rb` file on line 5

Might seem like a lot of info for such a little test, but once we move on
to more complicated code, you'll want to understand each of these lines
quite thoroughly.

Let's play around with this a bit. In `00_hello.rb`, go ahead and
define a `hello` method. We want it to say hello, right? Try this:

  ``` Ruby
  def hello
    "hello"
  end
  ```
Then run `bundle exec rspec spec/00_hello_spec.rb` again. This time,
you should see an error like so:

  ``` bash
  1) the hello function says hello
       Failure/Error: expect(hello).to eq("Hello!")

         expected: "Hello!"
              got: "hello"

         (compared using ==)
       # ./spec/00_hello_spec.rb:5:in `block (2 levels) in <top (required)>'
  ```

Right, of course. See what the spec actually wanted? You may well
have known better; but half the time, our specs will fail because
of silly oversights like this. Good to get used to it.

Go ahead and fix up your code, then run the spec again. You shouldn't
be getting that error message any more! Hopefully, you'll have something
like this now:

  ``` bash
  Finished in 0.00187 seconds (files took 0.13949 seconds to load)
  3 examples, 2 failures

  Failed examples:

  rspec ./spec/00_hello_spec.rb:112 # the greet function says hello to someone
  rspec ./spec/00_hello_spec.rb:116 # the greet function says hello to someone else
  ```

Feels good, yeah?

Let's move on to the next specs: Looks like we have two specs for the `greet`
function that aren't passing. Again, we'll take some time to screw things up;
it's super important to understand how things go wrong.

If you look at the spec details, you'll see that we want the `greet` function
to say `"Hello, Alice!"`. Let's go ahead and write that method...

``` Ruby
def greet
  "Hello, Alice!"
end
```

...and run rspec again. You should see this error:

``` bash
1) the greet function says hello to someone
   Failure/Error: expect(greet("Alice")).to eq("Hello, Alice!")
   ArgumentError:
     wrong number of arguments (given 1, expected 0)
   # ./lib/00_hello.rb:10:in `greet'
   # ./spec/00_hello_spec.rb:11:in `block (2 levels) in <top (required)>'
```

There's a couple things to notice here. First up, let's look at those
bottom two lines. They're what we call the "stack trace," all of the
methods that led up to our error. The topmost is where the error was
encountered; the line below it is where that method was called from,
and so forth. This helps us pinpoint our error and trace back to where
it originated.

In this case, what was that error? `wrong number of arguments (given 1,
expected 0)`. This means that the test tried to pass an argument to
our method, but our method didn't want to accept any arguments. Error!

If we hop over to line 10 in `00_hello.rb`, we can fix that up:

``` Ruby
def greet(someone)
  "Hello, Alice!"
end
```




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
