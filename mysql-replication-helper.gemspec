# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{mysql-replication-helper}
  s.version = "0.1.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Scott Tadman"]
  s.date = %q{2009-04-24}
  s.default_executable = %q{replication-helper}
  s.email = %q{github@tadman.ca}
  s.executables = ["replication-helper"]
  s.extra_rdoc_files = [
    "README.rdoc"
  ]
  s.files = [
    "README.rdoc",
    "Rakefile",
    "VERSION.yml",
    "bin/replication-helper",
    "lib/mysql_replication_helper.rb",
    "lib/mysql_replication_helper/error_handler.rb",
    "test/mysql_replication_helper/error_handler_test.rb",
    "test/mysql_replication_helper_test.rb",
    "test/test_helper.rb"
  ]
  s.has_rdoc = true
  s.homepage = %q{http://github.com/theworkinggroup/mysql-replication-helper}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.2}
  s.summary = %q{MySQL Replication Helper}
  s.test_files = [
    "test/mysql_replication_helper/error_handler_test.rb",
    "test/mysql_replication_helper_test.rb",
    "test/test_helper.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
