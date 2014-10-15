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
SCC <- readRDS("Source_Classification_Code.rds")

##  get the Coal Combution related SCC
SCCCoal <- SCC[grepl("coal", SCC$EI.Sector, ignore.case = T), "SCC"]

##  subset the data by SCCCoal
NEICoal <- NEI[NEI$SCC %in% SCCCoal, ]

##  aggregate the data by summing up Emissions by year
dataQ4 <- aggregate(Emissions~year, data = NEICoal, sum)

##  generate and output the plot1
png("plot4.png", 480, 480)
with(dataQ4, plot(year, Emissions, type = "l", main = "Total Emissions by Year (Coal Combution Related)", xlab = "year", ylab = "Emissions"))
dev.off()