desc 'Migrate the database'
task :migrate => :environment do
  ActiveRecord::Base.logger = Logger.new STDOUT
  ActiveRecord::Migrator.migrate 'migrations', (ENV['version'] ? ENV['version'].to_i : nil)
end

desc 'Loads environment'
task :environment do
  require 'ohnomymoney'
end


# Generic YAML loading/backup code, for my fixture convenience
namespace :data do

  desc "Restore a model using YAML backup"
  task :restore => :environment do
    model = ENV['model'].singularize.camelize.constantize
    model.delete_all
    
    YAML::load_file("data/#{model.table_name}.yml").each do |row|
      record = model.new
      row.keys.each do |field|
        record[field] = row[field] if row[field]
      end
      record.save
    end
  end
 
  
  desc "Backup a model to YAML."
  task :backup => :environment do
    model = ENV['model'].singularize.camelize.constantize
    
    data = model.all.reduce([]) do |records, record|
      element = {}
      model.columns.map(&:name).each do |field|
        element[field] = record[field]
      end
      records << element
    end
    
    FileUtils.mkdir_p "data"
    File.open("data/#{model.table_name}.yml", "w") do |file|
      YAML.dump data, file
    end
  end

end