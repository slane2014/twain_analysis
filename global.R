# Original: http://shiny.rstudio.com/gallery/word-cloud.html

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

# Using "memoise" to automatically cache the results
getTermMatrix <- memoise(function(book) {
    # Careful not to let just any name slip in here; a
    # malicious user could manipulate this value.
    if (!(book %in% books))
        stop("Unknown book")
    
    text <- readLines(sprintf("./%s.txt.gz", book),
                      encoding="UTF-8")
    
    myCorpus = Corpus(VectorSource(text))
    myCorpus = tm_map(myCorpus, content_transformer(tolower))
    myCorpus = tm_map(myCorpus, removePunctuation)
    myCorpus = tm_map(myCorpus, removeNumbers)
    myCorpus = tm_map(myCorpus, removeWords,
         c(stopwords("SMART"), "thy", "thou", "thee", "the", "and", "but"))
    
    myDTM = TermDocumentMatrix(myCorpus,
                               control = list(minWordLength = 1))
    m = as.matrix(myDTM)
    top <- sort(rowSums(m), decreasing = TRUE)
#    cat("global top = ", head(top), "\n")
    top
})