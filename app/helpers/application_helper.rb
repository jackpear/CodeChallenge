module ApplicationHelper

  # This takes in the @orders (all Orders) and returns tuples that hold the relevant data
  # tuples = 4-tuple [start time,duration, location id, price]
  def orders_to_tuples(orders)
    tuples = orders.map do |order|
      start_time = order.time 
      duration = order.duration 
      [start_time,duration,order.location_id, order.price]
    end
    tuples
  end

  # This takes in a Time and returns how many pixels down from the top of the schedule it should start at
  def time_to_pxOffset(time)
    #Earliest start time is always 6:00 or 360 minutes
    (time.hour*60 + time.min - 360)
  end

  # This returns how many minutes are between 2 given times
  def times_to_minutes(time1, time2)
    (time2 - time1)/60 
  end

  # This returns the time it will be starting at the given time and adding its duration in minutes
  def get_end_time(time, duration)
    time + duration*60
  end

  # This takes in the work-order tuples created earlier and returns the 2-tuples of the betweens
  # between/gap = [start time, duration]
  def calculate_gaps(time_slots)
    gaps = []
    
    # Slots are sorted by start time
    sorted_slots = time_slots.sort_by { |start_time, _,_,_| start_time }

    newGap = [Time.parse("2000-01-01 6:00"),times_to_minutes(Time.parse("2000-01-01 0:00"),sorted_slots[0][0])]
    if (newGap[1] > 0) # If any order overlaps another, newGap[1] (its height) would be negative and there would be no need for a gap in between them
      gaps << newGap # adds first gap
    end

    end_time = sorted_slots.last[0] + sorted_slots.last[1]*60
    newGap = [end_time, times_to_minutes(end_time,Time.parse("2000-01-01 10:00"))]
    if (newGap[1] > 0)
      gaps << newGap # adds last gap
    end

    # adds all gaps in between orders
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
