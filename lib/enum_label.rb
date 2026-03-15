# frozen_string_literal: true

require_relative "enum_label/version"
require "active_support/concern"

module EnumLabel
  extend ActiveSupport::Concern

  class Error < StandardError; end

  class_methods do
    # Define human-readable labels for an enum attribute.
    #
    #   class Article < ApplicationRecord
    #     enum :status, { draft: 0, published: 1, archived: 2 }
    #     enum_label :status, draft: "下書き", published: "公開済み", archived: "アーカイブ"
    #   end
    #
    #   article = Article.new(status: :draft)
    #   article.status_label  #=> "下書き"
    #   Article.status_labels #=> { "draft" => "下書き", "published" => "公開済み", "archived" => "アーカイブ" }
    #
    def enum_label(attribute, labels = {})
      labels_map = labels.transform_keys(&:to_s).freeze
      attribute = attribute.to_sym

      # Store labels on the class for introspection
      singleton_class.module_eval do
        define_method(:"#{attribute}_labels") do
          labels_map
        end
      end

      # Instance method: article.status_label
      define_method(:"#{attribute}_label") do
        value = send(attribute)
        labels_map[value.to_s] if value
      end
    end
  end
end

# Auto-include into ActiveRecord if available
ActiveSupport.on_load(:active_record) do
  include EnumLabel
end
