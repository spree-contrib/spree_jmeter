Spree JMeter Benchmarks
=======================

We wanted to release them so you can reproduce what we did and run your own tests.

Running the Tests
-----------------

The tests use the [ruby-jmeter](https://github.com/flood-io/ruby-jmeter) gem to
write a JMeter test plan which is then sent to [flood.io](http://flood.io). You
can set up your own JMeter install if you'd prefer, but flood is a great way to
get to the testing without messing around with setting up infrastructure.

Fork the repo and setup your environment:
```
$ git clone https://github.com/spree-contrib/spree_jmeter.git
$ cd spree_jmeter
$ bundle install
```

If you're using flood, then you'll need to sign up and get your API token. You
can get that by going to [your flood settings page](https://flood.io/dashboard/settings)
and copying the token.

```
$ export FLOOD_IO_KEY=<your flood.io key>
```

Now you'll need to have a [Spree](http://spreecommerce.com) install with
the sample data loaded to point the test script at. We've got [a
sandbox](https://github.com/spree/spree) which you can fork and work
with. Instructions for setup are in that repo.

Once you've got your app running, time to point your flood at the app. Make sure
you've got a grid started in the region that you're going to flood from. If you
don't, you'll get a 400 error.

```
$ bundle exec ruby bin/spree_test.rb flood <DOMAIN> --users=200 --ramp=60 \
                                                 --length=300 --region=us-west-1 --name="My Test"
```
Note that DOMAIN should not contain http:// or the trailing /.

If all went well, you should see a URL to your flood and you can watch it go and
see your results. We recommend setting the Apdex settings in flood.io to
something no more than 750ms for Satisfied and 3000ms for Tolerating.

Using JMeter Locally Instead of Flood.io
----------------------------------------

```
brew install jmeter --with-plugins
bundle exec ruby bin/spree_test.rb jmeter <DOMAIN> --users=200 --ramp=60 \
                                                 --length=300 --name="My Test"
```

Writing Your Own
----------------

We're working on a better API at the moment, but for now here are the steps to
create your own tests:

1. Copy `lib/spree_performance/tests/example.rb` and name it after your app (eg.
   `my_app.rb`)
2. Open your new test and rename the class `Example` to your app (eg. MyApp)
3. Using the [ruby-jmeter](https://github.com/flood-io/ruby-jmeter) DSL,
   write a test plan to simulate users.
4. Create a new script in `bin` by copying `bin/example_test.rb` to something named
   after your app (eg. `bin/my_app_test.rb`)
5. Replace `require_relative '../lib/spree_performance/tests/example'` with the path
   to your new test
6. Replace `Example` with your class (`eg.
   SpreePerformance::Tests::MyApp.new`)
7. Run your tests like the example for spree:

```
$ bundle exec bin/my_app_test.rb <DOMAIN> --users=200 --ramp=60 --length=300 \
                                         --region=us-west1 --name 'MyApp Test'
```

Contributing
------------

In the spirit of [free software](http://www.fsf.org/licensing/essays/free-sw.html), **everyone** is encouraged to help improve this project.

Here are some ways *you* can contribute:

* by using prerelease versions
* by reporting [bugs](https://github.com/spree-contrib/spree_jmeter/issues)
* by suggesting new features
* by [translating to a new language](https://github.com/spree-contrib/spree_jmeter/tree/master/config/locales)
* by writing or editing documentation
* by writing specifications
* by writing code (*no patch is too small*: fix typos, add comments, clean up inconsistent whitespace)
* by refactoring code
* by resolving [issues](https://github.com/spree-contrib/spree_jmeter/issues)
* by reviewing patches
