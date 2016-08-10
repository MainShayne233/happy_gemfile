# HappyGemfile

House keep on your Gemfile no more! Happy Gemfile is here to clean up a small fraction of the clutter in your codebase by alphabetizing your gems!

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'happy_gemfile'
```

And then execute:

    $ bundle

Or install it yourself with:

    $ gem install happy_gemfile

## Usage

You can call the executable in the directory with the gemfile to be spruced up!
```bash
$ happy_gemfile
```

But nothing will happen without arguments!
```bash
happy_gemfile alphabetize # alphabetizes gems in place

happy_gemfile wipe_comments # clears all, non-inline, comments

happy_gemfile organize_groups # places gems tidily their specified group.

happy_gemfile all # one arg to call them all! (RECCOMMENDED)

```



Alternatively, you can call the alphabetize method directly in your app, say, in your config.rb.
```ruby
HappyGemfile.alphabetize
```


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
