# README

Technologies downloaded:
* Ruby 3.3.4
* SQLite3 3.46.0
* Rails 7.1.3.4

I didn't add anything to the gemfile, I did use the csv and time libraries.

## Brief Description
I used 3 models (Technician, Order, Location) to store the 3 different classes of CSV files. I only have 1 controller and route as I only needed 1 page. I also used the default application_helper.rb file for helper functions when generating the html. 

Most of the code I wrote is within `views/layouts/technicians/index.html.erb`, `helpers/application_helper.rb` and `lib/tasks/*` files. 
The tasks/rakes I made are used by placing the csv's with the specific names like 'locations.csv' that were given to me within the `lib/assets` folder, then running
* rails db:load_locations
* rails db:load_orders
* rails db:load_technicians

Starting the server is `$>rails server`

To clear out the databases I just go into `$>rails console` and do `>Technician.destroy_all` and the same for the other 2 (Technician, Order and Location)

I think the generation of the work orders and 'betweens' in the html is the most complicated part. Both of these were stored as lists of tuples when generating the html
* tuples = 4-tuple [start time,duration, location id, price]
* betweens = 2-tuple [start time, duration]

The start time determines where it is on the schedule and the duration determines it's height. Betweens are what I call the divs that go in between the work orders. They store data for the popup that tells the available time between orders. They can be clicked on to show the popup, or when the mouse hovers them the tooltip shows the same thing. 

Betweens are invisible but if you wanted to see what they look like you change the background-color in '.work-gap' within the main.css (both main.js and main.css are in the `public/*` folder)

## Problems faced
1) I didn't know ruby when starting this project but I think I got a pretty good grasp on it as I worked.
2) Ruby on rails is a little daunting when creating the project with all the folders and files. I am not overly confident with the way I made the routes,controllers and others but I did follow the online getting started guide.  
3) Creating the schedule layout itself with html and css was a little complicated but I figured it out quickly.
4) Generating the work orders and 'betweens' was the toughest part for me.
5) Using the 'Time' type variable had issues with time zones and dates which were irrelevant in this app

## Things I could improve
1) dynamic file names for inputting csv's. Right now they need to have a specific, hardcoded name and be in the correct folder in order to be raked in. Adding arguments to input the path and name of a data csv would be better.
2) The schedule on the webpage is a static size. Making the schedule expand and contract to fit the window size would be better.
3) Overlapping work orders on the schedule. One of the work orders overlaps another one and you can see the whole thing if you hover your mouse over the visible bottom section, it would be better to make it more visible. 
4) The rendering involves using all the data entries from the Location, Technician, Order models which if the database was large would be inefficient. Only selecting the orders and other objects that are relevant for a specific day would be better.
5) I think the obvious next steps of this would be the ability to POST new orders, locations and technicians and have a multiple day schedule but those weren't in the requirements

![image](https://github.com/user-attachments/assets/970aea1a-2d5f-496b-ae1c-24aeb446c856)
