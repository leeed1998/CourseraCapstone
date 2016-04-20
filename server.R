##Loading the libraries
library(shiny)
library(stringr)

#Loading the dataframe for the models
load("Gram1one.Rda",.GlobalEnv)
load("Gram2two.Rda",.GlobalEnv)
load("Gram3three.Rda",.GlobalEnv)
load("Gram4four.Rda",.GlobalEnv)
# load("Gram5five.Rda",.GlobalEnv) - takes too long and rarly used


# Make sure the text input is proper the sentence
scrubbedInput<-function(appInput)
{
  appInput <- tolower(appInput)
  appInput <- str_replace_all(appInput, "[^[a-z ]]", "")
  appInput <- gsub(" {2,}", " ", appInput)
  appInput <- gsub("'|,", "", appInput)
  return(appInput)
}

oneGram<-function(appInput)
{
  appInput <- tolower(appInput)
  appInput <- str_replace_all(appInput, "[^[a-z ]]", "")
  appInput <- gsub(" {2,}", " ", appInput)
  appInput <- unlist(strsplit(appInput, split=" "))
  appInputLength <- length(appInput)
  
  gram1 <- appInput[(appInputLength)]
  nextWords1 <- Gram1Mod$X2[which(gram1 == Gram1Mod[, 1])];
  nextWords1 <- head(nextWords1, 10)
  
  if (length(nextWords1 > 0)){
    return(nextWords1)    
  } else { return ("No Match")}
}

twoGram<-function(appInput)
{
  appInput <- tolower(appInput)
  appInput <- str_replace_all(appInput, "[^[a-z ]]", "")
  appInput <- gsub(" {2,}", " ", appInput)
  appInput <- unlist(strsplit(appInput, split=" "))
  appInputLength <- length(appInput)
  
  gram2 <- paste(appInput[(appInputLength-1):appInputLength], collapse=" ");
  nextWords2 <- Gram2Mod$X3[which(gram2 == Gram2Mod[, 4])];
  nextWords2 <- head(nextWords2, 10)
  
  if (length(nextWords2 > 0)){
    return(nextWords2)    
  } else { return ("No Match")}
}

threeGram<-function(appInput)
{
  appInput <- tolower(appInput)
  appInput <- str_replace_all(appInput, "[^[a-z ]]", "")
  appInput <- gsub(" {2,}", " ", appInput)
  appInput <- unlist(strsplit(appInput, split=" "))
  appInputLength <- length(appInput)
  gram3<-"XXX"
  if (appInputLength >= 3){
    gram3 <- paste(appInput[(appInputLength-2):appInputLength], collapse=" ")}
  nextWords3 <- Gram3Mod$X4[which(gram3 == Gram3Mod[, 5])]
  nextWords3 <- head(nextWords3, 10)
  
  if (length(nextWords3 > 0)){
    return(nextWords3)    
  } else { return ("No Match")}
}

fourGram<-function(appInput)
{
  appInput <- tolower(appInput)
  appInput <- str_replace_all(appInput, "[^[a-z ]]", "")
  appInput <- gsub(" {2,}", " ", appInput)
  appInput <- unlist(strsplit(appInput, split=" "))
  appInputLength <- length(appInput)
  gram4<-"XXX"
  if (appInputLength >= 4){
    gram4 <- paste(appInput[(appInputLength-3):appInputLength], collapse=" ")}
  nextWords4 <- Gram4Mod$X5[which(gram4 == Gram4Mod[, 6])];
  nextWords4 <- head(nextWords4, 10)
  
  if (length(nextWords4 > 0)){
    return(nextWords4)    
  } else { return ("No Match")}
}


bestWord<-function(appInput)
{
  appInput <- tolower(appInput)
  appInput <- str_replace_all(appInput, "[^[a-z ]]", "")
  appInput <- gsub(" {2,}", " ", appInput)
  appInput <- unlist(strsplit(appInput, split=" "))
  appInputLength <- length(appInput)
  
  gram4 <- paste(appInput[(appInputLength-3):appInputLength], collapse=" ")
  nextWords4 <- Gram4Mod$X5[which(gram4 == Gram4Mod[, 6])]
  bestword1 <- nextWords4[1]
  
  if (is.na(bestword1)) { 
    gram3 <- paste(appInput[(appInputLength-2):appInputLength], collapse=" ")
    nextWords3 <- Gram3Mod$X4[which(gram3 == Gram3Mod[, 5])]
    bestword1 <- nextWords3[1]
  }  
  
  if (is.na(bestword1)) {
    gram2 <- paste(appInput[(appInputLength-1):appInputLength], collapse=" ")
    nextWords2 <- Gram2Mod$X3[which(gram2 == Gram2Mod[, 4])];
    bestword1 <- nextWords2[1]
  }
  
  if (is.na(bestword1)) {
    gram1 <- appInput[(appInputLength)]
    nextWords1 <- Gram1Mod$X2[which(gram1 == Gram1Mod[, 1])];
    bestword1 <- nextWords1[1]
  } 
  
  return(bestword1)
 
}

##############################################################

shinyServer(function(input,output){

  output$value     <- renderText({scrubbedInput(input$text)})
  output$best      <- renderText({bestWord(input$text)})
  output$onegram   <- renderText({oneGram(input$text)})
  output$twogram   <- renderText({twoGram(input$text)})
  output$threegram <- renderText({threeGram(input$text)})
  output$fourgram  <- renderText({fourGram(input$text)})
}
)