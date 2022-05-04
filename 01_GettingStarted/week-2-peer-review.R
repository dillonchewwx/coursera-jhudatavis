#Week 2 Practice Code

#### If you have not installed the tidyverse yet, run the line below. 
#install.packages("tidyverse")

library(tidyverse)

#####RUN THIS CODE WITHOUT MODIFICATION 
###This will import the survey data we have been working with in this course and drop data with missing rows from the data
dat <- drop_na(read_csv(url("https://www.dropbox.com/s/uhfstf6g36ghxwp/cces_sample_coursera.csv?raw=1")))

# Problem 1

# The object "dat" created in the assignment code will import the survey data for the assignment using read_csv, thereby creating a tibble. Using that object as your data, use select() to create a new tibble that include only the columns for educational level, whether the respondent has an educational loan, employment status, and Trump approval. Display that object. Hint: consult the codebook to identify the correct column names.

#### Write your code below:
new_dat<-dat %>% 
    select(educ, edloan, employ, CC18_308a)

# Problem 2

# Continuing to use the new data table you created in Problem 1, use recode() to create a new column named "trump_approve_disapprove" that recodes the column for President Trump's job approval. A value of "1" should mean that the respondent either "strongly" or "somewhat" approves of the President, and a value of 0 should mean that the respondent either "strongly" or "somewhat" DISapproves of the president. Display the resulting object. 

#### Write your code below:
new_dat<-new_dat %>%
    mutate(trump_approve_disapprove=recode(CC18_308a, `1`=1L, `2`=1L, `3`=0L, `4`=0L))
  
# Problem 3

# Use summarise() to create a summary table for survey respondents who are employed full time and are married. The table should have the mean and median for the importance of religion column.

#### Write your code below:
sum_dat<-dat %>%
    filter(employ==1 & marstat==1) %>%
    summarize(`Mean Importance of Religion`=round(mean(pew_religimp), 2),
              `Median Importance of Religion`=median(pew_religimp))
    

  

