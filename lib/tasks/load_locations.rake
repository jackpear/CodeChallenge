namespace :db do
  desc "Load locations from CSV"
  task load_locations: :environment do
    require 'csv'
    csv_file_path = Rails.root.join('lib', 'assets', 'locations.csv')

    ActiveRecord::Base.transaction do
      CSV.foreach(csv_file_path, headers: true) do |row|
        
        loc = Location.new(loc_id:row[0].to_i,name: row[1],city: row[2])

        if loc.loc_id.present? && loc.save
          puts "Successfully saved location: #{loc.loc_id}"
        else
          puts "Failed to save location: #{loc.errors.full_messages.join(", ")}"
        end
      end
    end

    puts "Finished loading locations from CSV"
  end
end
