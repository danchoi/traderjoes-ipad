# encoding: utf-8
require 'nokogiri'
require 'yaml'

start_url = "http://m.traderjoes.com/recipes/index.asp"
html = `curl -L -s '#{start_url}'`

doc = Nokogiri::HTML html, nil, 'UTF-8'

#   <a href="recipes-category.asp?cid=3">Breakfast</a>
#   <a href="recipes-category.asp?cid=2">Lunch</a>
#   <a href="recipes-category.asp?cid=4">Desserts</a>
#   <a href="recipes-category.asp?cid=1">Dinner</a>
#   <a href="recipes-category.asp?cid=5">Small Plates</a>

recipes = doc.search('a[@href^=recipes-category]').inject([]) {|m, a|
  category  = a.inner_text
  list_url = "http://m.traderjoes.com/recipes/#{a[:href]}"
  html2 = `curl -L -s '#{list_url}'`
  recipes = Nokogiri::HTML(html2, nil, 'ISO-8859-1').search('.recipelist a').map {|a2|
    title = a2.inner_text.strip
    url = "http://m.traderjoes.com/recipes/#{a2[:href]}"
    { name: title, url: url }
  }
  m << {name: category, items: recipes}
}

out = "recipes.yml"
File.open(out, 'w') {|f| f.puts recipes.to_yaml}
puts "Wrote results out to #{out}"

__END__


<a class="block" href="recipe.asp?rid=145">
<img class="rImg" src="http://www.traderjoes.com/images/recipes/145ThumbnailImage.jpg" alt="Coconut Milk Rice Pudding"><div class="rBottom">Coconut Milk Rice Pudding</div></a>
