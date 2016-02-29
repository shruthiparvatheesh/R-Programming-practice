###Tutorial on use of Web graphics in R

##  Demo of ggvis

#  Install and load ggvis library
install.packages("ggvis") 
require(ggvis)

#loading the dataset Cocaine from the ggvis librabry
data(cocaine)
head(cocaine)
?cocaine  # exploring the cocaine dataset

# Scatter Plots using ggvis

##Creating a plot in ggplot using the cocaine dataset just for comparision
require(ggplot2)

#creating a scatterplot with weight on the x-axis and price on the y-axis using the cocaine dataset
ggplot(cocaine, aes(x=weight,y=price)) + geom_point()

#creating a plot using ggvis
#Here we make use of the '%>%' - pipes and we don't need to use the 'aes' function to specify the mappings of columns
#The resultant graph comes up in the 'Viewer' pane

#fill - color of the dot in a scatterplot
cocaine %>% ggvis(x=~weight, y=~price, fill =~potency) %>% layer_points()

#stroke - color of the outline of the dots in a scatterplot 
cocaine %>% ggvis(x=~weight, y=~price, stroke =~potency) %>% layer_points()

#When assigning a value to an aesthetic we use ':=' instead of '~='
cocaine %>% ggvis(x=~weight, y=~price, fill:="green") %>% layer_points()

cocaine %>% ggvis(x=~weight, y=~price, fill:="green") %>% layer_points() %>% layer_smooths()

#Adding a slider to adjust the size and opacity of the scatter plot
Cocaine %>% ggvis(~weight, ~price, fill =~potency, size := input_slider(10,100), 
                   opacity := input_slider(0,1)) %>% layer_points()

#Histograms using ggvis

##Creating a histogram in ggplot using the cocaine dataset just for comparision
ggplot(cocaine, aes(x=price))+ geom_histogram()

##creating a histogram using ggvis
cocaine %>% ggvis(x=~price) %>% layer_histograms()


##Demo of rCharts
#rCharts needs to be downloaded using 'devtools' as it is not yet a standard package that is available in CRAN
#The link to rCharts - http://ramnathv.github.io/rCharts/
install.packages('devtools')
require(devtools)
install_github('rCharts', 'ramnathv')

require(rCharts)
#using Iris dataset
head(iris)
#Removing the '.' in all the variable names of the iris dataset
#e.g. Sepal.Length will now be SepalLength
names(iris) <- gsub("\\.","",names(iris))
head(iris)

#scatter plot of SepalLength Vs. SepalWidth facetted by Species
rPlot(SepalLength ~ SepalWidth | Species, color ="Species", type ="point", data = iris)

#Barchart using the 'HairEyeColor' dataset
#converting the dataset to the dataframe datatype
hairEye <- as.data.frame(HairEyeColor)
head(hairEye)
rPlot(Freq ~ Hair | Eye, color = "Eye", type = "bar", data= hairEye)

#using the 'economics' dataset
data(economics, package="ggplot2")

#The data ranges from year 1967 to 2007
head(economics)
tail(economics)

#converting the date field to a character datatype
economics$date <- as.character(economics$date)
class(economics$date)

#using MorrisJS plot
m1<- mPlot(x="date", y= c("psavert", "uempmed"), type= "Line", data = economics)
m1$set(pointsize = 0, linewidth =1)
m1

#maps using rCharts
#map of London
map1 <- Leaflet$new()
map1$setView(c(51.505, -.09), zoom = 13)
map1

#map of Natick
map2 <- Leaflet$new()
map2$setView(c(42.2833, -71.3500), zoom = 13)
map2

#making an interactive graph 
#Install rjson package to be able to read JSON code
install.packages("rjson")
require(rjson)
#installing the plyr package to manipulate the data
require(plyr)

#reading the data from Jared Lander's website - 
pizzaJson <- fromJSON(file="http://www.jaredlander.com/data/PizzaPollData.php")
pizzaJson

#formatting the JSON data as a dataframe
pizza <- ldply(pizzaJson, as.data.frame)
head(pizza)

pizzaPlot <- nPlot(Percent ~ Place, data = pizza, type = "multiBarChart", group = "Answer")
pizzaPlot$xAxis(axisLabel = "Pizza Place", rotateLabels = -45)
pizzaPlot$yAxis(axisLabel = "Percent")
pizzaPlot$chart(reduceXTicks = FALSE)
pizzaPlot
