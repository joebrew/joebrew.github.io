---
layout: page
title: Data gallery
permalink: /data/
---

### Prevalence of malaria in Mozambique  

Malaria is endemic throughout Mozambique, and accounts for 42% of all deaths among those 5 or younger.

The below data come from the [2011 DHS](http://www.pmi.gov/docs/default-source/default-document-library/malaria-operational-plans/fy14/mozambique_mop_fy14.pdf?sfvrsn=12).  It shows the prevalence of malaria by district using rapid diagnostic tests.  

<iframe src = "/maps/malaria_prevalence.html" width="600" height="350">
</iframe>

The code to generate the map in R is below:

{% highlight r %}

library(leaflet)
library(ggmap)
library(dplyr)
library(raster)
library(RColorBrewer)
moz <- getData('GADM', country = 'MOZ', level = 3)


# Bring in manually data about prevalence
df <- data.frame(NAME_1 = unique(sort(moz$NAME_1)))
df$val <- c(47.2, 21.8, 36.8, 28.2, 3.2, 43.3,
            52.1, 30.7, 36.9, 54.8)

# Bring data into moz
moz@data <- left_join(x = moz@data, y = df)

# Define color
pal <- brewer.pal(n = 9, 'Reds')
cols_range <- colorRampPalette(pal)(ceiling(max(moz$val)))
cols <- cols_range[ceiling(moz$val)]

# Define some stuff for the legened
legend_seq <- seq(5, 45, 10)
legend_cols <- cols_range[legend_seq]

# Create a leaflet widget
m <- leaflet(moz) %>%
  addProviderTiles("Stamen.TonerBackground") %>% 
  setView(lng=32.7971649, lat=-25.3923014, zoom=4) %>%
  addPolygons(
    stroke = FALSE, fillOpacity = 0.9, smoothFactor = 0.5,
    # color = ~colorQuantile("YlOrRd", moz$ID_1)(ID_1)
    color = cols) %>%
  addLegend(position = 'bottomright',
            colors = legend_cols,
            labels = legend_seq,
            opacity = 1,
            title = 'Prevalence')

# Save the widget to an html file
library(htmlwidgets)
saveWidget(m, file="~/Desktop/map.html")

{% endhighlight %}

### More data to come

This website is under construction.
