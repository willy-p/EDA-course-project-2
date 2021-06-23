# Load png
library(png)

# Read files into R
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Get total emissions for each year
totals <- with(NEI, tapply(Emissions, year, sum, na.rm = T))

# Get years
years <- as.numeric(names(totals))

# Plot PM2.5 Emissions Per Year
png(file = "plot1.png")
plot(years, totals, xlab = "Year",
     ylab = "Total PM2.5 Emissions Per Year (tons)",
     main = "Total PM2.5 Emissions in the US from 1999 to 2008")
dev.off()
