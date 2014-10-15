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

##  subset the data by type ON-ROAD and cities are Baltimore and LA
NEIVeh <- NEI[NEI$type == "ON-ROAD" & NEI$fips %in% c("24510", "06037"), ]

##  aggregate the data by summing up Emissions by year
dataQ6 <- aggregate(Emissions~year + fips, data = NEIVeh, sum)
city <- ifelse(dataQ6$fips == "24510", "Baltimore", "LA")
dataQ6$city <- city
    
##  generate and output the plot1
library(ggplot2)
png("plot6.png", 480, 480)
with(dataQ6, qplot(year, Emissions, geom = "path", colour = city, main = "Bal vs LA on Total Emissions by Year by Type"))
dev.off()