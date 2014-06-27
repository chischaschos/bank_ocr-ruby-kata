require 'bundler/gem_tasks'
require 'rubocop/rake_task'

desc 'Run RuboCop on the lib directory'
Rubocop::RakeTask.new(:rubocop) do |task|
  task.patterns = ['lib/**/*.rb']
  task.fail_on_error = false
end
