##  if the zip file does not exist, then download it
if (!file.exists("emission.zip"))
{
    download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip", "emission.zip", method = "curl")
}
##  if the zip file has not been unzipped, unzip it
if (!file.exists("summarySCC_PM25.rds") | !file.exists("Source_Classification_Code.rds"))
{
    unzip("emission.zip")
}

##  read the data
NEI <- readRDS("summarySCC_PM25.rds")

##  subset the data to Baltimore City
NEIBal <- NEI[NEI$fips == "24510",]

##  aggregate the data by summing up Emissions by year
dataQ3 <- aggregate(Emissions~year + type, data = NEIBal, sum)

##  generate and output the plot1
library(ggplot2)
png("plot3.png", 480, 480)
with(dataQ3, qplot(year, Emissions, geom = "path", colour = type, main = "Baltimore Total Emissions by Year by Type"))
dev.off()