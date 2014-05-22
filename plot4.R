## Read the two datasets "summarySCC_PM25.rds" and "Source_Classification_Code.rds"
## with the readRDS() function and create two data frames "NEI" and "SCC"

NEI <- readRDS("exdata-data-NEI_data/summarySCC_PM25.rds")
SCC <- readRDS("exdata-data-NEI_data/Source_Classification_Code.rds")

## Extract from "NEI" data frame the values corresponding to the lines of
## the "SCC" data frame containing the terms "coal" an "comb" in "EI.Sector" column

SCC.coal <- SCC[grepl("coal", SCC$EI.Sector, ignore.case = TRUE), ]
SCC.coal.comb <- SCC.coal[grepl("comb", SCC.coal$EI.Sector, ignore.case = TRUE), ]
NEI.coal.comb <- subset(NEI, SCC %in% SCC.coal.comb$SCC)

## Create a new data frame with the sum of emissions from coal combustion related
## sources per year with the aggregate() function on NEI.coal.comb data frame

total.emissions.coal.comb <- aggregate(NEI.coal.comb$Emissions, list(year = NEI.coal.comb$year), sum, na.rm = TRUE)
colnames(total.emissions.coal.comb)[2] <- "emissions"

## Plot the total emissions (in kilo-tons) vs. year from coal combustion sources
## for the USA (base plotting system)

png(file ="plot4.png", width = 720, height = 720)
par(ps = 12, cex.main = 1.7)
plot(total.emissions.coal.comb$year, total.emissions.coal.comb$emissions / 1000, type = "b", col = "red", xlab = "Years", ylab = bquote("Sum of PM"[2.5] ~  "emissions per year (in kilo-tons)"))
title(bquote("Total emissions per year"), line = 3)
title(expression(italic("USA - Coal combustion sources")), line = 2)
dev.off()