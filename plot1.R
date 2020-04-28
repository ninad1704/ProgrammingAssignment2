nei <- readRDS("data/summarySCC_PM25.rds")
scc <- readRDS("data/Source_Classification_Code.rds")

library('data.table')

df <- data.table(nei)

by_year <- df[, list(emissions=sum(Emissions)), by=year]
by_year$year = as.numeric(as.character(by_year$year))
by_year$emissions = as.numeric(as.character(by_year$emissions))

plot(by_year$year, by_year$emissions, type='l', ylab='Emissions', xlab='Year')

dev.copy(png, file="plot1.png", width=480, height=480)
dev.off()
