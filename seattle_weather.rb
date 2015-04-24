require 'open-uri'
require 'json'


# checks API history if it rained that day
def did_it_rain(yyyymmdd)
	open("http://api.wunderground.com/api/15382b12a338b65c/geolookup/history_#{yyyymmdd}/q/WA/Seattle.json") do |f|
		json_string = f.read
		parsed_json = JSON.parse(json_string)
		location = parsed_json['location']['city']
		rain = parsed_json['history']['dailysummary'][0]['rain']
    f.close # is this effective?
		# http://stackoverflow.com/questions/20790499/no-implicit-conversion-of-string-into-integer-typeerror

		if rain === "0"
			return false
		else 
			return true
		end
	end
end

# determines leap years
def leap_year(year)
  if year % 4 === 0 && year % 100 != 0
    return true
  elsif year % 4 === 0 && year % 100 === 0 && year % 400 === 0
    return true
  else
    return false
  end
end

# changes date to the day before
def day_before(year, month, day)	
  longest_months = [1, 3, 5, 7, 8, 10]

  if day > 1 
		day -= 1
		return year, month, day # returned as single array element
    # www.rubyfleebie.com/how-to-return-multiple-values-from-a-method/
	else 
    # go to the previous month
		if month > 1
			month -= 1

      # don't forget - have to go to the last day of that month
      if longest_months.include?(month)
        day = 31
      elsif month === 2
        leap_year(year) ? day = 29 : day = 28
      else
        day = 30
      end

		else # go to Dec of the previous year
			month = 12
			year -= 1
      day = 31
		end

    return year, month, day
  end
end

# starts with today's date
this_year = Time.now.year
this_month = Time.now.month
this_day = Time.now.day
date = [this_year, this_month, this_day]

# finds the last day that it rained
def last_rainy_day(date)
  # did it rain on this date?
  if did_it_rain("#{date[0].to_s + (sprintf '%02d', date[1]) + (sprintf '%02d', date[2])}")
    return date
  else 
    # did it rain the day beore that?
    last_rainy_day(day_before(date[0], date[1], date[2]))
  end
end

# finds num of days between today and the last rainy day
def days_since_rain(last_rainy_date, date)
  longest_months = [1, 3, 5, 7, 8, 10]

  if last_rainy_date === date
    puts "It rained today in Seattle, WA."
  elsif 
    if longest_months.include?(last_rainy_date[1])
      month_days = 31
    elsif last_rainy_date[1] === 2
      leap_year(year) ? month_days = 29 : month_days = 28
    else 
      month_days = 30
    end

    if (month_days - last_rainy_date[2] + date[2]) > 1
      puts "It's been #{month_days - last_rainy_date[2] + date[2]} days since it rained in Seattle, WA."
    else
      puts "It's been one day since it rained in Seattle, WA."
    end
  end
end


days_since_rain(last_rainy_day(date), date)

# don't forget to credit Wunderground API