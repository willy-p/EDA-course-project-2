# Load png
library(png)

# Read files into R
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Load ggplot2
library(tidyverse)

# Subset Baltimore City data
balt <- subset(NEI, fips == "24510")

# Get means for each type for each year
types <- unique(balt$type)
t1 <- subset(balt, type == types[1])
t1m <- t1 %>%
        group_by(year) %>%
        summarize(mean = mean(Emissions))
t1m$type <- types[1]

t2 <- subset(balt, type == types[2])
t2m <- t2 %>%
        group_by(year) %>%
        summarize(mean = mean(Emissions))
t2m$type <- types[2]

t3 <- subset(balt, type == types[3])
t3m <- t3 %>%
        group_by(year) %>%
        summarize(mean = mean(Emissions))
t3m$type <- types[3]

t4 <- subset(balt, type == types[4])
t4m <- t4 %>%
        group_by(year) %>%
        summarize(mean = mean(Emissions))
t4m$type <- types[4]
means <- bind_rows(t1m, t2m, t3m, t4m)

# Plot 
p <- qplot(year, mean, data = means, facets = . ~ type)
p + labs(y = "Mean PM2.5 emissions (tons)", 
              title = "Mean PM2.5 Emissions Per Year in Baltimore City from 
         2000 to 2008 from different sources")

ggsave("plot3.png")
dev.off()
