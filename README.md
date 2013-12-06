# RakutenRevCSV
楽天プロダクト内の商品レビューを取得して CSV に出力するスクリプトです。

## 使い方
product に楽天プロダクト商品ページ ID を入れます。(商品ページ ID は、商品ページ URL(http://product.rakuten.co.jp/product/hoge/)の"hoge"です。)

page に取得開始ページ数、pageEnd に終了ページ数を入れます。

`ruby rev.rb` すると hoge.csv に出力します。

## 備考
大学のテキストマイニングの授業で大量の文章をスクレイピングする必要がありこれを作りました。
