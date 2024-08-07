namespace :db do
  desc "Load technicians from CSV"
  task load_technicians: :environment do
    require 'csv'

    csv_file_path = Rails.root.join('lib', 'assets', 'technicians.csv')

    ActiveRecord::Base.transaction do
      CSV.foreach(csv_file_path, headers: true) do |row|
        tech_id = row[0].to_i
        name = row['name']
        #puts "ID: #{row[0]}"
        technician = Technician.new(tech_id: tech_id,name: name)

        if technician.tech_id.present? && technician.save
          puts "Successfully saved: #{technician.name} with tech_id #{technician.tech_id}"
        else
          puts "Failed to save: #{technician.errors.full_messages.join(", ")}"
        end
      end
    end

    puts "Finished loading technicians from CSV"
  end
end
