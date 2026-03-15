# frozen_string_literal: true

$LOAD_PATH.unshift File.expand_path("../lib", __dir__)

require "active_record"
require "enum_label"

# In-memory SQLite database for testing
ActiveRecord::Base.establish_connection(adapter: "sqlite3", database: ":memory:")

ActiveRecord::Schema.define do
  create_table :articles, force: true do |t|
    t.integer :status, default: 0, null: false
    t.integer :visibility, default: 0, null: false
  end
end

class Article < ActiveRecord::Base
  enum :status, { draft: 0, published: 1, archived: 2 }
  enum_label :status, draft: "下書き", published: "公開済み", archived: "アーカイブ"

  enum :visibility, { visible: 0, hidden: 1 }
  enum_label :visibility, visible: "公開", hidden: "非公開"
end

require "minitest/autorun"
