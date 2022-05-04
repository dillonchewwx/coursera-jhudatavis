#Install the magick package

install.packages("magick")

#Load the required libraries:

library(gganimate)

library(magick)

fig <-ggplot(....[your animation code, using gganimate]

animate(fig,renderer=magick_renderer())