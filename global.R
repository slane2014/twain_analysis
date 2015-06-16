library(tm)
library(wordcloud)
library(memoise)

books <<- list("A Connecticut Yankee" = "yankee",
                "Huckleberry Finn" = "huck",
                "Innocents Abroad" = "innocent",
                 "Life on the Mississippi" = "mississippi",
                "Prince and the Pauper" = "prince",
                "Roughing It" = "rough",
                "Tom Sawyer" = "tom"
                )

# Read the text from the saved files
getTermMatrix <- memoise(function(book) {
    if (!(book %in% books))
        stop("Unknown book")
    
    text <- readLines(sprintf("./%s.txt.gz", book), encoding="UTF-8")
    
    myCorpus = Corpus(VectorSource(text))
    myCorpus = tm_map(myCorpus, content_transformer(tolower))
    myCorpus = tm_map(myCorpus, removePunctuation)
    myCorpus = tm_map(myCorpus, removeNumbers)
    myCorpus = tm_map(myCorpus, removeWords,
         c(stopwords("SMART"), "the", "and", "but"))
    
    myDTM = TermDocumentMatrix(myCorpus,
                control = list(minWordLength = 1))
    
    m = as.matrix(myDTM)
    top <- sort(rowSums(m), decreasing = TRUE)
})