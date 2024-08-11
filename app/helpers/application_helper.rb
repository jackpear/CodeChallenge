module ApplicationHelper

  def orders_to_tuples(orders)
    tuples = orders.map do |order|
      start_time = order.time 
      duration = order.duration 
      [start_time,duration,order.location_id, order.price]
    end
    tuples
  end

  def time_to_pxOffset(time)
    #Earliest start time is always 6:00 or 360 minutes
    (time.hour*60 + time.min - 360)
  end

  def times_to_minutes(time1, time2)
    (time2 - time1)/60 # This returns how many minutes are between the times
  end

  def get_end_time(time, duration)
    time + duration*60
  end

  def calculate_gaps(time_slots)
    gaps = []
    
    # Ensure the slots are sorted by start time
    sorted_slots = time_slots.sort_by { |start_time, _,_,_| start_time }
    newGap = [Time.parse("2000-01-01 6:00"),times_to_minutes(Time.parse("2000-01-01 0:00"),sorted_slots[0][0])]
    if (newGap[1] > 0)
      gaps << newGap # adds first gap
    end
    end_time = sorted_slots.last[0] + sorted_slots.last[1]*60
    newGap = [end_time, times_to_minutes(end_time,Time.parse("2000-01-01 10:00"))]
    if (newGap[1] > 0)
      gaps << newGap # adds last gap
    end

    sorted_slots.each_cons(2) do |(start_time1, duration1,_,_), (start_time2, _,_,_)|
      duration1 = duration1
      end_time1 = start_time1 + duration1 * 60  # Calculate the end time of the first slot
      if start_time2 > end_time1
        gap_duration = times_to_minutes(end_time1,start_time2)  # Convert gap from seconds to minutes
        gaps << [end_time1, gap_duration.to_i]  # Add the gap as a tuple
      end
    end
    puts "  "
    gaps
  end
  
end
