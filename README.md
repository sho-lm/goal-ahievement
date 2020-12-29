# Goal-achievement
====

## 概要
簡単な目標管理アプリです。<br>
自分で目標を設定し、それを実行した時間の記録をつけます。<br>
どの目標をどれだけ頑張ったかの記録をグラフとして確認することができます。<br>

<a href="http://ec2-52-199-23-50.ap-northeast-1.compute.amazonaws.com">デモページ</a><br>
ログインが必要なので &lt;ユーザー = test, パスワード = aaaa&gt; でログインしてください。

## 機能紹介
<b>・グラフ画面</b><br>
自分が記録した勉強などの時間をグラフで確認できます。<br>
グラフをする表示単位を月ごとに変更したり(画面左上)、設定している目標ごとに非表示にしたりできます(画面右上)。
![report-page](https://user-images.githubusercontent.com/42924818/103174123-e6433c80-48a2-11eb-8505-239648fdfacb.png)

<b>・目標設定画面</b><br>
目標ごとに目標名とグラフの色を設定できます。<br>
追加するときは青色の＋ボタンを押してください(画面右上)。
![目標設定画面](https://user-images.githubusercontent.com/42924818/103284569-eb2cfb00-4a1e-11eb-90f8-be0bc25f9c42.png)
削除したいときは－ボタンを押すと表示される赤いゴミ箱ボタンを押してください(画面右上)。
![目標設定画面2](https://user-images.githubusercontent.com/42924818/103284886-d69d3280-4a1f-11eb-95d1-f7d577e14002.png)

<b>・記録画面</b><br>
目標に対して実行した時間を記録することができます。<br>
実行した時間は設定しないことも可能ですが、その場合はグラフには表示されません。<br>
追加と削除の操作方法は目標設定画面と同じです。
![記録画面](https://user-images.githubusercontent.com/42924818/103285058-680ca480-4a20-11eb-8ec6-70adbe5e9bab.png)

## 必要要件
Ruby 2.6.6<br>
Rails 6.0.3.3<br>
MySql 5.7.31

## 使い方
<pre>
$ git clone <span>https://github.com/sho-lm/goal-achievement.git</span>
$ cd goal-achievement
$ bundle install
$ rails db:create
$ rails db:migrate
$ rails s
</pre>
<pre>
access to <span>http://localhost:3000</span>
</pre>

## ライセンス
free license

## 使用言語
<a href="https://www.ruby-lang.org/ja/">Ruby</a><br>
<a href="https://railsguides.jp/">Rails</a><br>
<a href="https://jp.vuejs.org/index.html">Vue</a><br>
<a href="https://www.typescriptlang.org/">TypeScript</a><br>
<a href="https://sass-lang.com/">Sass</a><br>
<a href="https://www.npmjs.com/package/pug">Pug</a><br>
<a href="https://www.mysql.com/jp/">MySql</a><br>
<a href="https://webpack.js.org/">webpack</a><br>
