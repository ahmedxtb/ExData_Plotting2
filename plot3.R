## Read the two datasets "summarySCC_PM25.rds" and "Source_Classification_Code.rds"
## with the readRDS() function and create two data frames "NEI" and "SCC"

NEI <- readRDS("exdata-data-NEI_data/summarySCC_PM25.rds")
SCC <- readRDS("exdata-data-NEI_data/Source_Classification_Code.rds")

## Create a new data frame by subsetting NEI for Baltimore City

NEI.baltimore <- subset(NEI, fips == "24510")

## Load the ggplot2 package

library(ggplot2)

## Create a new data frame with the sum of emissions from "NONPOINT",
## "NON-ROAD", "ON-ROAD" and "POINT" sources per year with the
## aggregate() function on NEI.baltimore data frame

total.emissions.baltimore.type <- aggregate(NEI.baltimore$Emissions, list(source = NEI.baltimore$type, year = NEI.baltimore$year), sum, na.rm = TRUE)
colnames(total.emissions.baltimore.type)[3] <- "emissions"

## Plot the total emissions (in tons) vs. year from "NONPOINT", "NON-ROAD",
## "ON-ROAD" and "POINT" sources for Baltimore City (ggplot2 plotting system)

png(file ="plot3.png", width = 720, height = 720)
theme_set(theme_bw())
qplot(year, emissions, data = total.emissions.baltimore.type, color = source, shape = source, geom = c("point", "line")) + theme(plot.title = element_text(size = 20)) + ggtitle(expression(atop(bold("Total emissions per year"), atop(italic("Baltimore City - Point, nonpoint, onroad, nonroad sources"), "")))) + labs(x = "Years", y = bquote("Sum of PM"[2.5] ~  "emissions per year (in tons)"))
dev.off()