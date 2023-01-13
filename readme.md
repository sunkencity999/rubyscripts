#Website Crawler
This script is a command-line utility for crawling a given website and saving its text content to a file on your system. It can also follow and crawl links within the website, and limit the number of links followed and crawled.

##Usage
To use the script, run the following command:

$ ruby webcrawler.rb crawl [URL] [OPTIONS]
Where [URL] is the website you want to crawl and [OPTIONS] are optional arguments.

Options
-l, --limit [LIMIT]: The maximum number of links to follow and crawl (default: 10)
###Features
-Crawl a website and save its text content to a file
-Follow and crawl links within the website
-Limit the number of links followed and crawled
-Extract text content within the <body> tag of the documents
-Keep track of visited links and avoid duplicate crawling
-Print the number of links present and the number of links crawled
-Progress bar for monitoring the crawling process
-file name of the saved text content contains website name and date


##Dependencies
-Nokogiri
-Thor
-Ruby-progressbar
-Net::HTTP
-Open-uri
-Date
-Note

It is important to note that crawling a website without permission from the website's owner may be a violation of the website's terms of service. Please make sure that you have the necessary permissions before using this script.

###Contribution
Feel free to contribute to this script by submitting pull requests with new features or bug fixes.

###Created by Christopher Bradford | theroyalart@gmail.com
