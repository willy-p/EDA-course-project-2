# Load png
library(png)

# Read files into R
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Load ggplot2
library(tidyverse)

# Subset Baltimore City data
balt <- subset(NEI, fips == "24510")

# Get all SCC codes that have coal
coal_scc <- SCC[grep("coal", SCC$SCC.Level.Three, ignore.case = TRUE),]

# Get all emissions data from coal sources
coal_data <- semi_join(NEI, coal_scc, by = "SCC")
coal_data$year <- as.factor(coal_data$year)


# Plot 
p <- ggplot(coal_data, aes(x=year, y=Emissions))
p + scale_y_log10() + geom_boxplot() +
        labs(y = "PM2.5 emissions (tons)",
             title = "PM2.5 Emissions from coal combustion-related sources across the US from 1999-2008")
ggsave("plot4.png")
dev.off()
