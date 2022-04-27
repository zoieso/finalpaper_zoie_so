#### Preamble ####
# Purpose: Gather data from Statistics Canada
# Author: Zoie So
# Data: 4 April 2022
# Contact: zoie.so@utoronto.ca 
# License: MIT
# Pre-requisites: 
# - None

#install.packages("tidyverse")
#install.packages("cansim")
#remotes::install_github("mountainmath/cansim")
#install.packages("janitor")

library(tidyverse)
library(cansim)
library(janitor)

#### Gather data ####
# Based on: https://open.canada.ca/data/en/dataset/9867db5f-476f-4033-9cb2-f39e5b4cd44c 
# Get the dataset
rawdata <- get_cansim("37-10-0020")

#### Clean data ####
# Clean names
cleaned_rawdata <- clean_names(rawdata)

# Just keep some variables of interest 
keeps_rawdata <- cleaned_rawdata[c("ref_date", "geo", "uom", "value", "institution_type", "international_standard_classification_of_education_isced", "field_of_study", "gender", "status_of_student_in_canada")]

keeps_rawdata <-
  keeps_rawdata|>
  filter(status_of_student_in_canada %in% c("International students","Canadian students"))|>
  filter(uom == "Number", gender == "Total, gender")|>
  filter(ref_date >= 2009)

keeps_rawdata <-
  keeps_rawdata|>
  select(ref_date, value, geo, institution_type, international_standard_classification_of_education_isced, field_of_study, status_of_student_in_canada) 

keeps_rawdata <-
  keeps_rawdata|>
  rename(education_level = international_standard_classification_of_education_isced, citizen = status_of_student_in_canada)

#### Save ####
write.csv(keeps_rawdata,"C:\\Users\\User\\Desktop\\starter_folder-main\\starter_folder-main\\inputs\\data\\keeps_students_data.csv", row.names = FALSE)



         
