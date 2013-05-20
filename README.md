# Puppetry

## Project Status
[![Code Climate](https://codeclimate.com/github/stefanozanella/puppetry.png)](https://codeclimate.com/github/stefanozanella/puppetry)
## Installation
Puppetry is currently shipped as a gem, so you just need to install it with:
~~~
$ gem install puppetry_toolbox
~~~
or, if you're using Bundler, set the following dependency line in your
`Gemfile`:
~~~
gem 'puppetry_toolbox'
~~~

## Usage
Puppetry can help you with the development of a Puppet module in many ways.
Let's look at each of them.

### Starting a new module
If you're to start development of a new module, you'll find that you need to
at least setup a proper directory structure. If you're going to test your
Puppet code (you **ARE** testing your Puppet code, aren't you?), you'll also
need to setup your project dependencies, test helper file, load path, etc.
Since this is almost all repeatable stuff, Puppetry ships with a command to
generate the scaffolding for a new module.

Let's pretend you want to start working on the `my_nice_module` module; then you just need to:
~~~
puppetry new my_nice_module
~~~
This will generate a `my_nice_module` subdirectory in the current working
directory. This directory will contain everything you need to start developing
your new module.
