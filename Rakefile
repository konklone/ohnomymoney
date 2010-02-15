desc 'Migrate the database'
task :migrate => :environment do
  ActiveRecord::Base.logger = Logger.new STDOUT
  ActiveRecord::Migrator.migrate 'migrations', (ENV['VERSION'] ? ENV['VERSION'].to_i : nil)
end

desc 'Loads environment'
task :environment do
  require 'ohnomymoney'
end