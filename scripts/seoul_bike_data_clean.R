install.packages("tidyverse")

library(tidyverse)


#======= Import raw


bike_data_raw <- read.csv("SeoulBikeData_alt.csv", fileEncoding = "CP949")




#========= Hourly baseline

bike_data_baseline <- bike_data_raw %>% 
  mutate(`Rental Count` = Rented.Bike.Count) %>% 
  mutate(`Rental Period` = case_when(
    Hour %in% 6:10 ~ "Morning Commute",
    Hour %in% 16:19 ~ "Evening Commute",
    Hour %in% 11:15 ~ "Midday",
    Hour %in% 20:23 ~ "Night",
    TRUE ~ "Off Hours"
  )) %>% 
  mutate(Order = case_when(
    `Rental Period` == "Off Hours" ~ 1,
    `Rental Period` == "Morning Commute" ~ 2,
    `Rental Period` == "Midday" ~ 3,
    `Rental Period` == "Evening Commute" ~ 4,
    `Rental Period` == "Night" ~ 5,
  )) %>% 
  mutate(`Condition Type` = "All Conditions",
         `Condition Value` = "All Conditions") %>% 
  group_by(Hour, `Rental Period`, `Condition Type`, `Condition Value`) %>% 
  summarise(`Average Rentals` = round(mean(`Rental Count`), digits = 2),
            `Rental Count` = sum(`Rental Count`))
 

#========= Precipitation

bike_data_precipitation <- bike_data_raw %>% 
  mutate(`Rental Count` = Rented.Bike.Count) %>% 
  mutate(`Rental Period` = case_when(
    Hour %in% 6:10 ~ "Morning Commute",
    Hour %in% 16:19 ~ "Evening Commute",
    Hour %in% 11:15 ~ "Midday",
    Hour %in% 20:23 ~ "Night",
    TRUE ~ "Off Hours"
  )) %>% 
  mutate(Precipitation = case_when(
    Rainfall.mm. > 0 & Snowfall..cm. > 0 ~ "Mixed",
    Rainfall.mm. > 0 & Snowfall..cm. == 0 ~ "Rain",
    Rainfall.mm. == 0 & Snowfall..cm. > 0 ~ "Snow",
    Rainfall.mm. == 0 & Snowfall..cm. == 0 ~ "None"
  )) %>% 
  mutate(`Condition Type` = "Precipitation",
         `Condition Value` = Precipitation) %>% 
  group_by(Hour, `Rental Period`, `Condition Type`, `Condition Value`) %>% 
  summarise(`Average Rentals` = round(mean(`Rental Count`), digits = 2),
            `Rental Count` = sum(`Rental Count`)) 



#=========== Temperature

bike_data_temp <- bike_data_raw %>% 
  mutate(`Rental Count` = Rented.Bike.Count) %>% 
  mutate(`Rental Period` = case_when(
    Hour %in% 6:10 ~ "Morning Commute",
    Hour %in% 16:19 ~ "Evening Commute",
    Hour %in% 11:15 ~ "Midday",
    Hour %in% 20:23 ~ "Night",
    TRUE ~ "Off Hours"
  )) %>%
  mutate(Temperature = case_when(
    Temperature.캜. < 0 ~ "Cold",
    Temperature.캜. >= 0 & Temperature.캜. < 15 ~ "Cool",
    Temperature.캜. >= 15 & Temperature.캜. < 25 ~ "Mild",
    Temperature.캜. >= 25 ~ "Warm"
  )) %>% 
  mutate(`Condition Type` = "Temperature",
         `Condition Value` = Temperature) %>% 
  group_by(Hour, `Rental Period`, `Condition Type`, `Condition Value`) %>% 
  summarise(`Average Rentals` = round(mean(`Rental Count`), digits = 2),
            `Rental Count` = sum(`Rental Count`))


#======== Humidity

bike_data_humidity <- bike_data_raw %>% 
  mutate(`Rental Count` = Rented.Bike.Count) %>% 
  mutate(`Rental Period` = case_when(
    Hour %in% 6:10 ~ "Morning Commute",
    Hour %in% 16:19 ~ "Evening Commute",
    Hour %in% 11:15 ~ "Midday",
    Hour %in% 20:23 ~ "Night",
    TRUE ~ "Off Hours"
  )) %>%
  mutate(Humidity = case_when(
    Humidity... < 40 ~ "Dry",
    Humidity... >= 40 & Humidity... < 60 ~ "Moderate",
    Humidity... >= 60 & Humidity... < 80 ~ "Humid",
    Humidity... >= 80 ~ "Very Humid"
  )) %>%
  mutate(`Condition Type` = "Humidity",
         `Condition Value` = Humidity) %>% 
  group_by(Hour, `Rental Period`, `Condition Type`, `Condition Value`) %>% 
  summarise(`Average Rentals` = round(mean(`Rental Count`), digits = 2),
            `Rental Count` = sum(`Rental Count`))



#======== Combine


bike_data_combined <- bind_rows(bike_data_baseline, bike_data_precipitation, bike_data_temp, bike_data_humidity)



#======= Add Time labels

bike_data_combined$`Time of Day` <- case_when(
  bike_data_combined$Hour == 0 ~ "12 AM",
  bike_data_combined$Hour == 1 ~ "1 AM",
  bike_data_combined$Hour == 2 ~ "2 AM",
  bike_data_combined$Hour == 3 ~ "3 AM",
  bike_data_combined$Hour == 4 ~ "4 AM",
  bike_data_combined$Hour == 5 ~ "5 AM",
  bike_data_combined$Hour == 6 ~ "6 AM",
  bike_data_combined$Hour == 7 ~ "7 AM",
  bike_data_combined$Hour == 8 ~ "8 AM",
  bike_data_combined$Hour == 9 ~ "9 AM",
  bike_data_combined$Hour == 10 ~ "10 AM",
  bike_data_combined$Hour == 11 ~ "11 AM",
  bike_data_combined$Hour == 12 ~ "12 PM",
  bike_data_combined$Hour == 13 ~ "1 PM",
  bike_data_combined$Hour == 14 ~ "2 PM",
  bike_data_combined$Hour == 15 ~ "3 PM",
  bike_data_combined$Hour == 16 ~ "4 PM",
  bike_data_combined$Hour == 17 ~ "5 PM",
  bike_data_combined$Hour == 18 ~ "6 PM",
  bike_data_combined$Hour == 19 ~ "7 PM",
  bike_data_combined$Hour == 20 ~ "8 PM",
  bike_data_combined$Hour == 21 ~ "9 PM",
  bike_data_combined$Hour == 22 ~ "10 PM",
  bike_data_combined$Hour == 23 ~ "11 PM"
)

write.csv(bike_data_combined, "bike_data_combined.csv", row.names = FALSE)

