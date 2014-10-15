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

##  aggregate the data by summing up Emissions by year
dataQ1 <- aggregate(Emissions~year, data = NEI, sum)

##  generate and output the plot1
png("plot1.png", 480, 480)
with(dataQ1, plot(year, Emissions, type = "l", main = "Total Emissions by Year", xlab = "year", ylab = "Emissions"))
dev.off()