nei <- readRDS("data/summarySCC_PM25.rds")
scc <- readRDS("data/Source_Classification_Code.rds")

library('data.table')
library('ggplot2')

df <- data.table(nei)

baltimore <- subset(df, fips == '24510')

by_year <- baltimore[, list(emissions=sum(Emissions)), by=c('year', 'type')]
by_year$year = as.numeric(as.character(by_year$year))
by_year$emissions = as.numeric(as.character(by_year$emissions))

ggplot(data=by_year, aes(x=year, y=emissions, col=type)) + geom_line() + geom_point() + ggtitle("Emissions in Baltimore City")

dev.copy(png, file="plot3.png", width=480, height=480)
dev.off()
