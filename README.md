# RakutenRevCSV
楽天プロダクト内の商品レビューを取得して CSV に出力するスクリプトです。

## 使い方
urls.yaml にレビューを取得したい楽天プロダクト商品ページ ID を列挙します。(商品ページ ID は、商品ページ URL(http://product.rakuten.co.jp/product/hoge/fuga/)の"hoge/fuga"です。)

page に取得開始ページ数、pageEnd に終了ページ数を入れます。

`ruby rev.rb` すると hoge.csv に出力します。

## 備考
大学のテキストマイニングの授業で大量の文章をスクレイピングする必要があり、これを製作しました。

出力した CSV を MS-Excel で扱う必要があったため、出力データを Windows-31J でエンコードしています。
