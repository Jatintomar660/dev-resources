print("Hello World")

# Activate virtual enviroment => Scripts/activate
# Create Project by scrapy startproject [project_name]
# Run spider => scrapy crawl [name of spider]

# Css selectors
# scrapy shell "https://quotes.toscrape.com/"
# response.css("title::text").extract()=> returns a list of title tags
# response.css(".text::text").extract()
# response.css("h2::text").extract()
# response.css(".tag::text").extract()

# Xpath
# response.xpath("//title").extract()
# response.xpath("//title/text()").extract()
# response.xapth("//span[@class='text']/text()").extract()
# response.css("li.next a").xpath("@href").extract() // in quotes to scrape
# response.css("span.tag-item a").xpath("@href").extract() // top ten tags

# Item container
# Declare strutre in item container and create item object in spider and 
# yield that object. 

# extension=.json,.xml,.csv
# scrapy crawl [spidername] -o [name o/p file].[extension]