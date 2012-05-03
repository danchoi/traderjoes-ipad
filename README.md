# Trader Joes on the iPad

This is a quick open source project that puts Trader Joe's Fearless Flyer and
Recipes on your iPad. It lets you navigate the content easily  using the iPad's
native scrolling table views.

## Setup

There is a Sinatra app under sinatra/ that serves as the RESTFUL API service
backend for the app. Before you start it, you have to generate the data it will
serve out by running these two scripts from the sinatra/ directory:

    ruby products.rb
    ruby recipes.rb

These will generate two YAML files that populate the app's navigation menus. 

Then start up the Sinatra service by running

    rackup -p 3010

Then build and run traderjoes_ipad.xcodeproj in XCode. 



