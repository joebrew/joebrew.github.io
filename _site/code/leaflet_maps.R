#### MAP OF JUST MAPUTO
library(leaflet)
library(ggmap)
library(dplyr)
library(raster)
library(RColorBrewer)
moz <- getData('GADM', country = 'MOZ', level = 3)


# Bring in manually data about prevalence
# http://www.pmi.gov/docs/default-source/default-document-library/malaria-operational-plans/fy14/mozambique_mop_fy14.pdf?sfvrsn=12
df <- data.frame(NAME_1 = unique(sort(moz$NAME_1)))
df$val <- c(47.2, 21.8, 36.8, 28.2, 3.2, 43.3,
            52.1, 30.7, 36.9, 54.8)

# Bring data into moz
moz@data <- left_join(x = moz@data, y = df)

# Define color
pal <- brewer.pal(n = 9, 'Reds')
cols_range <- colorRampPalette(pal)(ceiling(max(moz$val)))
cols <- cols_range[ceiling(moz$val)]

# # Create a dataframe of locations, descriptions and names
# places <- data.frame(place = 'Manhica, Maputo, Mozambique',
#                      description = 'Centro de Investigação em Saúde de Manhiça (research site)',
#                      stringsAsFactors = FALSE)
# # Run the following if you want to geocode the locations:
# temp <- geocode(places$place)
# places <- cbind(places, temp)

# Define some stuff for the legened
legend_seq <- seq(5, 45, 10)
legend_cols <- cols_range[legend_seq]

# Create a leaflet widget
m <- leaflet(moz) %>%
  # addProviderTiles("Stamen.Toner") %>%
  # addProviderTiles("Stamen.Toner") %>% 
  # addProviderTiles("OpenWeatherMap.Temperature") %>%
  # addProviderTiles("MapQuestOpen.Aerial") %>%
  addProviderTiles("Stamen.TonerBackground") %>% 
  setView(lng=32.7971649, lat=-25.3923014 +7, zoom=5) %>%
#   addMarkers(lng=places$lon, 
#              lat= places$lat, 
#              popup=paste0(places$place, ' : ',
#                           places$description)) %>%
  addPolygons(
    stroke = FALSE, fillOpacity = 0.9, smoothFactor = 0.5,
    # color = ~colorQuantile("YlOrRd", moz$ID_1)(ID_1)
    color = cols) %>%
  addLegend(position = 'bottomright',
            colors = legend_cols,
            labels = legend_seq,
            opacity = 0.9,
            title = 'Prevalence'
  )
m

# Save the widget to an html file
library(htmlwidgets)
saveWidget(m, file="/home/joebrew/Documents/joebrew.github.io/maps/malaria_prevalence.html")





#### MAP OF MOZAMBIQUE
library(leaflet)
library(ggmap)

library(raster)
library(RColorBrewer)
moz <- getData('GADM', country = 'MOZ', level = 3)
moz0 <- getData('GADM', country = 'MOZ', level = 0)

# Create a dataframe of locations, descriptions and names
places <- data.frame(place = 'Manhica, Maputo, Mozambique',
                    description = 'Centro de Investigação em Saúde de Manhiça (research site)',
                     stringsAsFactors = FALSE)
# Run the following if you want to geocode the locations:
temp <- geocode(places$place)
places <- cbind(places, temp)

# cols
cols <- sample(colorRampPalette(brewer.pal(n = 9, name = 'Reds'))(nrow(moz)), nrow(moz))
cols0 <- 'darkred'
# Create a leaflet widget
m <- leaflet(moz0) %>%
  # addProviderTiles("Stamen.Toner") %>%
  # addProviderTiles("Stamen.Toner") %>% 
  # addProviderTiles("OpenWeatherMap.Temperature") %>%
  # addProviderTiles("MapQuestOpen.Aerial") %>%
  addProviderTiles("Stamen.Watercolor") %>% 
  setView(lng=32.7971649, lat=-25.3923014, zoom=3) %>%
  addMarkers(lng=places$lon, 
             lat= places$lat, 
             popup=paste0(places$place, ' : ',
                          places$description)) %>%
  addPolygons(
  stroke = FALSE, fillOpacity = 0.5, smoothFactor = 0.5,
  # color = ~colorQuantile("YlOrRd", moz$ID_1)(ID_1)
  color = cols0)
m

# Save the widget to an html file
library(htmlwidgets)
saveWidget(m, file="/home/joebrew/Documents/joebrew.github.io/maps/manhica.html")

##########

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


# leaflet(moz) %>%
#   addPolygons(
#     stroke = FALSE, fillOpacity = 0.5, smoothFactor = 0.5,
#     # color = ~colorQuantile("YlOrRd", moz$ID_1)(ID_1)
#     color = colorRampPalette(brewer.pal(n = 9, name = 'Set1'))(nrow(moz)))

# Create a leaflet widget
m <- leaflet() %>%
  addProviderTiles("Stamen.Toner") %>%
  #addProviderTiles("Stamen.Watercolor") %>%
  setView(lng=0, lat=25, zoom=2) %>%
  addMarkers(lng=places$lon, 
             lat= places$lat, 
             popup=paste0(places$place, ' : ',
                          places$description)) %>%


# Save the widget to an html file
library(htmlwidgets)
saveWidget(m, file="/home/joebrew/Documents/joebrew.github.io/maps/world.html")
