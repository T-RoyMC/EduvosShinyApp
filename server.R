library(shiny)
library(shinydashboard)
library(bs4Dash)
library(plotly)

# Define server logic
shinyServer(function(input, output) {
  

  # Render the interactive plotly chart
  output$top_prog_langs <- renderPlotly({
    interactive_prog_lan })
  
  # Render the interactive plotly chart
  output$top_databases <- renderPlotly({
    interactive_databas })

  # Render the interactive plotly chart
  output$top_platforms <- renderPlotly({
    interactive_platform  })  
  
  # Render the interactive plotly chart
  output$top_webframeworks <- renderPlotly({
    interactive_web_Frame  })

  
  # Render the interactive plotly chart
  output$top_aiSearch <- renderPlotly({
    interactive_ai_Search })
  
  # Render the interactive plotly chart
  output$top_aiTools <- renderPlotly({
    interactive_ai_Tools  })
  
  # Render the interactive plotly chart
  output$top_industries <- renderPlotly({
    interactive_Industry_S_Field  })
  
  # Render the interactive plotly chart
  output$top_roles <- renderPlotly({
    interactive_top_rol  })
  
  # Render the interactive plotly chart
  output$employment_rate_df <- renderPlotly({
    interactive_erp }) 
  

  output$TotalGraduates <- renderInfoBox({
    infoBox("Study Fields", length(employment_rate_df$StudyField), icon = icon("school"))
  })

    output$TotalGraduates <- renderInfoBox({
    infoBox("Total Graduates", sum(employment_rate_df$TotalGraduates), icon = icon("graduation-cap"))
  })
  
  output$EmployedGraduates <- renderInfoBox({
    infoBox("Employed Graduates", sum(employment_rate_df$EmployedGraduates), icon = icon("user-tie"))
  })
  
  output$column_list <- renderUI({
    column_names <- colnames(main_dataset)  # Get column names from the dataframe
    
    # Create a list of column names
    tags$ul(
      lapply(column_names, function(col) {
        tags$li(col)  # Each column name will be an item in the list
      })
    )
  })
  
})

