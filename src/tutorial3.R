# this tutorial includes some basic functions of maps library
# Part 1
require(maps)

map('state')
map('world')

# plot North America
xlimit <- c(-171.738281, -56.601563)
ylimit <- c(12.039321, 71.856229)
map("world", col= "blue", fill= FALSE, bg= "white", lwd= 0.3, xlim=xlimit, ylim=ylimit)

# plot arizona state 
map("state", "Arizona")
data(us.cities)
map.cities(us.cities, country="AZ")

# add color or text on existing maps 
map("state", interior= FALSE)
map("state", boundary= TRUE, col="blue", add= TRUE)

# highlight texas 
map("state", col= "grey", boundary=TRUE, fill= TRUE, lty= 5,lwd= 0.2)
map("state", regions= "texas", col = "red", fill= TRUE, add= TRUE, lty= 1, lwd= 2)
map.text("state","texas", col="white", add= TRUE)

# highlight arizona 
map("state", col= "grey", boundary=TRUE, fill= TRUE, lty= 5,lwd= 0.2)
map("state", regions= "arizona", col = "red", fill= TRUE, add= TRUE, lty= 1, lwd= 2)
map.text("state","Arizona", col="white", add= TRUE)

# 2012 Arizona election results by county (Figure 8)
# data: https://catalog.data.gov/dataset/presidential-general-election-results-2012-direct-download
map('county','arizona', fill = TRUE, col = palette())
az_county_data <- map_data("county")

library(ggplot2)
library(rgeos)
library(maptools)
require(sqldf)
#transform shapefile to data frame
states.shp <- readShapeSpatial("election-data/elpo12p010g.shp")


#get a subset of AZ data from states.shp
mydata<-data.frame(state=states.shp$STATE, County=states.shp$COUNTY, winner=states.shp$WINNER, votes=states.shp$TTL_VT)
az_election_results<-sqldf("select * from mydata where state='AZ'")
az_election_results$county<-tolower(az_election_results$County)

#merget az_county_data and az_election_results
names(az_county_data) <- c("long", "lat", "group", "order", "state_name", "county")

az_data<-sqldf("select * from az_county_data where state_name='arizona'")
table<-merge(az_election_results,az_data, by= c("county","county"))
table<-table[order(table$order),]

# use ggplot() + geom_polygon() to plot
state_df <- map_data('county','arizona')

ggplot(table, aes(long, lat, group = group))+ scale_fill_continuous(low="#FFFFFF",high = "#FF0000",space = "Lab")+
  geom_polygon(aes(fill = votes))+geom_polygon(data= state_df, colour= "black", fill = NA) 

# Part 2
library(ggplot2)
require(ggmap)

#maptype: terrain, satellite, roadmap, hybrid, toner, watercolor
cidse.map <- get_map(location=c(lon=-111.9389 , lat=33.4234), zoom=16,
                     maptype="roadmap")
ggmap(cidse.map)

# Generate some data
# http://www.gpsvisualizer.com/geocoder/
long = c(-111.94037, -111.94001,-111.93402 )
lat = c(33.42576, 33.42475,33.42475)
who = c("starbucks", "brickyard", "tennis court")
places = data.frame (long, lat, who)

# overlay the data on the googlemap
ggmap(cidse.map) + geom_point(data=places, aes(x=long, y=lat, fill= factor(who)),
                              colour="blue", size=4, alpha= 0.6)

#earthquake map
earthquake <- read.csv("earthquake.csv")
earthquake.points <-earthquake[,c("Longitude","Latitude")]
earthquake.map <- get_map(location=c(lon=150, lat=20), zoom=3, maptype="terrain")

ggmap(earthquake.map) + geom_point(data=earthquake.points, 
                                   aes(x=Longitude, y=Latitude), col="red", size=2)
