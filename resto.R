rm(list=ls())

library(rvest)



# html <- read_html("https://www.gaultmillau.be/nl/restaurants")
# 
# html <- html_elements(html, "body")
# html <- html_elements(html, "section")
# #html_elements(html, "div")
# html <- html[1]
# 
# names <- html_elements(html, "h3")
# names <- html_text2(names)
# names <- as.data.frame(names)
# 
# scores <- html_elements(html, "h4")
# scores <- html_text2(scores)
# scores <- as.data.frame(scores)
# scores <- as.data.frame(scores[4:27,])
# 
# data <- cbind(names, scores)
# colnames(data)[2] <- "scores"
# 
# data$scores <- substr(data$scores, 1, nchar(data$scores)-2)
# data$scores <- sub(",", ".", data$scores, fixed = TRUE)
# data$scores <- as.numeric(data$scores)
# fulldata <- data
# 
# 
# for (page in 2:55) {
#   link <- paste0("https://www.gaultmillau.be/nl/restaurants?page=", page)
#   html <- read_html(link)
# 
#   html <- html_elements(html, "body")
#   html <- html_elements(html, "section")
#   #html_elements(html, "div")
#   html <- html[1]
# 
#   names <- html_elements(html, "h3")
#   names <- html_text2(names)
#   names <- as.data.frame(names)
# 
#   scores <- html_elements(html, "h4")
#   scores <- html_text2(scores)
#   scores <- as.data.frame(scores)
#   scores <- as.data.frame(scores[4:27,])
# 
#   data <- cbind(names, scores)
#   colnames(data)[2] <- "scores"
# 
#   data$scores <- substr(data$scores, 1, nchar(data$scores)-2)
#   data$scores <- sub(",", ".", data$scores, fixed = TRUE)
#   data$scores <- as.numeric(data$scores)
# 
#   fulldata <- rbind(fulldata, data)
# }
# 
# GM <- fulldata
# 
# 
# ########################################################################################################################
# 
# 
# html <- read_html("https://guide.michelin.com/be/nl/selection/belgium/restaurants/3-stars-michelin?sort=lowestPrice")
# html <- html_elements(html, "body")
# html <- html_elements(html, "section")
# html <- html[1]
# html
# names <- html_elements(html, "h3")
# names <- html_text2(names)
# 
# scores <- rep(3, length(names))
# 
# data <- cbind(names, scores)
# fulldata <- data
# 
# ###
# 
# html <- read_html("https://guide.michelin.com/be/nl/selection/belgium/restaurants/2-stars-michelin?sort=lowestPrice")
# html <- html_elements(html, "body")
# html <- html_elements(html, "section")
# html <- html[1]
# html
# names <- html_elements(html, "h3")
# names <- html_text2(names)
# 
# scores <- rep(2, length(names))
# 
# data <- cbind(names, scores)
# fulldata <- rbind(fulldata, data)
# 
# #
# 
# html <- read_html("https://guide.michelin.com/be/nl/selection/belgium/restaurants/2-stars-michelin/page/2?sort=lowestPrice")
# html <- html_elements(html, "body")
# html <- html_elements(html, "section")
# html <- html[1]
# html
# names <- html_elements(html, "h3")
# names <- html_text2(names)
# 
# scores <- rep(2, length(names))
# 
# data <- cbind(names, scores)
# fulldata <- rbind(fulldata, data)
# 
# ###
# 
# html <- read_html("https://guide.michelin.com/be/nl/selection/belgium/restaurants/1-star-michelin?sort=lowestPrice")
# html <- html_elements(html, "body")
# html <- html_elements(html, "section")
# html <- html[1]
# html
# names <- html_elements(html, "h3")
# names <- html_text2(names)
# 
# scores <- rep(1, length(names))
# 
# data <- cbind(names, scores)
# fulldata <- rbind(fulldata, data)
# 
# #
# 
# for (page in 2:6) {
#   link <- paste0("https://guide.michelin.com/be/nl/selection/belgium/restaurants/1-star-michelin/page/", page,"?sort=lowestPrice")
#   html <- read_html(link)
#   html <- html_elements(html, "body")
#   html <- html_elements(html, "section")
#   html <- html[1]
#   html
#   names <- html_elements(html, "h3")
#   names <- html_text2(names)
# 
#   scores <- rep(1, length(names))
# 
#   data <- cbind(names, scores)
#   fulldata <- rbind(fulldata, data)
# }
# 
# Mich <- as.data.frame(fulldata)
# Mich$scores <- as.character(Mich$scores)
# 
# 
# ########################################################################################################################
# 
# #julien
# 
# df_merge <- merge(Mich, GM, by = "names", all.x = TRUE, all.y = TRUE)
# 
# rijen <- c()
# 
# for (rij in 1:nrow(df_merge)) {
# 
#   if (is.na(df_merge$scores.y[rij])) {
# 
#     #scores.y = GM
#     #if that's NA then we start
# 
#     #get the name (the one used in Mich)
#     rij_name <- df_merge$names[rij]
#     if (is.na(rij_name)) {
#       break
#     }
# 
#     #find the most similar name in GM
#     #loop over max.dist 0,01 to 20
# 
#     for (dist in c(0.01, 0.05, 0.1, 0.15, 0.25, 0.5, 1, 1.5, 2:25)) {
# 
#       x <- agrep(rij_name, GM$names, ignore.case=T, value = T, max.distance = dist, useBytes = F)
# 
#       if (length(x)>0) {
#         print (dist)
#         print (x[1])
#         print (rij_name)
# 
#         question1 <- readline("Do these names refer to the same restaurant? (Y/N)")
#         if(regexpr(question1, 'y', ignore.case = TRUE) == 1){
#           #match data
#           #get the GM score and put it in
# 
#           df_merge$scores.y[rij] <- GM$scores[GM$names==x[1]]
# 
#           rijen <- c(rijen, which(df_merge$names==x[1]))
#           break
# 
#         } else if (regexpr(question1, 'n', ignore.case = TRUE) == 1){
#           next
#         } else {
#           print("this is en unexpected outcome")
#           break
#         }
# 
#       }
# 
#     }
# 
#   }
# 
# }
# 
# df_merge <- df_merge[-c(rijen), ]
# 
# 
# #################################################################################
# #2024#
# 
# df_merge$scores.x[is.na(df_merge$scores.x)] <- 0
# 
# df_merge$scores.x[df_merge$names=="Colette"] <- 2
# df_merge <- df_merge[-c(which(df_merge$names=="Colette - De Vijvers")), ]
# 
# df_merge$scores.x[df_merge$names=="Eed"] <- 1
# df_merge <- df_merge[-c(which(df_merge$names=="EED")), ]
# 
# df_merge$scores.x[df_merge$names=="Zet'Joe"] <- 2
# df_merge <- df_merge[-c(which(df_merge$names=="Zet'Joe by Geert Van Hecke")), ]
# 
# df_merge <- df_merge[-c(which(df_merge$names=="Julien")), ]
# 
# df_merge <- df_merge[-c(which(df_merge$names=="Michel")), ]
# 
# #################################################################################
# #2025#
# 
# df_merge$scores.x[is.na(df_merge$scores.x)] <- 0
# 
# df_merge$scores.x[df_merge$names=="Haut"] <- 1
# df_merge <- df_merge[-c(which(df_merge$names=="HAUT")), ]
# 
# df_merge$scores.x[df_merge$names=="Eed"] <- 1
# df_merge <- df_merge[-c(which(df_merge$names=="EED")), ]
# 
# df_merge$scores.x[df_merge$names=="Zet'Joe"] <- 1
# df_merge <- df_merge[-c(which(df_merge$names=="Zet'Joe by Geert Van Hecke")), ]
# 
# df_merge <- df_merge[complete.cases(df_merge), ]
# 
# df_merge$scores.x[df_merge$names=="De Copain"] <- 0
# df_merge$scores.x[df_merge$names=="La Fontanella"] <- 0
# df_merge$scores.x[df_merge$names=="Mariette"] <- 0
# 
# df_merge <- df_merge[(df_merge$Names!="The Jane"), ]
# 
# #################################################################################

#select and ctrl+shift+c to comment/uncomment

# load("C:/Users/Martijn/Desktop/resto24.RData")
# load("C:/Users/Martijn/Desktop/resto25.RData")

colnames(df_merge) <- c("Names", "Michelin", "Gault.Millau")

library(data.table)
setDT(df_merge)[ , list(mean_gr = round(mean(Gault.Millau), digits = 2)) , by = .(Michelin)]

boxplot(Gault.Millau ~ Michelin, data = df_merge)

library(ggplot2)
ggplot(df_merge, aes(y = Gault.Millau, x = Michelin, color = Michelin)) + 
  geom_jitter(width = 0.3, height = 0.05)


###
#2024#
h1 <- df_merge[df_merge$Michelin==0 & df_merge$Gault.Millau>15.5]
h2 <- df_merge[df_merge$Michelin==1 & df_merge$Gault.Millau>17]
h3 <- df_merge[df_merge$Michelin==2 & df_merge$Gault.Millau>18]
high <- rbind(h1, h2, h3)

l1 <- df_merge[df_merge$Michelin==1 & df_merge$Gault.Millau<13.5]
l2 <- df_merge[df_merge$Michelin==2 & df_merge$Gault.Millau<16.5]
low <- rbind(l1, l2)

###
#2025#
h1 <- df_merge[df_merge$Michelin==0 & df_merge$Gault.Millau>15.5]
h2 <- df_merge[df_merge$Michelin==1 & df_merge$Gault.Millau>17]
h3 <- df_merge[df_merge$Michelin==2 & df_merge$Gault.Millau>18]
high <- rbind(h1, h2, h3)

l1 <- df_merge[df_merge$Michelin==1 & df_merge$Gault.Millau<14]
l2 <- df_merge[df_merge$Michelin==2 & df_merge$Gault.Millau<17]
low <- rbind(l1, l2)


###ANOVA
df_merge$Michelin <- factor(df_merge$Michelin)

restaunova <- aov(formula= Gault.Millau~Michelin, data=df_merge)
summary(restaunova)

library(effectsize)
options(es.use_symbols = TRUE)
eta_squared(restaunova, partial = FALSE)
