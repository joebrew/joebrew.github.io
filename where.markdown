---
layout: page
title: Where?
permalink: /where/
---

The insitutions involved in this project are:  

* [ISGlobal](http://www.isglobal.org/ca/)  
* [Centro de Investigação em Saúde de Manhiça](http://manhica.org/)  
* [Transdisciplinary Global Health Consortium](http://www.transglobalhealth.org/)   
* Somewhere in Amsterdam  

<iframe src = "/maps/world.html" width="600" height="350">
</iframe>

And here's the code to generate the above map in R.

{% highlight r %}
library(leaflet)
library(ggmap)

# Create a dataframe of locations, descriptions and names
places <- data.frame(place = c('Gainesville, FL, USA', 
                               'London, England',
                               'Barcelona, Spain',
                               'Manhica, Mozambique',
                               'Amsterdam, Netherlands'),
                     lon = c(-82.3248262,-0.1277583,2.1734035,32.7971649,4.8951679),
                     lat = c(29.6516344,51.50735,41.3850639,-25.3923014,52.3702157),
                     description = c('Joe',
                                     'Elisa',
                                     'ISGlobal (main institution)',
                                     'Centro de Investigação em Saúde de Manhiça (research site)',
                                     '(secondary research institution)'),
                     stringsAsFactors = FALSE)
# Run the following if you want to geocode the locations:
# temp <- geocode(places$place)

# Create a leaflet widget
m <- leaflet() %>%
  addProviderTiles("Stamen.Toner") %>%
  #addProviderTiles("Stamen.Watercolor") %>%
  setView(lng=0, lat=25, zoom=2) %>%
  addMarkers(lng=places$lon, 
             lat= places$lat, 
             popup=paste0(places$place, ' : ',
                         places$description))
  
# Save the widget to an html file
library(htmlwidgets)
saveWidget(m, file="/home/joebrew/Documents/joebrew.github.io/m.html")

{% endhighlight %}
