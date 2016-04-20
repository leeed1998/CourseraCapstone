### Shiny UI portion #####
### 4/13/2016

# install.packages("shinythemes")
library(shinythemes)

shinyUI(fluidPage(
  
  # Theme setting
  theme = shinytheme("Readable"),
  
  # Title
  titlePanel(h1("Welcome to Zotar,Predictor of Next Words", align="center"),
  windowTitle = "Coursea Swiftkey Capstone Project"),
  
  h4('Similar to what we are used to with our phones and tablets, this app will try to predict the next word you are likely to enter', align="center"),
  h4('The prediction algorithm is based upon Swiftkey sample web, news and blog files', align="center"),
  h4('Wait for a little bit for the dictionaries to load', align="center"),
  
  helpText(HTML("<a href = \"https://github.com/leeed1998/CourseraCapstone/blob/master/CapstoneDetails.md</a>"), align="center"),
  helpText(HTML("<a href = \"https://github.com/leeed1998/CourseraCapstone/blob/master/Zotar.md\">Why Zotar?</a>"), align="center"),
  hr(),
  
  textInput("text", label = h3("Insert Word() Here"),  value = ""),
  submitButton('Start Checking for the next word'),
  hr(),
  
  fluidRow(column(4, offset = 0, h3("Zotar thinks this is the next word is ..."),verbatimTextOutput("best"))),
  
  hr(),
  h3("Results of Prediction"),
  h4("Based on the data enetered, 1 gram predicted the next word(s) as:"),
  verbatimTextOutput("onegram"),
  h4("Based on the data enetered, 2 gram predicted the next word(s) as:"),
  verbatimTextOutput("twogram"),
  h4("Based on the data enetered, 3 gram predicted the next word(s) as:"),
  verbatimTextOutput("threegram"),
  h4("Based on the data enetered, 4 gram predicted the next word(s) as:"),
  verbatimTextOutput("fourgram")
  
)
)
