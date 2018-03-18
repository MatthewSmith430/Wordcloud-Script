##########Load Packages######################
library(tm)
library(magrittr)
#library(devtools)
#devtools::install_github("lchiffon/wordcloud2")
library(wordcloud2)

#####Load text document as .txt file, first listing the file 
#####location in the following form
text1<-"C:\\Users\\example.txt"

text2 <-readLines(text1)
DOCtxt<-Corpus(VectorSource(text2))

##########Clean the document - remove whitespace, numbers & punctuation
##########Convert letters to lower case.
##########Remove common english words
##########Remove a list of specifc word (as defined by the user)

##########See example below
DOCtxt_data<-tm_map(DOCtxt,stripWhitespace)%>%tm_map(.,tolower)%>%
  tm_map(.,removeNumbers)%>%tm_map(.,removePunctuation)%>%
  tm_map(.,removeWords,stopwords("english"))%>%
  tm_map(.,removeWords,c("and","the","our","that","table","figure",
                       "for","are","also","more","has",
                       "must","have","should","this"))

###Create object to plot as a word cloud
dtm<- TermDocumentMatrix(DOCtxt_data)%>%as.matrix()
v <- sort(rowSums(dtm),decreasing=TRUE)
d <- data.frame(word = names(v),freq=v)

###Create word cloud
wordcloud2(d)

###Create wordcloud using a word
letterCloud( d, word = "EXAMPLE", color='random-light' , backgroundColor="black")
