print("Hello World")

# Activate virtual environment
# Windows: Scripts/activate
# Mac/Linux: source venv/bin/activate

# Create a Scrapy project
# Command: scrapy startproject [project_name]

# Running a spider
# Command: scrapy crawl [spider_name]

# Using Scrapy Shell (Interactive shell to test selectors)
# Command: scrapy shell "https://quotes.toscrape.com/"

# CSS Selectors (Extracting data using CSS)
# Extracts list of title tags
# response.css("title::text").extract()
# Extracts all quote text elements
# response.css(".text::text").extract()
# Extracts all h2 text elements
# response.css("h2::text").extract()
# Extracts all tag text elements
# response.css(".tag::text").extract()

# XPath Selectors (Extracting data using XPath)
# Extracts the title tag
# response.xpath("//title").extract()
# Extracts the text inside the title tag
# response.xpath("//title/text()").extract()
# Extracts the quote text
# response.xpath("//span[@class='text']/text()").extract()
# Extracts the href attribute of the next page link
# response.css("li.next a").xpath("@href").extract()
# Extracts the href attribute of top ten tag links
# response.css("span.tag-item a").xpath("@href").extract()

# Item Containers (Storing Scraped Data)
# In `items.py`, declare a structure for the data you want to scrape using Scrapy's Item class:

'''
import scrapy

class QuoteItem(scrapy.Item):
    quote = scrapy.Field()
    author = scrapy.Field()
    tags = scrapy.Field()

# In your spider, yield an instance of the item object:
import scrapy
from myproject.items import QuoteItem

class QuotesSpider(scrapy.Spider):
    name = "quotes"
    start_urls = ['https://quotes.toscrape.com/']

    def parse(self, response):
        for quote in response.css("div.quote"):
            item = QuoteItem()
            item['quote'] = quote.css("span.text::text").get()
            item['author'] = quote.css("span small::text").get()
            item['tags'] = quote.css("div.tags a.tag::text").getall()
            yield item
'''


# Outputting Scraped Data to Different File Formats
# Command: scrapy crawl [spider_name] -o [output_filename].[extension]
# Supported extensions: .json, .xml, .csv
# Example:
# scrapy crawl quotes -o quotes.json (outputs JSON file)
# scrapy crawl quotes -o quotes.csv (outputs CSV file)
