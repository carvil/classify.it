require 'rubygems'
require 'bundler'
require 'rake'
Bundler.setup
require 'rspec/core/rake_task'

task :default => :spec

RSpec::Core::RakeTask.new do |t|
  t.pattern = "./spec/**/*_spec.rb"
end

task :test do
  Rake::Task['spec'].invoke
end
