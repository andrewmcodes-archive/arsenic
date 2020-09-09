begin
  require "thor"
  require "bundler"
  require "pry-byebug"
rescue LoadError
  require "bundler/inline"
  require "thor"
end

require "arsenic/version"

module Arsenic
  class Newgem < Thor::Group
    include Thor::Actions

    COPY_FILES = %w[
      .gem_release.yml
      .gitignore
      .mdlrc
      .rspec
      .rubocop-md.yml
      .rubocop.yml
      lefthook.yml
      Gemfile
      LICENSE.txt
      Rakefile
      README.md
      RELEASING.md
    ].freeze

    COPY_DIRS = %w[
      .github
      spec
    ].freeze

    argument :name

    def self.source_root
      ENV.fetch("TEMPLATE", File.join(__dir__, "arsenic", "templates", "newgem"))
    end

    def self.exit_on_failure?
      true
    end

    def copy_files
      COPY_FILES.each { |file| template file }
    end

    def copy_dirs
      COPY_DIRS.each { |dir| directory(dir) }
    end

    def copy_gemfiles
      template "gemfiles/rubocop.gemfile"
      return unless rails?

      template "gemfiles/jruby.gemfile"
      template "gemfiles/rails5.gemfile"
      template "gemfiles/rails6.gemfile"
      template "gemfiles/railsmaster.gemfile"
    end

    def copy_lib
      template "lib/name.rb", "lib/#{name}.rb"
      directory "lib/dir", "lib/#{name_path}"
      remove_file "lib/#{name_path}/railtie.rb" unless rails?
    end

    def copy_gemspec
      template "newgem.gemspec", "#{name}.gemspec"
    end

    private

    def rails?
      @rails ||= yes?("Need Rails stuff?")
    end

    def module_name
      @module_name ||= name.split("-").map { |mod|
        mod.split("_").map(&:capitalize).join
      }.join("::")
    end

    def human_name
      @human_name ||= name.split(/[-_]/).map(&:capitalize).join(" ")
    end

    def name_path
      @name_path ||= name.tr("-", "/")
    end
  end

  def self.start
    generator = Newgem.new ARGV
    generator.destination_root = ARGV[0]
    generator.invoke_all
  end
end
