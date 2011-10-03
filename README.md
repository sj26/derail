# Derail

A collection of helpers and libraries which I use in almost every project, and a generator to get started quickly.

Some of this stuff may graduate into gems or get contributed back to other projects.

## Features

* Generators:
  * `derail:app`: Derails a new rails project, basically doing all the following:
    * Configure databases:
      * development: _APPNAME_\_development/development/development
      * test: _APPNAME_\_test/test/test
      * production: read from environment (DATABASE/DATABASE\_USERNAME/DATABASE\_PASSWORD).
    * Configure ActionMailer:
      * development: default\_url\_options to `_APPNAME_.dev`, [MailCatcher](https://github.com/sj26/mailcatcher) delivery.
      * test: default\_url\_options to `_APPNAME_.test`.
    * Makes SASS the default stylesheet syntax (not SCSS) and converts application.css to application.css.sass.
    * Converts application.js to application.js.coffee.
    * Installs [RSpec](http://rspec.info/)
    * Installs [Cucumber](http://cukes.info/)
    * Installs [RR](https://github.com/btakita/rr)
    * Installs [Guard](https://github.com/guard/guard) ([ego](https://github.com/guard/guard-ego), [bundler](https://github.com/guard/guard-bundler), [rspec](https://github.com/guard/guard-rspec), [cucumber](https://github.com/guard/guard-cucumber))
    * Runs `formtastic:install`
    * Runs `derail:devise`
    * Removes default `index.html` and `rails.png`
  * `derail:devise`: Install devise, setup a user, install [remarkable_devise](https://github.com/sj26/remarkable_devise).
  * `derail:devise:haml`: Installs fully-localizable, HTML5, formtastic Devise HAML templates.
* Updated scaffold templates:
  * HTML5, formtastic scaffold HAML templates.
  * [Responder](https://github.com/rails/rails/tree/3-1-stable/actionpack/lib/action_controller/metal/responder.rb)-based scaffold controller.
* Helpers:
  * Activated link helper, adapted from a few places. Documentation coming.
  * Flashes helper, lists all your flashes in aside elements.
* Vendored javascripts:
  * [modernizr](http://www.modernizr.com/).
  * [innershiv](http://jdbartlett.com/innershiv/) and [jQuery innershiv](http://tomcoote.co.uk/javascript/ajax-html5-in-ie/).
  * [jQuery autolink, mailto and highlight helpers](http://kawika.org/jquery/index.php?section=autolink), separated for leanness.
  * [jQuery.timeago](http://timeago.yarp.com/)
* Plenty more to come!

## Use

To create a new app, I run:

    rails new APPNAME --skip-test-unit --skip-bundle --database=postgresql --template http://sj26.com/derail

For handyness in [zsh](http://zsh.org):

    function derail() { rails new $1 --skip-test-unit --skip-bundle --database=postgresql --template http://sj26.com/derail $@[2,-1] }

then

    derail APPNAME

You need to skip bundling due to a clash between rails and bundlers' vendored versions of the thor gem.

### Vendored javascripts

Add them to your applictation's javascript files using sprockets require directives, a la jQuery:

    //= require jquery_innershiv

## Caveats

* It's Rails 3.1 only, but you should be basing your new projects on the latest and greatest! It'll be stable by the time you release... right?
* I'm presuming your using [my devise branch](https://github.com/sj26/devise/tree/template-inheritence):

        gem "devise", :git => "git://github.com/sj26/devise.git", :branch => "template-inheritence"

  If not, copy the HAML templates into your project and re-twiddle the footer partial.

## TODO

* Home generator.
* Admin generator.
* Admin scaffold generator.
* Pages generator.
* (Some) in-app errors handler generator.
* Page title helper inspired by [page\_title\_helper](https://github.com/lwe/page_title_helper)
* Vendored WYSIWYG (can't decide which library).
* Formtastic WYSIWYG field helpers.
* Tilt-based renderable activerecord fields with filter white/blacklists and stored filter type.
* More tests.

## License

Copyright (c) 2011 Samuel Cochran, released under the MIT license, see LICENSE.
