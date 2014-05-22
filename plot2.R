## Read the two datasets "summarySCC_PM25.rds" and "Source_Classification_Code.rds"
## with the readRDS() function and create two data frames "NEI" and "SCC"

NEI <- readRDS("exdata-data-NEI_data/summarySCC_PM25.rds")
SCC <- readRDS("exdata-data-NEI_data/Source_Classification_Code.rds")

## Create a new data frame by subsetting NEI for Baltimore City

NEI.baltimore <- subset(NEI, fips == "24510")

## Create a new data frame with the sum of emissions from all sources per year
## with the aggregate() function on NEI.baltimore data frame

total.emissions.baltimore <- aggregate(NEI.baltimore$Emissions, list(year = NEI.baltimore$year), sum, na.rm = TRUE)
colnames(total.emissions.baltimore)[2] <- "emissions"

## Plot the total emissions (in kilo-tons) vs. year from all sources
## for Baltimore City (base plotting system)

png(file ="plot2.png", width = 720, height = 720)
par(ps = 12, cex.main = 1.7)
plot(total.emissions.baltimore$year, total.emissions.baltimore$emissions / 1000, type = "b", col = "red", xlab = "Years", ylab = bquote("Sum of PM"[2.5] ~  "emissions per year (in kilo-tons)"))
title(bquote("Total emissions per year"), line = 3)
title(expression(italic("Baltimore City - All sources")), line = 2)
dev.off()