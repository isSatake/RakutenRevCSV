require 'open-uri'
require 'nokogiri'

#CSVの1行目を記述
File.open("hoge.csv","w") do |file|
	file << "評価,レビュー"+"\n"
end

#初期設定
product = "YAMAHA+P32D+BU/40b5539567f5b97efaaf4ae9ff323722"
page = 1 
pageEnd = 100
spl = "" 

while page < pageEnd

	#評価とレビュー本文を取得、配列に入れる
	uri = "http://product.rakuten.co.jp/product/#{product}/review/#{page}"
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

	puts page 

	#もし評価数とレビュー本文の数が合わない場合は処理を止める
	if star.length != review.length then
		break
	end

	#CSVに出力
	num = 0
	while num < star.length do
		File.open("hoge.csv","a") do |csv|
			csv << star[num]+","+review[num]+"\n"
		end
		num = num + 1
	end

	page = page + 1
end
