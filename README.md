# EnumLabel

Rails の enum に人間が読めるラベルを簡単に付けられる gem です。

日本語はもちろん、どの言語のラベルでも使えます。

## Installation

```ruby
# Gemfile
gem "enum_label"
```

```bash
bundle install
```

## Usage

```ruby
class Article < ApplicationRecord
  enum :status, { draft: 0, published: 1, archived: 2 }
  enum_label :status, draft: "下書き", published: "公開済み", archived: "アーカイブ"
end
```

### Instance method

```ruby
article = Article.new(status: :draft)
article.status_label  #=> "下書き"

article.status = :published
article.status_label  #=> "公開済み"
```

### Class method

```ruby
Article.status_labels
#=> { "draft" => "下書き", "published" => "公開済み", "archived" => "アーカイブ" }
```

セレクトボックスにそのまま使えます:

```erb
<%= f.select :status, Article.status_labels.invert %>
```

### Multiple enums

```ruby
class Article < ApplicationRecord
  enum :status, { draft: 0, published: 1, archived: 2 }
  enum_label :status, draft: "下書き", published: "公開済み", archived: "アーカイブ"

  enum :visibility, { visible: 0, hidden: 1 }
  enum_label :visibility, visible: "公開", hidden: "非公開"
end

article = Article.new(status: :draft, visibility: :hidden)
article.status_label      #=> "下書き"
article.visibility_label  #=> "非公開"
```

## Requirements

- Ruby >= 3.2
- Rails >= 7.0

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
