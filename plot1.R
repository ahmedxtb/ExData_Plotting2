## Read the two datasets "summarySCC_PM25.rds" and "Source_Classification_Code.rds"
## with the readRDS() function and create two data frames "NEI" and "SCC"

NEI <- readRDS("exdata-data-NEI_data/summarySCC_PM25.rds")
SCC <- readRDS("exdata-data-NEI_data/Source_Classification_Code.rds")

## Create a new data frame with the sum of emissions from all sources per year
## with the aggregate() function on NEI data frame

total.emissions <- aggregate(NEI$Emissions, list(year = NEI$year), sum, na.rm = TRUE)
colnames(total.emissions)[2] <- "emissions"

## Plot the total emissions (in mega-tons) vs. year from all sources for
## the USA (base plotting system)

png(file ="plot1.png", width = 480, height = 480)
plot(total.emissions$year, total.emissions$emissions / 1000000, type = "b", col = "red", xlab = "Years", ylab = bquote("Sum of PM"[2.5] ~  "emissions per year (in mega-tons)"))
title(bquote("Total emissions per year"), line = 3)
title(expression(italic("USA - All sources")), line = 2)
dev.off()