require 'logger'


desc "Update all accounts"
task :update => :environment do
  require 'updater/wesabe/updater'
  
  User.all.each do |user|
    Updater.new(user).update_accounts!
  end
end


namespace :fixtures do

  desc "Load all fixtures, or one model's"
  task :load => :environment do
    fixtures = ENV['model'] ? [ENV['model']] : all_fixtures
    fixtures.each {|fixture| restore_fixture fixture.singularize.camelize.constantize}
  end
  
  desc "Dump all models into fixtures, or one model"
  task :dump => :environment do
    fixtures = ENV['model'] ? [ENV['model']] : all_fixtures
    fixtures.each {|fixture| dump_fixture fixture.singularize.camelize.constantize}
  end
  
  def all_fixtures
    Dir.glob("fixtures/*.yml").map {|f| File.basename(f, ".yml")}
  end

end


desc 'Migrate the database'
task :migrate => :environment do
  ActiveRecord::Base.logger = Logger.new STDOUT
  ActiveRecord::Migrator.migrate 'migrations', (ENV['version'] ? ENV['version'].to_i : nil)
end

desc 'Loads environment'
task :environment do
  require 'ohnomymoney'
end


def restore_fixture(model)
  model.delete_all
  
  YAML::load_file("fixtures/#{model.table_name}.yml").each do |row|
    record = model.new
    row.keys.each do |field|
      record[field] = row[field] if row[field]
    end
    record.save
  end
  
  puts "Loaded #{model} fixtures"
end

def dump_fixture(model)
  data = model.all.reduce([]) do |records, record|
    element = {}
    model.columns.map(&:name).each do |field|
      element[field] = record[field]
    end
    records << element
  end
  
  FileUtils.mkdir_p "fixtures"
  File.open("fixtures/#{model.table_name}.yml", "w") do |file|
    YAML.dump data, file
  end
  
  puts "Dumped #{model} fixtures"
end