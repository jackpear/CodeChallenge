module ApplicationHelper
 
  def time_to_string(time)
    "#{time.hour}:#{time.min.to_s.rjust(2,'0')}"
  end

  def orders_to_times(orders)
    earliest_time = Time.parse("15:00")
    tuples = orders.map do |order|
      puts "Start time: #{order.time}"
      start_time = order.time 
      end_time = start_time + order.duration*60
      [start_time,end_time]
      if (start_time < earliest_time)
        earliest_time = start_time
      end
    end
    betweens = [Time.parse("6:00"),time_to_minutes(earliest_time)-360]
    puts "Minutes to time #{earliest_time} ----- #{time_to_minutes(earliest_time)}"
    tuples
  end

  def orders_to_tuples(orders,pxScale)
    tuples = orders.map do |order|
      start_time = order.time 
      duration = order.duration 
      [start_time,duration*pxScale,order.location_id, order.price]   # I always use pxScale of 2 to make an hour slot 120px tall
    end
    tuples
  end

  def tuples_to_betweens(tuples,pxScale)
    sorted = tuples.sort_by { |start_time,_,_,_| start_time } # sorts orders

    
  end

  def time_to_pxOffset(time)
    #Earliest start time is always 6:00 or 360 minutes
    (time.hour*60 + time.min - 360)*2
  end

  def times_to_minutes(time1, time2)
    (time2 - time1)/60 # This returns how many minutes are between the times
  end

  def get_end_time(time, duration,pxScale)
    time + duration*(60/pxScale)
  end

  def calculate_gaps(time_slots,pxScale)
    gaps = []
    
    # Ensure the slots are sorted by start time
    sorted_slots = time_slots.sort_by { |start_time, _,_,_| start_time }
    # puts "!!!!!!!!!!!!!!!!!!!! #{times_to_minutes(Time.parse("2000-01-01 0:00"),sorted_slots[0][0])}"
    newGap = [Time.parse("2000-01-01 6:00"),times_to_minutes(Time.parse("2000-01-01 0:00"),sorted_slots[0][0])*pxScale]
    if (newGap[1] > 0)
      gaps << newGap # adds first gap
    end
    end_time = sorted_slots.last[0] + sorted_slots.last[1]*30
    newGap = [end_time, times_to_minutes(end_time,Time.parse("2000-01-01 10:00"))*pxScale]
    if (newGap[1] > 0)
      gaps << newGap # adds last gap
    end
    # Iterate through the list to find gaps
    sorted_slots.each_cons(2) do |(start_time1, duration1,_,_), (start_time2, _,_,_)|
      duration1 = duration1/2
      end_time1 = start_time1 + duration1 * 60  # Calculate the end time of the first slot
      if start_time2 > end_time1
        gap_duration = times_to_minutes(end_time1,start_time2)  # Convert gap from seconds to minutes
        gaps << [end_time1, gap_duration.to_i*pxScale]  # Add the gap as a tuple
      end
    end
    puts "  "
    gaps
  end
  
end
