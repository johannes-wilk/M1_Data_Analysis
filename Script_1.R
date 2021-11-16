#_______________________________________________________________________________
# M1 Data Analysis

# Practical 1
#_______________________________________________________________________________

# Clean
graphics.off()
rm(list = ls(all = TRUE))

#install.packages("ggplot2")
library(ggplot2)
library(tidyverse)
library(rmarkdown)


setwd("~/1_Dokumente/3_Studium/1_Uni Potsdam/1_Module/M1_GEE-CM01_Data Analysis/Practicals/Practical 1")
dir()

dat <- read.csv2("TCE-DAT_2015-exposure_1950-2015.csv", sep = ';')
# here we use read.csv2 - i dont know why. Since I know we could also use read.csv
# what we cannot use is read.table() because first row is set to V1, V2, ...
print(dat)
str(dat)
summary(dat)
ls(dat)
names(dat)
# str() is another way to print the data and to have a look on it


#_______________________________________________________________________________
# plot different variables from the tables into ggplot2
ggplot(data = dat) +
  geom_point(mapping = aes(x = year,
                          y = v_land_SI)
            )

# here we want to display three variables
# labs = all the lables and descriptions of the elements in your plot
# aes = aesthetics
ggplot(data = dat) +
  labs(x = "year",
       y = "Wind speed at landfall (m/s)",
       title = "Landfalling tropical cyclones, 1950-2015",
       color = "People \nexposed \n(log10)") +
  geom_point(mapping = aes(x = year,
                           y = v_land_SI,
                           col = log10(X96kn_pop)
             ),
             alpha = 0.25 # 75% transparency
             )

#_______________________________________________________________________________
# here we display several datasets and several diagrams
# facet_wrap(variable) is the command to display several diagrams
ggplot(data = dat) +
  labs(x = "Year", 
       y = "Wind speed at landfall (m/s)",
       title = "Landfalling tropical cyclones by ocean, 1950-2015",
       color = "People \nexposed \n(log10)") + 
  geom_point(mapping = aes(x = year, 
                           y = v_land_SI, 
                           col = log10(X96kn_pop)),
             size = 0.5) +
  facet_wrap(~ genesis_basin, nrow = 2)

# geom_boxplot
# trend line
ggplot(data = dat,
       mapping = aes(x = year, y = v_land_SI)) +
  labs(x = "Year", 
       y = "Wind speed at landfall (m/s)",
       title = "Landfalling tropical cyclones by ocean, 1950-2015",
       color = "People \nexposed \n(log10)") + 
  geom_boxplot(aes(group = cut(year, (2015 - 1950) / 5)), 
               col = "darkgreen") +
  geom_smooth(col = "black") +
  facet_wrap(~ genesis_basin, nrow = 2)


#_______________________________________________________________________________
# maximum values line diagram
(v_max <- summarize(group_by(dat, year, genesis_basin),
                    v_max_SI = max(v_land_SI)))

ggplot(data = v_max) +
  labs(x = "Year",
       y = "Highest annual wind speed (m/s)",
       title = "Landfalling tropical cyclones by ocean, 1950-2015") + 
  geom_line(mapping = aes(x = year, 
                          y = v_max_SI, 
                          col = genesis_basin), 
            lwd = 0.5, show.legend = FALSE) +
  facet_wrap(~ genesis_basin, nrow = 2)



#_______________________________________________________________________________
#_______________________________________________________________________________