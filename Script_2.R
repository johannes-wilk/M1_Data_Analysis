#_______________________________________________________________________________
# M1 Data Analysis

# Practical 2
#_______________________________________________________________________________

# Clean
graphics.off()
rm(list = ls(all = TRUE))

#install.packages("ggplot2")
library(ggplot2)
library(tidyverse)

setwd("~/1_Dokumente/3_Studium/1_Uni Potsdam/1_Module/M1_GEE-CM01_Data Analysis/Practicals/Practical 2")
dir()

# the dataset contains informatino about glaciers and their coordinates
glac <- read.csv("11_rgi60_CentralEurope.csv")

#_______________________________________________________________________________

# here we want to display plot with two variables
# theme_minimal is the color of the background
ggplot(glac) +
  geom_point(aes(x = CenLat, 
                 y = Zmin),
             alpha = 0.1) +
  labs(x = "Latitude", 
       y = "Glacier toe elevation", 
       title = "European Glacier") +
  theme_minimal()

#_______________________________________________________________________________

# here we want to calculate a trend line with a simple formula
mod1 <- lm(Zmin ~ CenLat, data = glac)
mod2 <- lm(Zmin ~ CenLat + CenLon, data = glac)  
summary (mod1)  
summary (mod2)  

ggplot(glac, aes(x= CenLat, 
                 y =Zmin))+ 
  geom_point( alpha =0.1)+ 
  labs (x= "Latitude (°)", 
        y="Glacier-toe elevation (m.a.s.l.)", 
        title ="European Glaciers, lin. regression") + 
  geom_smooth(methode="lm", formula=y~x, col="red")

#_______________________________________________________________________________

# here we want to calculate something
ggplot(glac, aes(x= CenLat, 
                 y =residuals(mod1)))+ 
  geom_point( alpha =0.1)+ 
  labs (x= "Latitude (°)", 
        y="Residual values", 
        title ="Residuals of Simple Linear Regression") + 
  geom_abline(intercept = 0, 
              slope = 0, 
              col = "red",
              lty = 2)


#_______________________________________________________________________________
#_______________________________________________________________________________