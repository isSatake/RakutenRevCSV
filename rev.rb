require 'open-uri'
require 'nokogiri'

File.open("hoge.csv","w") do |file|
	file << "評価,レビュー"+"\n"
end

urls = 1 
pageEnd = 100
product = "YAMAHA+P32D+BU/40b5539567f5b97efaaf4ae9ff323722"
spl = "" 

while urls < pageEnd

	uri = "http://product.rakuten.co.jp/product/#{product}/review/#{urls}"
	doc = Nokogiri::HTML(open(uri))
	star = doc.css("span.txtPoint").text.unpack("a4a4a4a4a4a4a4a4a4a4a4a4a4a4a4a4a4a4a4a4a4a4a4a4a4a4a4a4a4a4")
	splitter = doc.css("div.revInfo").text.split(/\n\n/)
	
	number = 0
	while number < splitter.length do
		splitter[number] = splitter[number].gsub(/\n/,"")
		spl += splitter[number]
		if number != splitter.length-1 then 
			spl += "|"
		end
		number = number + 1
	end
	
	review = doc.css("div.rpsRevListLeft").text.gsub(/\n|[0-9]人が参考になったと回答/,"").split(/#{spl}/)	

	puts urls

	if star.length != review.length then
		break
	end

	num = 0
	while num < star.length do
		File.open("hoge.csv","a") do |csv|
			csv << star[num]+","+review[num]+"\n"
		end
		num = num + 1
	end

	urls = urls + 1
end
