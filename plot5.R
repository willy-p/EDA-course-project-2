# Read files into R
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Load ggplot2
library(tidyverse)

# Subset Baltimore City data
balt <- subset(NEI, fips == "24510")

# Get all SCC codes that have motor vehicles
mv <- SCC[grep("vehicle", SCC$EI.Sector, ignore.case = TRUE),]

# Get all emissions data from motor vehicle sources in Baltimore
mv_data <- semi_join(balt, mv, by = "SCC")
mv_data$year <- as.factor(mv_data$year)


# Plot 
p <- ggplot(mv_data, aes(x=year, y=Emissions))
p + scale_y_log10() + geom_boxplot() +
        labs(y = "PM2.5 emissions (tons)",
             title = "PM2.5 Emissions from motor vehicle sources in Baltimore city from 1999-2008")
ggsave("plot5.png")