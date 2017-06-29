# this tutorial includes some basic functions of tm library
library(tm)
library(wordcloud)

#create some sample data
sample <- read.delim("trump_debate.txt")
#sample <- read.delim("clinton_debate.txt")

corp <- Corpus(VectorSource(sample)) #directory source other method
dtm <- DocumentTermMatrix(corp)
tdm <- TermDocumentMatrix(corp)
inspect(dtm)
wordcloud(corp, min.freq=25, color=brewer.pal(6, "Dark2") )

#Text processing
corp <- tm_map(corp, removePunctuation)
corp <- tm_map(corp, removeNumbers)
corp <- tm_map(corp, removeWords, stopwords("english"))
corp <- tm_map(corp, stripWhitespace)

library(SnowballC)
corp <- tm_map(corp, stemDocument)
corp <- tm_map(corp, content_transformer(tolower))
#corp <- tm_map(corp, PlainTextDocument) #avoid tm 0.6 issue

#remove your OWN stopwords
myStopwords <- c("that", "know", "but", "and", "can", "you","so", "got","let","his","got","say",
                 "said","see","far","much", "will", "new", "lot", "put", "also", "get", "it", "hes", 
                 "dont", "well" )
myCorpus <- tm_map(corp, removeWords, myStopwords)
wordcloud(myCorpus, colors=brewer.pal(5,"Set1"),random.order=FALSE, max.words=50)

#plot word relations
sample = c("Oh, I absolutely love Roger, even he lost to Djokovic in
                  IndianWells Yesterday.",
                  "Tennis! It must be love!",
                  "USOpen tickets cost about 100 per ticket.",
                  "I love tennis I can not lie! ")

corp <- Corpus(VectorSource(sample)) #directory source other method
dtm <- DocumentTermMatrix(corp)
tdm<-TermDocumentMatrix(corp)

library(igraph)
tdm = as.matrix(tdm)
termMatrix <- tdm %*% t(tdm)
g <- graph.adjacency(termMatrix, weighted=T, mode = "undirected")
plot(g)


