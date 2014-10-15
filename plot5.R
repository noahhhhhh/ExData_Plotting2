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

##  subset the data by type ON-ROAD and city is Baltimore
NEIVeh <- NEI[NEI$type == "ON-ROAD" & NEI$fips == "24510", ]

##  aggregate the data by summing up Emissions by year
dataQ5 <- aggregate(Emissions~year, data = NEIVeh, sum)

##  generate and output the plot1
png("plot5.png", 480, 480)
with(dataQ5, plot(year, Emissions, type = "l", main = "Baltimore Total Emissions by Year (Vehical)", xlab = "year", ylab = "Emissions"))
dev.off()