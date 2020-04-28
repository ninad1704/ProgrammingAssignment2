nei <- readRDS("data/summarySCC_PM25.rds")
scc <- readRDS("data/Source_Classification_Code.rds")

library('data.table')
library('ggplot2')

merged <- merge(nei, scc, by="SCC")

df <- data.table(merged)

# Filter records to those which contains the word 'coal' in Short.Name
coal <- grepl("coal", df$Short.Name, ignore.case=TRUE)
coal <- data.table(merged[coal, ])

by_year <- coal[, list(emissions=sum(Emissions)), by=c('year')]
by_year$year = as.numeric(as.character(by_year$year))
by_year$emissions = as.numeric(as.character(by_year$emissions))

ggplot(data=by_year, aes(x=year, y=emissions)) + geom_line() + geom_point() + ggtitle("Emissions from Coal Sources in the US")

dev.copy(png, file="plot4.png", width=480, height=480)
dev.off()
