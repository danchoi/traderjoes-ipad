# encoding: utf-8
require 'yaml'
require 'nokogiri'

# script scrapes the website and generates a YAML

start_url = "http://www.traderjoes.com/fearless-flyer"
html = `curl -L -s '#{start_url}'`

start_doc = Nokogiri::HTML html, nil, 'UTF-8'

categories = start_doc.search('ul#category-list > li').
  inject([]) {|m, x|
    category_name = x.at("h3.category-title").inner_text
    items = x.search("li a").map {|a| 
      url = "http://m.traderjoes.com/fearless-flyer/#{a[:href]}"
      { name:  a.inner_text, url: url }
    }
    m << {name: category_name, items: items}
  }
out = "products.yml"
File.open(out, 'w') {|f| f.puts categories.to_yaml}
puts "Wrote results out to #{out}"
