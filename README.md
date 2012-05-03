# Trader Joes on the iPad

This is an open source iOS/Ruby project that puts Trader Joe's Fearless Flyer and
Recipes on your iPad. It lets you navigate the content easily  using the iPad's
native scrolling table views.

This project is still under development. More features are planned! If you're
interested in helping, climb aboard!


## Screenshots

![wine](https://github.com/danchoi/traderjoes-ipad/raw/master/screenshots/wine-sm.png)

![french-toast](https://github.com/danchoi/traderjoes-ipad/raw/master/screenshots/frenchtoast-sm.png)

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


## See Also

[Trader Joe's Fearless Flyer for the Kindle](http://kindlefeeder.com/traderjoes/index.html)


## MIT License

Copyright (c) 2012 Daniel Choi, http://danielchoi.com/software/

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
"Software"), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

