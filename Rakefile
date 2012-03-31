require 'bundler/setup'
require 'rspec/core/rake_task'

task :default => :test
task :test => :spec

test = Rake::Task['test']
test.enhance { Rake::Task['spec'].invoke }
