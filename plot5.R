## Read the two datasets "summarySCC_PM25.rds" and "Source_Classification_Code.rds"
## with the readRDS() function and create two data frames "NEI" and "SCC"

NEI <- readRDS("exdata-data-NEI_data/summarySCC_PM25.rds")
SCC <- readRDS("exdata-data-NEI_data/Source_Classification_Code.rds")

## Create a new data frame by subsetting NEI for Baltimore City and
## motor vehicle sources by using type == "ON-ROAD"

NEI.baltimore.motor.vehicle <- subset(NEI, type == "ON-ROAD" & fips == "24510")

## Create a new data frame with the sum of emissions from motor vehicle
## sources per year with the aggregate() function on
## NEI.baltimore.motor.vehicle data frame

total.emissions.baltimore.motor.vehicle <- aggregate(NEI.baltimore.motor.vehicle$Emissions, list(year = NEI.baltimore.motor.vehicle$year), sum, na.rm = TRUE)
colnames(total.emissions.baltimore.motor.vehicle)[2] <- "emissions"

## Plot the total emissions (in tons) vs. year from motor vehicle sources
## for the Baltimore City (base plotting system)

png(file ="plot5.png", width = 480, height = 480)
plot(total.emissions.baltimore.motor.vehicle$year, total.emissions.baltimore.motor.vehicle$emissions, type = "b", col = "red", xlab = "Years", ylab = bquote("Sum of PM"[2.5] ~  "emissions per year (in tons)"))
title(bquote("Total emissions per year"), line = 3)
title(expression(italic("Baltimore City - Motor vehicle sources")), line = 2)
dev.off()