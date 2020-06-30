library(shiny)
library(promises)
library(future)
library(DBI)

plan(multiprocess)

shinyApp(
  ui = fluidPage(
    textOutput("time"),
    actionButton("btn", "Long query!"),
    textOutput("query_status"),
    sliderInput("cyls", "Cylinders", min = 1, max = 8, value = 4, step = 1),
    plotOutput("plt")
  ),
  
  server = function(input, output, session) {
    
    conn <- function(args) {
      if (!exists(".con")){
        message(".con does not exist. Creating .con")
        .con <<- do.call(DBI::dbConnect, eval(dbargs))
      } else {
        message(".con already exists.")
      }
      return(.con)
    }
    dbargs <- substitute(list(drv = RSQLite::SQLite(), "tmp.sqlite"))

    output$time <- renderText({
      invalidateLater(1000)
      paste0("Time: ", format(Sys.time()))
    })
    
    query_result <- eventReactive(input$btn, {
      future({
        x <- system.time({
          DBI::dbGetQuery(conn(dbargs),
                          "WITH RECURSIVE r(i) AS (
                          VALUES(0)
                          UNION ALL
                          SELECT i FROM r
                          LIMIT 10000000
                        )
                        SELECT i FROM r WHERE i = 1;")
        })
        
        x[["elapsed"]]
      })
      
    })
    
    output$query_status <- renderText({
      query_result() %...>%
        (function(result) {
          paste0("[", Sys.time(), "] Query completed in ", result, " seconds")
        })
    })
    
    output$plt <- renderPlot({
      plot(mpg ~ disp, data = mtcars[mtcars$cyl >= input$cyls,,drop = FALSE],
           pch = 16, cex = 2, col = cyl)
    })
  }
)
