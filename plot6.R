# Read files into R
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Load ggplot2
library(tidyverse)

# Subset Baltimore City data
balt <- subset(NEI, fips == "24510")
la <- subset(NEI, fips == "06037")

# Get all SCC codes that have motor vehicles
mv <- SCC[grep("vehicle", SCC$EI.Sector, ignore.case = TRUE),]

# Get all emissions data from motor vehicle sources in Baltimore and LA
# and combine in one dataframe
mv_balt <- semi_join(balt, mv, by = "SCC")
mv_balt$year <- as.factor(mv_balt$year)
mv_balt$City <- "Baltimore"
mv_la <- semi_join(la, mv, by = "SCC")
mv_la$year <- as.factor(mv_la$year)
mv_la$City <- "LA"

mv_data <- rbind(mv_balt, mv_la)

# Plot 
p <- ggplot(mv_data, aes(x=year, y=Emissions, fill=City))
p + scale_y_log10() + geom_boxplot() +
        labs(y = "PM2.5 emissions (tons)",
             title = "PM2.5 Emissions from motor vehicle sources in Baltimore and LA from 1999-2008")
ggsave("plot6.png")