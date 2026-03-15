# frozen_string_literal: true

require "spec_helper"

RSpec.describe EnumLabel do
  it "has a version number" do
    expect(EnumLabel::VERSION).not_to be_nil
  end

  describe "#status_label" do
    it "returns the correct label" do
      article = Article.new(status: :draft)
      expect(article.status_label).to eq "下書き"
    end

    it "returns the updated label after change" do
      article = Article.new(status: :draft)
      article.status = :published
      expect(article.status_label).to eq "公開済み"
    end

    it "returns the label for each enum value" do
      expect(Article.new(status: :draft).status_label).to eq "下書き"
      expect(Article.new(status: :published).status_label).to eq "公開済み"
      expect(Article.new(status: :archived).status_label).to eq "アーカイブ"
    end

    it "returns nil when attribute is nil" do
      article = Article.new
      article[:status] = nil
      expect(article.status_label).to be_nil
    end
  end

  describe ".status_labels" do
    it "returns all labels as a hash" do
      expected = { "draft" => "下書き", "published" => "公開済み", "archived" => "アーカイブ" }
      expect(Article.status_labels).to eq expected
    end

    it "returns a frozen hash" do
      expect(Article.status_labels).to be_frozen
    end
  end

  describe "multiple enums" do
    it "supports multiple enum_label on the same model" do
      article = Article.new(status: :draft, visibility: :hidden)
      expect(article.status_label).to eq "下書き"
      expect(article.visibility_label).to eq "非公開"
    end

    it "returns class-level labels for each enum" do
      expect(Article.visibility_labels).to eq({ "visible" => "公開", "hidden" => "非公開" })
    end
  end

  describe "persisted record" do
    it "returns the label after reload" do
      article = Article.create!(status: :published, visibility: :visible)
      reloaded = Article.find(article.id)
      expect(reloaded.status_label).to eq "公開済み"
      expect(reloaded.visibility_label).to eq "公開"
    end
  end
end
