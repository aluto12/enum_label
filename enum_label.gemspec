# frozen_string_literal: true

require_relative "lib/enum_label/version"

Gem::Specification.new do |spec|
  spec.name = "enum_label"
  spec.version = EnumLabel::VERSION
  spec.authors = ["aluto144"]
  spec.email = ["attwelve@icloud.com"]

  spec.summary = "Human-readable labels for Rails enums"
  spec.description = "Easily add human-readable labels (Japanese, English, etc.) to your Rails enum attributes with a simple DSL."
  spec.homepage = "https://github.com/aluto12/enum_label"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 3.2.0"

  spec.metadata["allowed_push_host"] = "https://rubygems.org"
  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/aluto12/enum_label"

  gemspec = File.basename(__FILE__)
  spec.files = IO.popen(%w[git ls-files -z], chdir: __dir__, err: IO::NULL) do |ls|
    ls.readlines("\x0", chomp: true).reject do |f|
      (f == gemspec) ||
        f.start_with?(*%w[bin/ Gemfile .gitignore test/])
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "activerecord", ">= 7.0"
  spec.add_dependency "activesupport", ">= 7.0"
end
