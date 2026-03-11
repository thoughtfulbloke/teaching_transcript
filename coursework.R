# you can run lines by having the cursor clicked in the line and pressing
# the run button above or by having the cursor clicked in the line and pressing
# command+return (Mac) or control + enter (Windows). Either way you do not need 
# to have the entire line selected
# these are comments ignored by R

pulse <- read.csv("pulse.csv")
summary(pulse)
str(pulse)

# making changes to the way the data is read in

# changing a kind of column after the fact

# some basic plots
plot(pulse$weight, pulse$height)
hist(pulse$weight)
boxplot(pulse$height ~ pulse$gender)

# for using helper libraries, you have to have the helper library installed
# which is a one-off action.
# Once helper libraries are installed you activate them for the script by using
# the library() command

library(ggplot2)

# then you can use commands from that library

ggplot(pulse, aes(x=height, y=weight, colour=gender, shape=did.swim)) + geom_point()

# creating calculate columns

pulse$mid <- pulse$before + pulse$after / 2

# picking groups out
# could use row numbers (ranges are inclusive)
hist(pulse$weight[12:30])
# most people use rules
hist(pulse$weight[pulse$gender == "F"])

# because you can store lots of things while using R you can separate the criteria out
# and reuse it again and again

criteria <- pulse$gender == "F"
hist(pulse$weight[criteria])

# and/or as & or | let you build more complex rules

# for handling blanks, as the blank is an unknown value, it needs a special function.

criteria <- is.na(pulse$after)
hist(pulse$weight[criteria])

# but if you want the not blank entries it needs reversing with the Not symbol !

criteria <- !is.na(pulse$after)
hist(pulse$weight[criteria])

# can also use subsetting for putting data into groups based on criteria

pulse$heightgroup <- "short"
pulse$heightgroup[pulse$height > 155] <- "medium"
pulse$heightgroup[pulse$height > 170] <- "tall"
pulse$heightgroup[is.na(pulse$height)] <- NA

# and used for correcting individual entries

pulse$after[6] <- 88

# can make clean datasets by selecting rows and columns

# the c() function is helpful to combine individual items into a group


# dplyr example
library(dplyr)
pulse %>%
  filter(!is.na(after)) %>%
  mutate(pulsechange = after-before)
  group_by(gender, swam) %>%
  summarise(mean_change = mean(pulsechange),
            median_change = median(pulsechange),
            entry_count = n())

write.csv(pulse, file = "new.csv", row.names = FALSE)

