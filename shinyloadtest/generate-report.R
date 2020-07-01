library(shinyloadtest)

df <- load_runs("sync" = here::here("shinyloadtest", "runs", "sync"),
                "sync scaled" = here::here("shinyloadtest", "runs", "sync-scaled"),
                "async" = here::here("shinyloadtest", "runs", "async"),
                "async2" = here::here("shinyloadtest", "runs", "async2"))

shinyloadtest_report(df, output = here::here("shinyloadtest", "report.html"))
