namespace :db do
  desc "Load work_orders from CSV"
  task load_orders: :environment do
    require 'csv'
    require 'time'
    csv_file_path = Rails.root.join('lib', 'assets', 'work_orders.csv')

    ActiveRecord::Base.transaction do
      CSV.foreach(csv_file_path, headers: true) do |row|
        #             Was having an issue where every time read in would be 6 hours late so I just subtracted 6 hours here v    (21600 seconds in 6 hours) Suspect time zone could have this effect
        order = Order.new(jid: row[0].to_i,technician_id: row[1].to_i, location_id: row[2].to_i,time: Time.parse(row[3])-21600, duration: row[4].to_i, price: row[5].to_i)
        puts "Start time #{Time.parse(row[3])}"
        if order.jid.present? && order.save
          puts "Successfully saved order: #{order.jid}"
        else
          puts "Failed to save order: #{order.errors.full_messages.join(", ")}"
        end
      end
    end

    puts "Finished loading orders from CSV"
  end
end
