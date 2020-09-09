require_relative "lib/arsenic/version"

Gem::Specification.new do |spec|
  spec.name = "arsenic"
  spec.license = "MIT"
  spec.version = Arsenic::VERSION
  spec.authors = ["Andrew Mason"]
  spec.email = %w[andrewmcodes@protonmail.com]

  spec.summary = "andrewmcodes gem generator"
  spec.description = "originally forked from Palkan. https://github.com/palkan/new-gem-generator"
  spec.homepage = "https://github.com/andrewmcodes/arsenic"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.3.0")

  spec.metadata = {
    # "allowed_push_host" => "TODO: Set to 'http://mygemserver.com'"
    "bug_tracker_uri" => "#{spec.homepage}/issues",
    "changelog_uri" => "#{spec.homepage}/blob/main/CHANGELOG.md",
    "documentation_uri" => spec.homepage,
    "homepage_uri" => spec.homepage,
    "source_code_uri" => spec.homepage
  }

  spec.files =
    Dir.chdir(File.expand_path("..", __FILE__)) do
      `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
    end

  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = %w[lib]
end
