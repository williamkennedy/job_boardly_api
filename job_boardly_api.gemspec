# frozen_string_literal: true

require_relative "lib/job_boardly_api/version"

Gem::Specification.new do |spec|
  spec.name = "job_boardly_api"
  spec.version = JobBoardlyApi::VERSION
  spec.authors = ["William Kennedy"]
  spec.email = ["williamkennedyjnr@gmail.com"]

  spec.summary = "A Ruby wrapper around the Jobboardly API."
  spec.description = "A Ruby wrapper around the Jobboardly Management and Headless Board APIs."
  spec.homepage = "https://github.com/williamkennedy/job_boardly_api"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 2.7.0"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/williamkennedy/job_boardly_api"
  spec.metadata["changelog_uri"] = "https://github.com/williamkennedy/job_boardly_api/blob/main/CHANGELOG.md"

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
end
