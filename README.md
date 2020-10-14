|Task|
|-------|
|name :string|
|detail :text|

# Herokuへのデプロイ方法  

#### 環境
ruby 2.6.5<br>
rails 5.2.4

1. アセットプリコンパイルをする<br>
``$ rails assets:precompile RAILS_ENV=production``
1. コミットする<br>
``~/workspace/heroku_test_app (master) $ git add -A ``
``~/workspace/heroku_test_app (master) $ git commit -m "init"``
1. Herokuに新しいアプリケーションを作成<br>
``$ heroku create``
1.Herokuにデプロイをする<br>
``$ git push heroku master``