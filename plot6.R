## Read the two datasets "summarySCC_PM25.rds" and "Source_Classification_Code.rds"
## with the readRDS() function and create two data frames "NEI" and "SCC"

NEI <- readRDS("exdata-data-NEI_data/summarySCC_PM25.rds")
SCC <- readRDS("exdata-data-NEI_data/Source_Classification_Code.rds")

## Create a new data frame by subsetting NEI for Baltimore City and
## Los Angeles County from motor vehicle sources by using type == "ON-ROAD"

NEI.baltimore.LA.motor.vehicle <- subset(NEI, type == "ON-ROAD" & (fips == "24510" | fips == "06037"))

## Load the ggplot2 package

library(ggplot2)

## Create a new data frame with the sum of emissions from motor vehicle
## sources per year with the aggregate() function on
## NEI.baltimore.LA.motor.vehicle data frame

total.emissions.baltimore.LA.motor.vehicle <- aggregate(NEI.baltimore.LA.motor.vehicle$Emissions, list(year = NEI.baltimore.LA.motor.vehicle$year, region = NEI.baltimore.LA.motor.vehicle$fips), sum, na.rm = TRUE)
colnames(total.emissions.baltimore.LA.motor.vehicle)[3] <- "emissions"

## Compute the delta between each year and 1999 to better visualise the
## changes in emissions from motor vehicle sources for Baltimore City
## and Los Angeles County

total.emissions.baltimore.LA.motor.vehicle$emissions[total.emissions.baltimore.LA.motor.vehicle$region == "06037"] <- total.emissions.baltimore.LA.motor.vehicle$emissions[total.emissions.baltimore.LA.motor.vehicle$region == "06037"] - total.emissions.baltimore.LA.motor.vehicle$emissions[total.emissions.baltimore.LA.motor.vehicle$region == "06037"][1]
total.emissions.baltimore.LA.motor.vehicle$emissions[total.emissions.baltimore.LA.motor.vehicle$region == "24510"] <- total.emissions.baltimore.LA.motor.vehicle$emissions[total.emissions.baltimore.LA.motor.vehicle$region == "24510"] - total.emissions.baltimore.LA.motor.vehicle$emissions[total.emissions.baltimore.LA.motor.vehicle$region == "24510"][1]
total.emissions.baltimore.LA.motor.vehicle$region[total.emissions.baltimore.LA.motor.vehicle$region == "06037"] <- "Los Angeles County"
total.emissions.baltimore.LA.motor.vehicle$region[total.emissions.baltimore.LA.motor.vehicle$region == "24510"] <- "Baltimore City"

## Plot the total emissions (in tons) vs. year from motor vehicle sources
## for Baltimore City and Los Angeles County (ggplot2 plotting system)

png(file ="plot6.png", width = 480, height = 480)
qplot(year, emissions, data = total.emissions.baltimore.LA.motor.vehicle, color = region, shape = region, geom = c("point", "line")) + ggtitle("Changes in emissions per year\n\nBaltimore City, Los Angeles County - Motor vehicle sources") + labs(x = "Years", y = bquote("Changes in PM"[2.5] ~  "emissions per year (in tons)"))
dev.off()