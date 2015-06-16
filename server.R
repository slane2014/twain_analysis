function(input, output, session) {
    # Define a reactive expression for the document term matrix
    terms <- reactive({
        # Change when the "select" button is pressed...
        input$update
        isolate({
            withProgress({
                setProgress(message = "Processing corpus...")
                getTermMatrix(input$selection)
            })
        })
    })
    
    # Make the wordcloud of the novel text
    wordcloud_rep <- repeatable(wordcloud)
    
    output$plot <- renderPlot({
        v <- terms()
        wordcloud_rep(names(v), v, scale=c(4,0.5),
                      min.freq=input$freq, max.words=input$max,
                      colors=brewer.pal(8, "Dark2"))
     })
    
    # Make a histogram of the novel text
    output$histogram <- renderPlot({
        v <- terms()
        barplot(head(v, n=input$max))
    })
}