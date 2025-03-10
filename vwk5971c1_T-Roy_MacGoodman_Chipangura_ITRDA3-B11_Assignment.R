library(dplyr)
library(tidyverse)
library(stringr)
library(ggplot2)
library(ggthemes)
library(readr)
library(plotly)

#1
#a. 
#Load/Import dataset
data <- read_csv("graduate_survey.csv")

#select the relevant columns
main_dataset <- data |>  
  select(Campus, Branch, StudyField, Role, EduLevel, ProgLang, Databases, Platform, WebFramework,
         Industry, AISearch, AITool, Employment)

#b.
# Removing NULL values
main_dataset <- na.omit(main_dataset)

# c.
#Merge Umhlanga Campus into Durban Campus
main_dataset <- main_dataset |> 
  mutate(Campus = case_when(
    Campus %in% c("Durban Campus", "Umhlanga Campus") ~ "Durban Campus", TRUE ~ Campus))

# d. 
#Get top 5 campuses
top_campuses <- main_dataset |> 
  count(Campus, sort = TRUE) |>   
  slice_head(n = 5) |>         
  pull(Campus)
 
#Filtering the dataset to return to the top 5 campuses
subsetted_dataset <- main_dataset |> 
  filter(Campus %in% top_campuses)

#Question 2
#I.

#Splitting the ProgLang column responses into individual programming languages,
#converting them into a frequency table then into a dataframe, and arrange then in desc order by frequency
top_prog_langs <- subsetted_dataset |>
  pull(ProgLang) |>  
  strsplit(";") |>  
  unlist() |>  
  table() |>  
  as.data.frame() |>   
  arrange(desc(Freq)) 
print("Top Programming Languages:")
print(head(top_prog_langs))

#Plotting a bar plot for top programming languages
prog_lan <- ggplot(top_prog_langs, aes(x = Var1, y = Freq, fill = Var1, text = paste("Programming Language: ", Var1, "<br>Users: ", Freq))) + 
  geom_bar(stat = "identity", show.legend = FALSE) +
  labs(title = "Top Programming Languages",
       x = "Types of Programming Languages",
       y = "Number of Users") +
  coord_flip() 
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1), 
  plot.title = element_text(size = 18, hjust = 0.5))  

#Converting the grouped bar plot to an interactive plot with hovering tooltip and displaying it
interactive_prog_lan <- ggplotly(prog_lan, tooltip = "text") |> 
  layout(
    showlegend = FALSE,
    updatemenus = list(
      list(
        type = "buttons",
        buttons = list(
          list(
            label = "Show Legend",
            method = "relayout",
            args = list("showlegend", TRUE)
          ),
          list(
            label = "Hide Legend",
            method = "relayout",
            args = list("showlegend", FALSE)
          )
        )
      )
    )
  )
interactive_prog_lan

#Splitting the Databases column responses into individual programming languages,
#converting them into a frequency table then into a dataframe, and arrange then in desc order by frequency
top_databases <- subsetted_dataset |>
  pull(Databases) |>  
  strsplit(";") |>  
  unlist() |>  
  table() |>  
  as.data.frame() |>  
  arrange(desc(Freq))
print("Top Databases:")
print(head(top_databases))

#Plotting a bar plot for top Databases
databas <- ggplot(top_databases, aes(x = Var1, y = Freq, fill = Var1, text = paste("Database: ", Var1, "<br>Users: ", Freq))) + 
  geom_bar(stat = "identity", show.legend = FALSE) +
  labs(title = "Top Databases",
       x = "Types of Databases",
       y = "Number of Users") +
  coord_flip() +  
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1),
  plot.title = element_text(size = 18, hjust = 0.5))  

#Converting the grouped bar plot to an interactive plot with hovering tooltip and displaying it
interactive_databas <- ggplotly(databas, tooltip = "text") |>
  layout(
    showlegend = FALSE,  
    updatemenus = list(
      list(
        type = "buttons",
        buttons = list(
          list(
            label = "Show Legend",
            method = "relayout",
            args = list("showlegend", TRUE)
          ),
          list(
            label = "Hide Legend",
            method = "relayout",
            args = list("showlegend", FALSE)
          )
        )
      )
    )
  )
interactive_databas

#Splitting the Platform column responses into individual programming languages,
#converting them into a frequency table then into a dataframe, and arrange then in desc order by frequency
top_platforms <- subsetted_dataset |>
  pull(Platform) |>  
  strsplit(";") |>  
  unlist() |>  
  table() |>  
  as.data.frame() |>  
  arrange(desc(Freq))
print("Top Platforms:")
print(head(top_platforms))

# Plotting a bar plot for Top Platforms
platform <- ggplot(top_platforms, aes(x = Var1, y = Freq, fill = Var1, text = paste("Platform: ", Var1, "<br>Users: ", Freq))) + 
  geom_bar(stat = "identity", show.legend = FALSE) +
  labs(title = "Top Platforms",
       x = "Types of Platforms",
       y = "Number of Users") +
  coord_flip() + 
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1), 
  plot.title = element_text(size = 18, hjust = 0.5))  

#Converting the grouped bar plot to an interactive plot with hovering tooltip and displaying it
interactive_platform <- ggplotly(platform, tooltip = "text") |>  
  layout(
    showlegend = FALSE,  
    updatemenus = list(
      list(
        type = "buttons",
        buttons = list(
          list(
            label = "Show Legend",
            method = "relayout",
            args = list("showlegend", TRUE)
          ),
          list(
            label = "Hide Legend",
            method = "relayout",
            args = list("showlegend", FALSE)
          )
        )
      )
    )
  )
interactive_platform

#Splitting the WebFramework column responses into individual programming languages,
#converting them into a frequency table then into a dataframe, and arrange then in desc order by frequency
top_webframeworks <- subsetted_dataset |>
  pull(WebFramework) |>  
  strsplit(";") |>  
  unlist() |>  
  table() |>  
  as.data.frame() |>  
  arrange(desc(Freq))
print("Top Web Frameworks:")
print(head(top_webframeworks))

#Plotting a bar plot for Top Web Frameworks
web_Frame <- ggplot(top_webframeworks, aes(x = Var1, y = Freq, fill = Var1, text = paste("WebFramework: ", Var1, "<br>Users: ", Freq))) + 
  geom_bar(stat = "identity", show.legend = FALSE) +
  labs(title = "Top Web Frameworks",
       x = "Types of Web Frameworks",
       y = "Number of Users") +
  coord_flip() +  
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1),  # Rotate x-axis labels for readability
  plot.title = element_text(size = 18, hjust = 0.5))  # Center the plot title

#Converting the grouped bar plot to an interactive plot with hovering tooltip and displaying it
interactive_web_Frame <- ggplotly(web_Frame, tooltip = "text") |>
  layout(
    showlegend = FALSE,  
    updatemenus = list(
      list(
        type = "buttons",
        buttons = list(
          list(
            label = "Show Legend",
            method = "relayout",
            args = list("showlegend", TRUE)
          ),
          list(
            label = "Hide Legend",
            method = "relayout",
            args = list("showlegend", FALSE)
          )
        )
      )
    )
  )
interactive_web_Frame

#Splitting the AISearch column responses into individual programming languages,
#converting them into a frequency table then into a dataframe, and arrange then in desc order by frequency
top_aiSearch <- subsetted_dataset |>
  pull(AISearch) |>  
  strsplit(";") |>  
  unlist() |>  
  table() |>  
  as.data.frame() |>  
  arrange(desc(Freq))
print("Top AI Search Tools:")
print(head(top_aiSearch))

# Plotting a bar plot for Top AISearch
ai_Search <- ggplot(top_aiSearch, aes(x = Var1, y = Freq, fill = Var1, text = paste("AISearch: ", Var1, "<br>Users: ", Freq))) + 
  geom_bar(stat = "identity", show.legend = FALSE) +
  labs(title = "Top AI Search",
       x = "Types of AI Search",
       y = "Number of Users") +
  coord_flip() +  
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1),
  plot.title = element_text(size = 18, hjust = 0.5))  

#Converting the grouped bar plot to an interactive plot with hovering tooltip and displaying it
interactive_ai_Search <- ggplotly(ai_Search, tooltip = "text") |>
  layout(
    showlegend = FALSE,
    updatemenus = list(
      list(
        type = "buttons",
        buttons = list(
          list(
            label = "Show Legend",
            method = "relayout",
            args = list("showlegend", TRUE)
          ),
          list(
            label = "Hide Legend",
            method = "relayout",
            args = list("showlegend", FALSE)
          )
        )
      )
    )
  )
interactive_ai_Search

#Splitting the AITool column responses into individual programming languages,
#converting them into a frequency table then into a dataframe, and arrange then in desc order by frequency
top_aiTools <- subsetted_dataset |>
  pull(AITool) |>  
  strsplit(";") |>  
  unlist() |>  
  table() |>  
  as.data.frame() |>  
  arrange(desc(Freq))
print("Top AI Developer Tools:")
print(head(top_aiTools))

# Plotting the interactive bar plot for Top AITool
ai_Tools <- ggplot(top_aiTools, aes(x = Var1, y = Freq, fill = Var1, text = paste("AITool: ", Var1, "<br>Users: ", Freq))) + 
  geom_bar(stat = "identity", show.legend = FALSE) + 
  labs(title = "Top AI Tools", 
       x = "Types of AI Tools",  
       y = "Number of Users") +  
  coord_flip() +  
  theme_minimal() + 
  theme(axis.text.x = element_text(angle = 45, hjust = 1),
  plot.title = element_text(size = 18, hjust = 0.5))

#Converting the grouped bar plot to an interactive plot with hovering tooltip and displaying it
interactive_ai_Tools <- ggplotly(ai_Tools, tooltip = "text") |>
  layout(
    showlegend = FALSE,  
    updatemenus = list(
      list(
        type = "buttons",
        buttons = list(
          list(
            label = "Show Legend",
            method = "relayout",
            args = list("showlegend", TRUE)
          ),
          list(
            label = "Hide Legend",
            method = "relayout",
            args = list("showlegend", FALSE)
          )
        )
      )
    )
  )
interactive_ai_Tools
  

# II.
# Replacing all the "or" in the responses under the Industry column with "," to standardize the delimiter, then split the response 
subsetted_dataset$Industry <- gsub(" or ", ",", subsetted_dataset$Industry, ignore.case = TRUE)
industry_by_field <- strsplit(subsetted_dataset$Industry, split = ",")

#Remove empty entries 
industry_by_field <- lapply(industry_by_field, function(x) x[x != ""])  

# Creating a dataframe mapping for StudyFields to individual industries
industry_field_set <- data.frame(
  StudyField = rep(subsetted_dataset$StudyField, sapply(industry_by_field, length)),
  Industry = unlist(industry_by_field))

# Trim blankspace for consistency
industry_field_set$Industry <- trimws(industry_field_set$Industry)

# Count the frequency of each industry per StudyField
industry_by_field_count <- industry_field_set |>
  group_by(StudyField, Industry) |>
  summarise(Count = n(), .groups = "drop") |>
  arrange(StudyField, desc(Count)) 
DT::datatable(industry_by_field_count)

# Select the top 5 industries per StudyField
  top_industries <- industry_by_field_count |>
    group_by(StudyField) |>
    slice_max(Count, n = 5, with_ties = FALSE) |>
    ungroup()
  
# Plotting a grouped bar chart
Industry_S_Field <- ggplot(top_industries, aes(x = StudyField, y = Count, fill = Industry, text = paste("Industry: ", Industry, "<br>Graduates: ", Count))) +
    geom_bar(stat = "identity", position = "dodge") +
    labs(title = "Top 5 Industries for Each Study Field",
         x = "Study Field",
         y = "Number of Graduates",
         fill = "Industry") +
    theme_minimal() +
    theme(axis.text.x = element_text(angle = 45, hjust = 1),
          plot.title = element_text(size = 18, hjust = 0.5))
  
#Converting the grouped bar plot to an interactive plot with hovering tooltip and displaying it
  interactive_Industry_S_Field <- ggplotly(Industry_S_Field, tooltip = "text") |>
    layout(
      showlegend = FALSE,  
      updatemenus = list(
        list(
          type = "buttons",
          buttons = list(
            list(
              label = "Show Legend",
              method = "relayout",
              args = list("showlegend", TRUE)
            ),
            list(
              label = "Hide Legend",
              method = "relayout",
              args = list("showlegend", FALSE)
            )
          )
        )
      )
    )
interactive_Industry_S_Field
  
  
#III
# changing all the " or " with "," to make it easier to split Industry responses
subsetted_dataset$Role <- gsub(" or ", ",", subsetted_dataset$Role, ignore.case = TRUE)

# Split job roles by ","
role_by_field <- strsplit(subsetted_dataset$Role, split = ",")

# Create a data frame mapping study fields to individual job roles
role_field_set <- data.frame(
  StudyField = rep(subsetted_dataset$StudyField, sapply(role_by_field, length)),
  Role = unlist(role_by_field))

# Trim whitespace for consistency
role_field_set$Role <- trimws(role_field_set$Role)

# Count the frequency of each job role per study field
role_by_field_count <- role_field_set |>
  group_by(StudyField, Role) |>
  summarise(Count = n(), .groups = "drop") |>
  arrange(StudyField, desc(Count))

# Get the top 3 roles per study field
top_roles <- role_by_field_count |>
  group_by(StudyField) |>
  slice_max(order_by = Count, n = 3)  
DT::datatable(top_roles)


# Data transformation
top_roles <- role_by_field_count |>
  group_by(StudyField) |>
  slice_max(order_by = Count, n = 3) |>
  ungroup()

# Create the grouped bar chart using ggplot
top_rol <- ggplot(top_roles, aes(x = StudyField, y = Count, fill = Role, text = paste("Role: ", Role,"<br>Graduates: ", Count))) +
  geom_bar(stat = "identity", position = "dodge") +  
  labs(title = "Top 3 Job Roles for Each Study Field",
       x = "Study Field",
       y = "Number of Graduates",  
       fill = "Job Role") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1),  
        plot.title = element_text(size = 18, hjust = 0.5))  

# Convert the ggplot chart to an interactive plotly chart
interactive_top_rol <- ggplotly(top_rol, tooltip = "text") |>
  layout(
    showlegend = FALSE,
    updatemenus = list(
      list(
        type = "buttons",
        buttons = list(
          list(
            label = "Show Legend",
            method = "relayout",
            args = list("showlegend", TRUE)
          ),
          list(
            label = "Hide Legend",
            method = "relayout",
            args = list("showlegend", FALSE)
          )
        )
      )
    )
  )
interactive_top_rol

#IV 
# Ensure Employment is treated as character
subsetted_dataset$Employment <- as.character(subsetted_dataset$Employment)

# Define employment categories
employed_statuses <- c("Employed, full-time", "Employed, part-time", "Self-employed", "Self-employed;")
not_employed_status <- "Not employed"

# Create Is Employed column (TRUE if any employed status is present, FALSE if explicitly "Not employed")
subsetted_dataset$IsEmployed <- grepl(paste(employed_statuses, collapse = "|"), subsetted_dataset$Employment, ignore.case = TRUE) & 
  !grepl(not_employed_status, subsetted_dataset$Employment, ignore.case = TRUE)

# Count total graduates per study field
total_graduates <- subsetted_dataset |>
  group_by(StudyField) |>
  summarise(TotalGraduates = n(), .groups = "drop")

# Count employed graduates per study field
employed_graduates <- subsetted_dataset |>
  filter(IsEmployed == TRUE) |>
  group_by(StudyField) |>
  summarise(EmployedGraduates = n(), .groups = "drop")

# Merge the two datasets
employment_rate_df <- merge(total_graduates, employed_graduates, by = "StudyField", all.x = TRUE)

# Add numeric column for Employment Rate
employment_rate_df$EmploymentRateNumeric <- (employment_rate_df$EmployedGraduates / employment_rate_df$TotalGraduates) * 100

# Format the Employment Rate for display purposes
employment_rate_df$EmploymentRateFormatted <- sprintf("%.2f%%", employment_rate_df$EmploymentRateNumeric)

# Create the bar plot for StudyField and Employment Rate
erp <- ggplot(employment_rate_df, aes(x = StudyField, y = EmploymentRateNumeric, fill = StudyField, text = paste("<br>Graduates: ", TotalGraduates, "<br>Employment Rate: ", EmploymentRateFormatted))) +
  geom_bar(stat = "identity") +  
  labs(title = "Employment Rate by Study Field",
       x = "Study Field",
       y = "Employment Rate (%)") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1),  
        plot.title = element_text(size = 18, hjust = 0.5)) +  
  scale_y_continuous(limits = c(0, 100)) +  # Scale y-axis from 0 to 100%
  scale_fill_viridis_d()  # Use a color scale for discrete variables

# Convert the ggplot chart to an interactive plotly chart
interactive_erp <- ggplotly(erp, tooltip = "text") |>
  layout(
    showlegend = FALSE, 
    updatemenus = list(
      list(
        type = "buttons",  
        buttons = list(
          list(
            label = "Show Legend",
            method = "relayout",
            args = list("showlegend", TRUE)
          ),
          list(
            label = "Hide Legend",
            method = "relayout",
            args = list("showlegend", FALSE)
          )
        )
      )
    )
  )
interactive_erp
