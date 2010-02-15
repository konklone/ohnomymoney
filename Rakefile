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
    filename = "%s.yml" % File.join("data", model.table_name)
    
    model.delete_all
    
    YAML::load_file(filename).each do |data_row|
      record = model.new
      data_row.keys.each do |field|
        record[field] = data_row[field] if data_row[field]
      end
      record.save
    end
  end
 
  
  desc "Backup a model to YAML."
  task :backup => :environment do
    model = ENV['model'].singularize.camelize.constantize
    filename = "%s.yml" % File.join("data", model.table_name)
    
    data = model.all.reduce([]) do |records, record|
      element = {}
      model.columns.map(&:name).each do |field|
        element[field] = record[field]
      end
      records << element
    end
    
    FileUtils.mkdir_p File.dirname(filename)
    File.open(filename, "w") do |file|
      YAML.dump data, file
    end
  end

end