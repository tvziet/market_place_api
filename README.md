# This project for practicing API on Rails 7

![Postgres](https://img.shields.io/badge/postgres-%23316192.svg?style=for-the-badge&logo=postgresql&logoColor=white)
![Ruby](https://img.shields.io/badge/ruby-%23CC342D.svg?style=for-the-badge&logo=ruby&logoColor=white)
![Rails](https://img.shields.io/badge/rails-%23CC0000.svg?style=for-the-badge&logo=ruby-on-rails&logoColor=white)
![Postman](https://img.shields.io/badge/Postman-FF6C37?style=for-the-badge&logo=postman&logoColor=white)
![Swagger](https://img.shields.io/badge/-Swagger-%23Clojure?style=for-the-badge&logo=swagger&logoColor=white)
![Amazon AWS](https://img.shields.io/badge/Amazon_AWS-FF9900?style=for-the-badge&logo=amazonaws&logoColor=white)
![Dependabot](https://img.shields.io/badge/dependabot-025E8C?style=for-the-badge&logo=dependabot&logoColor=white)

## API documents

Start server, then access path: `/api-docs`.

## How to setup

- Copy `.env.example` to `.env`:

  ```bash
      cp .env.example .env
  ```

- Create the database:

  ```bash
      rails db:create
  ```

- Run migration:

  ```bash
      rails db:migrate
  ```

- Run tests:

  ```bash
      rails test
  ```

- Run linters:
  ```bash
      bundle exec rubocop
  ```

## Description

### Models

- `User`
- `Order`
- `Product`
- `Image`
- `Comment`

### Associations

The `user` will be able to place many `orders`, upload multiple `products` which can have many `images` or `comments` from another `users`.

## Notes

### `fast_jsonapi` gem

When we use this gem, we generate serializer, it will generate the folder `serializers`. We neet to load this folder in `application.rb` file:

```ruby
config.eager_load_paths << Rails.root.join("serializers")
```

### How to write custom validator methods

Read more here: [Understanding Rails Custom Validations](https://abhinavgarg1218.medium.com/rails-custom-validations-109e3e42b6fd)
