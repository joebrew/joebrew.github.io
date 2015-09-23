# Packages
library(weatherData)
library(dplyr)
library(rCharts)

# Get weather
# first for 2009
weather <- getWeatherForYear('FQMA', year = 2009, opt_detailed = FALSE)
# then for other years
years <- 2010:2015
for (i in 1:length(years)){
  temp <- getWeatherForYear('FQMA', year = years[i], opt_detailed = FALSE)
  weather <- rbind(temp, weather)
  rm(temp)
}
rm(years)

save('weather', 'weather.RData')

# Get by month
weather$month <- format(weather$Date, '%m')
weather$year <- format(weather$Date, '%Y')
weather$year_month <- paste0(weather$year, '-', weather$month)

# Aggregate by month
weather_agg <- weather[,which(names(weather) != 'Date')] %>%
  group_by(year_month) %>%
  summarise(max = max(Max_TemperatureC, na.rm = TRUE),
            min = min(Min_TemperatureC, na.rm = TRUE),
            mean = mean(Mean_TemperatureC, na.rm = TRUE))

# Plot
m1 <- mPlot(x = "year_month", y = c("max", "min", 'mean'), 
            type = "Line", data = weather_agg)
m1$set(pointSize = 0, lineWidth = 1)
m1$print("chart2")

# Save an html file
m1$save('weather.html', standalone = TRUE)

# Write the plot to a js file
sink('weather.js')
cat(m1$print())
sink()

#
library(htmlwidgets)
saveWidget(m1, file="/home/joebrew/Documents/joebrew.github.io/code/weather.html")

