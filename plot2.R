# Load png
library(png)

# Read files into R
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Subset Baltimore City data
balt <- subset(NEI, fips == "24510")

# Get total emissions for each year
total1 <- with(balt, tapply(Emissions, year, sum, na.rm = T))

# Get years
years <- as.numeric(names(total1))

# Plot 
png(file = "plot2.png")
plot(years, total1, xlab = "Year", 
     ylab = "Total PM2.5 Emissions Per Year (tons)", 
     main = "Total PM2.5 Emissions in Baltimore City, MD from 1999 to 2008")
dev.off()
