# app.R

library(shiny)
library(dplyr)

# Sample Data
data <- tibble(
  id = 1:10,
  category = sample(c("A", "B", "C"), 10, replace = TRUE),
  value1 = rnorm(10, mean = 50, sd = 10),
  value2 = sample(100:200, 10, replace = TRUE)
)

ui <- fluidPage(
  titlePanel("dplyr Demo in Shiny"),
  
  sidebarLayout(
    sidebarPanel(
      h4("Filter Data"),
      selectInput("select_category", "Select Category:", choices = c("All", unique(data$category))),
      sliderInput("filter_value1", "Filter by Value 1:",
                  min = floor(min(data$value1)),
                  max = ceiling(max(data$value1)),
                  value = c(floor(min(data$value1)), ceiling(max(data$value1)))
      ),
      h4("Summarize Data"),
      actionButton("summarize_btn", "Summarize by Category")
    ),
    
    mainPanel(
      tabsetPanel(
        tabPanel("Original Data",
                 h3("Original Sample Data"),
                 tableOutput("original_data")
        ),
        tabPanel("Filtered Data (select & filter)",
                 h3("Filtered Data (showing id, category, value1)"),
                 tableOutput("filtered_data")
        ),
        tabPanel("Summary Data (group_by & summarize)",
                 h3("Summary of Value 1 by Category"),
                 tableOutput("summary_data")
        )
      )
    )
  )
)

server <- function(input, output) {
  
  output$original_data <- renderTable({
    data
  })
  
  filtered_df <- reactive({
    df_filtered <- data
    
    # Filter by category
    if (input$select_category != "All") {
      df_filtered <- df_filtered %>%
        filter(category == input$select_category)
    }
    
    # Filter by value1 range
    df_filtered <- df_filtered %>%
      filter(value1 >= input$filter_value1[1] & value1 <= input$filter_value1[2])
    
    # Select specific columns for display
    df_filtered %>%
      select(id, category, value1) %>%
      arrange(id)
  })
  
  output$filtered_data <- renderTable({
    filtered_df()
  })
  
  summary_df <- eventReactive(input$summarize_btn, {
    data %>%
      group_by(category) %>%
      summarize(
        mean_value1 = mean(value1),
        median_value2 = median(value2),
        count = n()
      ) %>%
      arrange(category)
  })
  
  output$summary_data <- renderTable({
    summary_df()
  })
  
}

shinyApp(ui = ui, server = server)