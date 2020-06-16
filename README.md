# Shiny Asynchronous Database Queries

This repository contains 2 shiny applications that execute a simulated long
running query against a SQLite database. The [sync app](R/sync) runs the queries
synchronously (R's default behavior) and the [async app](R/async) runs queries
asynchronously.

Both applications were deployed to RStudio Connect. The synchronous app was
deployed twice: once with default run time parameters on RStudio Connect, and a
second time with max processes set to 20 and max connections per process set to
1 so that each session is run in it's on process.
[`shinyloadtest`](https://rstudio.github.io/shinyloadtest/) was used to run a 20
user, 20 minute load test against each of the three apps. The results of the
loadtest can be found [here](shinyloadtest/report.html).

Not surprisingly, the default RStudio Connect settings struggled to keep up with
the load. The scaled RStudio Connect settings did better, but the best
performing option was the asynchronous application.