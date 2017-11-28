# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

  * 2.4.1

* System dependencies

  * imagemagick
  * https://pay.jp/

* Configuration

  * You should set database password (ex. .bashrc / .zshrc)

```
export MYSQL_DATABASE_PASSWORD=xxx
export PAYJP_PUBLIC_KEY=xxx
export PAYJP_SECRET_KEY=xxx
```

* Database creation

```
bundle exec rails db:create
```

* Database initialization

```
bundle exec rails db:migrate
bundle exec rails db:seed_fu FILTER=users,admins,companies
bundle exec rails db:seed_fu FILTER=coupons,diaries,products
bundle exec rails db:seed_fu FILTER=product_stocks
```

* How to run the test suite

```
RAILS_ENV=test bundle exec rspec -cfd
```

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

