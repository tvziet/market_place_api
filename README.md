# This project for practicing API on Rails 6
![Postgres](https://img.shields.io/badge/postgres-%23316192.svg?style=for-the-badge&logo=postgresql&logoColor=white)
![Ruby](https://img.shields.io/badge/ruby-%23CC342D.svg?style=for-the-badge&logo=ruby&logoColor=white)
![Rails](https://img.shields.io/badge/rails-%23CC0000.svg?style=for-the-badge&logo=ruby-on-rails&logoColor=white)
![Postman](https://img.shields.io/badge/Postman-FF6C37?style=for-the-badge&logo=postman&logoColor=white)
![Dependabot](https://img.shields.io/badge/dependabot-025E8C?style=for-the-badge&logo=dependabot&logoColor=white)

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
