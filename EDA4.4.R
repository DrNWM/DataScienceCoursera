NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

setwd("C:/Users/User/OneDrive/Desktop Nvidia/DS notes/Chapter 4/Work 4.4/Data.NEI")

head(NEI)
names(NEI)
str(NEI)

head(SCC)
names(SCC)
str(SCC)

# Ques1
## Calculate total emission per y ear
total_emission <- aggregate(Emissions~year, NEI, sum)
summary(total_emission)

## Open PNG device
png("plot1.png",width= 480, height = 480)
plot(total_emission$year, total_emission$Emissions / 1000,
     type = "b", 
     pch = 19, 
     col = "blue", 
     xlab = "Year", 
     ylab="Total PM2.5 Emission (thousands of tons", 
     main = "Total PM 2.5 Emissions in US (1999-2008)", 
     xaxt = "n")
axis(1,at=total_emission$year, labels = total_emission$year)
grid()
dev.off()
print(total_emission)

# Ques2
## Baltimore is fips== "24510"

baltimore <-  subset(NEI, fips == "24510")
total_balt <- aggregate (Emissions ~ year, baltimore, sum)

png("plot2.png",width= 480, height = 480)
plot(total_emission$year, total_emission$Emissions / 1000,
     type = "b", 
     pch = 19, 
     col = "blue", 
     xlab = "Year", 
     ylab="Total PM2.5 Emission (thousands of tons", 
     main = "Total PM 2.5 Emissions in Baltimore (1999-2008)", 
     xaxt = "n")
axis(1,at=total_emission$year, labels = total_emission$year)
grid()
dev.off()
print(total_emission)

# Question 3
library(ggplot2)
baltimore <- subset(NEI, fips == "24510")

baltimore_by_type <- aggregate(Emissions ~ year + type, baltimore, sum)

png("plot3.png", width = 480, height = 480)
ggplot(baltimore_by_type,
       aes(x = factor(year), y = Emissions, color = type, group = type)) +
  geom_line() +
  geom_point() +
  labs(title = "Baltimore PM2.5 by Source Type (1999–2008)",
       x = "Year",
       y = "Total Emissions (tons)") +
  theme_minimal()
dev.off()

# Question 4
# Pick SCC rows containing both "Coal" and something like "Comb" in the descriptions
coal_scc <- subset(
  SCC,
  grepl("Coal", Short.Name, ignore.case = TRUE) |
    grepl("Coal", EI.Sector, ignore.case = TRUE)
)

coal_NEI <- subset(NEI, SCC %in% coal_scc$SCC)

coal_by_year <- aggregate(Emissions ~ year, coal_NEI, sum)

png("plot4.png", width = 480, height = 480)
ggplot(coal_by_year, aes(x = factor(year), y = Emissions)) +
  geom_bar(stat = "identity", fill = "steelblue") +
  labs(title = "US PM2.5 from Coal‑Combustion Sources (1999–2008)",
       x = "Year",
       y = "Total Emissions (tons)") +
  theme_minimal()
dev.off()

# Question 5
vehicle_scc <- subset(
  SCC,
  grepl("On-Road", EI.Sector, ignore.case = TRUE) |
    grepl("Vehicle", EI.Sector, ignore.case = TRUE)
)

vehicle_NEI <- subset(NEI, SCC %in% vehicle_scc$SCC)

balt_vehicle <- subset(vehicle_NEI, fips == "24510")

balt_vehicle_by_year <- aggregate(Emissions ~ year, balt_vehicle, sum)

png("plot5.png", width = 480, height = 480)
ggplot(balt_vehicle_by_year, aes(x = factor(year), y = Emissions)) +
  geom_bar(stat = "identity", fill = "darkorange") +
  labs(title = "Baltimore Motor Vehicle PM2.5 (1999–2008)",
       x = "Year",
       y = "Total Emissions (tons)") +
  theme_minimal()
dev.off()


# QUestion 6
la_vehicle   <- subset(vehicle_NEI, fips == "06037")
balt_vehicle <- subset(vehicle_NEI, fips == "24510")

balt_vehicle$city <- "Baltimore"
la_vehicle$city   <- "Los Angeles"

both_cities <- rbind(balt_vehicle, la_vehicle)

both_by_year <- aggregate(Emissions ~ year + city, both_cities, sum)

png("plot6.png", width = 480, height = 480)
ggplot(both_by_year,
       aes(x = factor(year), y = Emissions, color = city, group = city)) +
  geom_line() +
  geom_point() +
  labs(title = "Motor Vehicle PM2.5: Baltimore vs Los Angeles (1999–2008)",
       x = "Year",
       y = "Total Emissions (tons)") +
  theme_minimal()
dev.off()





