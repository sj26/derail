# Railsex

Rails extensions. (Not _that_, you pervert.)

This is a collection of stuff I find myself doing in every single project.

Some of this stuff may graduate into gems or get contributed back to other projects.

## Features

* Generators:
  * `railsex:devise:haml`: Installs fully-localizable, HTML5, formtastic Devise HAML templates.
* Updated scaffold templates:
  * HTML5, formtastic scaffold HAML templates.
  * [Responder](https://github.com/rails/rails/tree/3-1-stable/actionpack/lib/action_controller/metal/responder.rb)-based scaffold controller.
* Helpers:
  * Activated link helper, adapted from a few places. Documentation coming.
  * Flashes helper, lists all your flashes in aside elements.
  * Text helper with *working* truncate_html using Hpricot.
* Vendored javascripts:
  * [modernizr](http://www.modernizr.com/).
  * [innershiv](http://jdbartlett.com/innershiv/) and [jQuery innershiv](http://tomcoote.co.uk/javascript/ajax-html5-in-ie/).
  * [jQuery autolink, mailto and highlight helpers](http://kawika.org/jquery/index.php?section=autolink), separated for leanness.
  * [jQuery.timeago](http://timeago.yarp.com/)
* Plenty more to come!

## Use

### Vendored javascripts

Add them to your applictation's javascript files using sprockets require directives, a la jQuery:

    //= require jquery_innershiv

### Generators

## Caveats

* It's Rails 3.1 only, but you should be basing your new projects on the latest and greatest! It'll be stable by the time you release... right?
* I'm presuming your using [my devise branch](https://github.com/sj26/devise/tree/template-inheritence):

        gem "devise", :git => "git://github.com/sj26/devise.git", :branch => "template-inheritence"

  If not, copy the HAML templates into your project and re-twiddle the footer partial.

## TODO

* Rails Builder.
* Home generator.
* Admin generator.
* Pages generator.
* Vendored WYSIWYG (can't decide which library).
* Formtastic WYSIWYG field helpers.
* Tilt-based renderable activerecord fields with filter white/blacklists and stored filter type.
* More tests.

## License

Copyright (c) 2011 Samuel Cochran, released under the MIT license, see LICENSE.
