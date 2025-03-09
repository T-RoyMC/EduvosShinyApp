library(shiny)
library(shinydashboard)
library(bs4Dash)
library(plotly)
library(DT)

ui <- dashboardPage(
  help = NULL,
  dashboardHeader(
    title = dashboardBrand(
      title = "Eduvos Graduates",
      image = "https://x2ycareerguidance.co.za/wp-content/uploads/2022/03/Eduvos-Logo_2-1.png"
    ),
    
    rightUi = tagList(  # Moves dropdowns to the right
      dropdownMenu(type = "message",
                   messageItem(from = "Eduvos", message = "Dataset Update", icon = icon("arrows-rotate"), time = "a min ago"),
                   messageItem(from = "Sipho Tshabala", message = "Keep up the good work", time = "55 mins ago"),
                   messageItem(from = "Sipho Tshabala", message = "R Project due 14 March 2025", icon = icon("bell"), time = "23-02-2025")),
      
      dropdownMenu(type = "notification",
                   notificationItem(
                     text = "Changes made to Graduates Surv...",
                     icon = icon("warning"),
                     status = "warning")),
      
      dropdownMenu(type = "tasks",
                   taskItem(value = 99, color = "lime", "Data Cleaning"),
                   taskItem(value = 80, color = "warning", "Visualization"),
                   taskItem(value = 50, color = "danger", "Shiny Dashboard"))
    )
  ),
  
  dashboardSidebar(
    sidebarMenu(
      sidebarSearchForm("searchText", "buttonSearch", "Search"),
      menuItem("Dashboard", tabName = "Dashboard", icon = icon("dashboard")),
      menuItem("Detailed Analysis", icon = icon("folder"),
               menuSubItem("Programming Languages", icon = icon("language"), tabName = "Programming_Languages"),
               menuSubItem("Databases", icon = icon("database"), tabName = "Databases"),
               menuSubItem("Web Frameworks", icon = icon("microchip"), tabName = "Web_Frameworks"),
               menuSubItem("Platforms", icon = icon("layer-group"), tabName = "Platforms"),
               menuSubItem("AI Search Tools", icon = icon("laptop-code"), tabName = "AI_Search_Tools"),
               menuSubItem("AI Tools", icon = icon("bug"), tabName = "AI_Tools")
              ),
      menuItem("Popular Industries", icon = icon("industry"), tabName = "top_industries", badgeLabel = "New", badgeColor = "success"),
      menuItem("Top Job Roles", icon = icon("users"), tabName = "top_roles", badgeLabel = "New", badgeColor = "success"),
      menuItem("Employment Rate", icon = icon("person-walking-luggage"), tabName = "employment_rate_df", badgeLabel = "New", badgeColor = "success")
      
    )),
  
  dashboardBody(
    tabItems(
      tabItem(tabName = "Dashboard",
              jumbotron(
                title = "Welcome to the Eduvos Graduates Dashboard",
                status = "info",
                lead = "Cleaning and Visualising Graduates Survey Results from Eduvos",
                btnName = "Download",
                href = "https://mylms.vossie.net/pluginfile.php/1329141/mod_folder/content/0/graduate_survey.csv?forcedownload=1",
                "Data is available to download"),

              fluidRow(
                infoBox("StudyFields", 3, icon = icon("school")),
                infoBoxOutput("TotalGraduates"),
                infoBoxOutput("EmployedGraduates")
              ),
              fluidRow(box(title = "Task", "You've been hired by Eduvos to analyse survey data to understand the tech tools their past students from the IT faculty are
currently using. The goal is to identify the most popular programming languages, web frameworks, databases, and other
tools graduates are working with. This information will help Eduvos update their IT courses to ensure they are teaching skills
that are relevant in the industry.", solidHeader = TRUE, status = "primary"),
                       box(title = "Focus", solidHeader = TRUE, status = "primary", uiOutput("column_list"))      
              )),
      
      tabItem(tabName = "Programming_Languages", fluidRow(
        box(title = "Top Progamming Langauages", plotlyOutput("top_prog_langs", height = "750px"), width = 12, solidHeader = TRUE, status = "primary")
        )),
      
      tabItem(tabName = "Databases", fluidRow(
        box(title = "Top Databases", plotlyOutput("top_databases", height = "750px"), width = 12, solidHeader = TRUE, status = "primary")
      )),
      
      tabItem(tabName = "Web_Frameworks", fluidRow(
        box(title = "Top Web Frameworks",plotlyOutput("top_webframeworks", height = "750px"), width = 12, solidHeader = TRUE, status = "primary")
      )),
      
      tabItem(tabName = "Platforms", fluidRow(
        box(title = "Top Platforms", plotlyOutput("top_platforms", height = "750px"), width = 12, solidHeader = TRUE, status = "primary")
      )),
      
      tabItem(tabName = "AI_Search_Tools", fluidRow(
        box(title = "Top AI Search Tools", plotlyOutput("top_aiSearch", height = "750px"), width = 12, solidHeader = TRUE, status = "primary")
      )),
      
      tabItem(tabName = "AI_Tools", fluidRow(
        box(title = "Top AI Tools", plotlyOutput("top_aiTools", height = "750px"), width = 12, solidHeader = TRUE, status = "primary")
      )),
      
      tabItem(tabName = "top_industries", fluidRow(
        box(title = "Top Industies", plotlyOutput("top_industries", height = "750px"), width = 12, solidHeader = TRUE, status = "primary")
      )),
      
      tabItem(tabName = "top_roles", fluidRow(
        box(title = "Top Job Roles", plotlyOutput("top_roles", height = "750px"), width = 12, solidHeader = TRUE, status = "primary")
      )),
      
      tabItem(tabName = "employment_rate_df", fluidRow(
        box(title = "Employment Rate", plotlyOutput("employment_rate_df", height = "750px"), width = 12, solidHeader = TRUE, status = "primary")
      ))

    )
  ),
  footer = dashboardFooter(
    left = NULL,
    right = "Created by T-Roy MacGoodman Chipangura"
  )
)