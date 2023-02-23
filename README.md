# dirty_data_codeclan_project_KashaCepok

The project is divided into three sections, based on three datasets; Decathlon data, Halloween candy data, and right wing authoritarianism data. each data
set was cleaned and analysed. Their respective folders are divided into 4 sub - folders; raw data, clean data, the data cleaning script and the data analysis
and documentation notebook. 

### Section 1: Decathlon data

The data was taken from the results of 2 decathlons and the performance of the participants. The data was cleaned by first cleaning the column names and then
changing the row names into a column. The data in this column was changed to title case as they were names, and the columns of events were pivoted into 2 columns
of events and the participants result in the event. 

In the analysis we answered questions pertaining to the results of the participants in the decathlon, such as the average results in certain events, along with 
finding the results of specific athletes.

### Section 2: Halloween candy data

The data was taken from an online survey on whether participants would feel "joy","despair" or "meh" at getting certain items in their trick or treating bag at
halloween. It came in 3 different tables from 3 years (2015, 2016 and 2017). The data was cleaned by cleaning the column names of the individual tables and
ensuring they match, along with removing unneccessary data. The tables were then joined and some columns were aggregated for easier reading, and checked for
outlying values. Finally, more unneccessary columns were removed, and the types of candy columns were pivoted to create two columns, type of candy and rating. When aggregating the different inputs for "country" some of the inputs had to be assumed to be in reference to a certain country. It was also assumed a lot of items were joke questions and we would not actually expect anyone to give them out to trick or treaters at halloween, and were thus removed.

In the analysis we answered questions on the age demographic of participants, along with the popularity of different candies and their popularity within
different demographics.

### Section 3: Right wing Authoritarianism data

The data was taken from an online psychometric test on how much an individual identified with the right wing authoritarian ideology. The data was cleaned by
cleaning the column names, removing unneccessary columns, filtering for valid test results, and then replacing the data values with their text equivalents
to make the data easy to interpret. We assumed that anyone who had ticked questions vcl6, vcll9 and vcl2 were not answering truthfully and so were removed
from the data.

In the analysis we answered questions that compared the average rwa score for different demographics, along with looking at certain demographics in more depth.
