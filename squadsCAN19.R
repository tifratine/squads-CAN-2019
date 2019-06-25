setwd("~~")
#packages
library(rvest)
library(tidyverse)

#Scrap squads tables from wikipedia


countries<-c("Egypt","DR Congo", "Uganda", "Zimbabwe",
             "Nigeria", "Guinea", "Madagascar", "Burundi",
             "Senegal", "Algeria", "Kenya", "Tanzania",
             "Morocco", "Ivory Coast", "South Africa", "Namibia",
             "Tunisia", "Mali", "Mauritania", "Angola",
             "Cameroon", "Ghana", "Benin", "Guinea-Bissau")

url <- "https://en.wikipedia.org/wiki/2019_Africa_Cup_of_Nations_squads"
teams<-data.frame()
for (i in 1:length(countries)){
  xpth <-paste('//*[@id="mw-content-text"]/div/table[',i,']',sep = "")
  team <- url %>%
    html() %>%
    html_nodes(xpath=xpth) %>%
    html_table()
  team <- team[[1]]
  team$team<-countries[i]
  team <- team[, c("team", "No.", "Pos.", "Player", "Date of birth (age)", "Caps", "Club")]
  teams<-rbind(teams, team)
}

write.csv(teams,"teams_CAN_2019.csv")
