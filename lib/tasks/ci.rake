# encoding: UTF-8

desc 'Task to run on CI: runs rubocop and RSpec specs'
task ci: %i[spec rubocop]

namespace :ci do
  desc 'Task to run on CI: runs rubocop and RSpec specs'
  task all: %i[spec rubocop]
end

task :rubocop do
  sh 'bundle exec rubocop'
end

task default: :'ci:all'
