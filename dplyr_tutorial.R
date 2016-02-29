
#Sets the import option StringsAsFactors = FALSE for all the future imports in this session
options(stringsAsFactors = FALSE)

#Importing the bnames dataset into dataframe 'data'
data <- read.csv('C:/Users/parvash/Documents/R_programming_Work_directory/bnames.csv', stringsAsFactors = FALSE)
head(data)
tail(data)

#gives the distinct names list in the column 'name' of the dataframe 'data'
AllNames <- unique(data$name)
AllNames
#Sorts all the distinct names in ascending order(default)
AllNames_Sorted <- (sort(AllNames))
AllNames_Sorted

#Use ggplot2 package for visualizations
require(ggplot2)

#extract all the rows which have 'Diya' in the 'name' column
Diya <- data[data$name=='Diya',]
head(Diya)

#plot a graph to visualize year vs. proportion of all the babies named 'Diya'
qplot(data=Diya, year, prop, geom='line')

#extract data and plot a graph to visualize year vs. proportion of all the babies named 'Hillary'
Hillary <- data[data$name=='Hillary',]
head(Hillary)
qplot(data=Hillary, year, prop, geom='line')



#Grammer of data manipulation: dplyr package
require(dplyr)
#Five main functions of the dplyr package
#filter
#select
#mutate
#summarize
#arrange
  
#creat an example dataframe 'tbl' to illustrate dplyr functions
tbl <- data.frame(color = c("blue","White","blue",'White',"White"), 
                  values = c(1:5) )
tbl

#Filter all the rows in the 'tbl' which have value 'blue' in the column color
filter(tbl, color=="blue")

#Filter all the rows in the 'tbl' which have values 1 and 4 in the column values
filter(tbl, values %in% c(1,4))

#Filter all the rows in the 'data' with values 'female' in the sex column and 
#either in year 1990 or year 2000
#the filter function is equivalent to the 'where' clause in SQL
filter(data, sex=='female'& (year ==1990)|year == 2000)

#select function is used to extract specific columns from the dataframe
#columns 'name' and 'sex' are extrated from the 'data' dataset
select(data,name,sex)

#arrange function is the equivaent of the order by clause in SQL
#arrange all the data by the name column in ascending order
arrange(data,name)

#arrange all the data in the 'Hillary' dataset by name in descending order
head(arrange(Hillary, desc(prop)))

#mutate is used to add additional columns to the dataset
#column double is added to the 'tbl' dataset
mutate(tbl, double=values*2)

#Summarize functions are equivalent to the aggregate functions in SQL
#summarize function returns a single value for each function used unless there is a grouby function applied prior to the summarize function
#The min function returns the first row of the name column after arraging the names in ascending order
summarize(data,  min(name))

#prop_percentage column is added by multiplying the prop column with 100
mutate(data, prop_percentage = prop*100)

#Returns the min, max values in the name column and the max value of prop column
summarise(data, min(name), max(name),max(prop))


#Joining datasets
x <- data.frame(name=c("John","Paul","George","Ringo","Stuart","Pete"),
                instruments = c("guitar","bass","guitar","drums","bass","drums"))

y<- data.frame( name =c("John","Paul","George","Ringo","Brian"),
                band = c("TRUE","TRUE","TRUE","TRUE","FALSE"))

#there are four types of basic joins:
#left_join / right_join
#inner_join
#semi_join
#anti_join

#includes all the rows on the left table x, and matching rows from table y
left_join(x, y, by="name")

#includes all the rows on the right table y, and matching rows from table x
right_join(x,y,by ='name')

#includes rows of x that appear in y, and matching rows in y
inner_join(x,y, by = "name")

#includes rows of x that appear in Y
semi_join(x,y, by="name")

#includes rows of x that do not appear in y
anti_join(x,y,by="name")

#import the births data from the csv file
births <- read.csv('C:/Users/parvash/Documents/R_programming_Work_directory/births.csv', stringsAsFactors = FALSE)
head(births)
tail(births)

#join the 'data' and 'births' datasets on the year and sex columns, that is common in both the tables
babynames <- left_join(data, births, by = c("year", "sex"))
head(babynames)

babynames_w_pop <-mutate(babynames, total_number_of_babies = round(prop*births))
head(babynames_w_pop)
tail(babynames_w_pop)
  

summarize(babynames_w_pop, sum(total_number_of_babies))

qplot(data = babynames_w_pop, year,total_number_of_babies,na.rm =TRUE, geom = "line" )

#grouping data
Hillary <- filter(babynames_w_pop, name =="Hillary")
head(Hillary)

summarize(Hillary, total = sum(total_number_of_babies))

g <- group_by(babynames_w_pop, name)
names_totals <- summarize(g,total = sum(total_number_of_babies))
qplot(data=head(names_totals), name, total)

#ungroups the dataset
ungroup(names_totals)
  head(names_totals)

group2 <- group_by(babynames_w_pop, name, sex)
names_totals2 <- summarize(group2, total = sum(total_number_of_babies))
head(names_totals2)

summarize(group2, distinct_names = sum(n_distinct(name)))

#summary functions:
# min(x), median(x), max(x)
# n(x),

by_soundex <- group_by(babynames_w_pop, soundex)
stotals <- summarize(by_soundex, total = sum(total_number_of_babies))
arrange(stotals, desc(total))
j500 <- filter(babynames_w_pop, soundex=='J500')
unique(j500$name)

by_total_boys_girls <- group_by(babynames_w_pop,name ,year, sex)
year_sex_totals <- summarize(by_total_boys_girls, total = sum(total_number_of_babies))
head(year_sex_totals)
qplot(year, total, data =year_sex_totals, geom = 'line', color = sex )

by_total_boys_girls <- group_by(babynames_w_pop,year, sex)
rank_babies <- mutate(by_total_boys_girls, rank = rank(desc(prop)))
head(rank_babies)
Hillary <- filter(rank_babies, name =="Hillary")
qplot(year, -rank, data=Hillary, geom ="line")
ones <- filter(rank_babies, rank==1)
ones <- select(ones, year, name, sex)
ones


# reshape the data
library(reshape2)
dcast(ones, year ~ sex, value=name)

