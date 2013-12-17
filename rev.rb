# encoding:Windows-31J
require 'yaml'
require 'open-uri'
require 'nokogiri'

#CSVの1行目を記述
index = "star,age,sex,review"
index.encode("Windows-31J")
File.open("hoge.csv","w") do |file|
	file << index+"\n" 
end

#URLリストを読み込み
products = YAML.load_file('urls.yml')
products.each do |product|

	#初期設定
	page = 1 
	pageEnd = 100

	#評価とレビュー本文を取得、配列に入れる
	while page < pageEnd
		starArray = Array[] 
		ageArray = Array[]
		sexArray = Array[]
		reviewArray = Array[]
		uri = "http://product.rakuten.co.jp/product/#{product}/review/#{page}"
		doc = Nokogiri::HTML(open(uri))
		rpsRevListLeft = doc.css(".rpsRevListLeft")
		rpsRevListLeft.each do |content|	
			starArray << content.css("span.txtPoint").text
			reviewArray << content.css(".revTxt").text.gsub(/\n/,"")
			ageArray << content.css(".revAges").text.slice(1,3)
			sexArray << content.css(".revAges").text.slice(5,2)

		end

		#nilを文字列に置換
		for int in 0..30 do
			unless ageArray[int] then
				ageArray[int] = "nothing" 
				sexArray[int] = "nothing"	
			end
		end

		puts page 

		#もし評価数とレビュー本文の数が合わない場合は処理を止める
		if starArray.length == 0 && reviewArray.length == 0 then
			break
		end

		#CSVに出力
		num = 0
		while num < starArray.length do
			File.open("hoge.csv","a:Windows-31J") do |file|
				file << starArray[num]+","+ageArray[num]+","+sexArray[num]+","+reviewArray[num]+"\n"
			end
			num = num + 1
		end

		page = page + 1
	end
end
