# frozen_string_literal: true

require "test_helper"

class TestEnumLabel < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::EnumLabel::VERSION
  end

  def test_instance_label_returns_correct_label
    article = Article.new(status: :draft)
    assert_equal "下書き", article.status_label
  end

  def test_instance_label_after_change
    article = Article.new(status: :draft)
    article.status = :published
    assert_equal "公開済み", article.status_label
  end

  def test_instance_label_for_all_values
    assert_equal "下書き", Article.new(status: :draft).status_label
    assert_equal "公開済み", Article.new(status: :published).status_label
    assert_equal "アーカイブ", Article.new(status: :archived).status_label
  end

  def test_instance_label_returns_nil_when_attribute_is_nil
    article = Article.new
    article[:status] = nil
    assert_nil article.status_label
  end

  def test_class_method_returns_all_labels
    expected = { "draft" => "下書き", "published" => "公開済み", "archived" => "アーカイブ" }
    assert_equal expected, Article.status_labels
  end

  def test_labels_are_frozen
    assert Article.status_labels.frozen?
  end

  def test_multiple_enums_on_same_model
    article = Article.new(status: :draft, visibility: :hidden)
    assert_equal "下書き", article.status_label
    assert_equal "非公開", article.visibility_label
  end

  def test_multiple_enums_class_labels
    assert_equal({ "visible" => "公開", "hidden" => "非公開" }, Article.visibility_labels)
  end

  def test_label_with_persisted_record
    article = Article.create!(status: :published, visibility: :visible)
    reloaded = Article.find(article.id)
    assert_equal "公開済み", reloaded.status_label
    assert_equal "公開", reloaded.visibility_label
  end
end
