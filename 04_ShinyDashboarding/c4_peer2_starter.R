library(shiny)
library(tidyverse)
library(plotly)
library(DT)

#####Import Data

dat<-read_csv(url("https://www.dropbox.com/s/uhfstf6g36ghxwp/cces_sample_coursera.csv?raw=1"))
dat<- dat %>% select(c("pid7","ideo5","newsint","gender","educ","CC18_308a","region"))
dat<-drop_na(dat)

#####Make your app

ui<-navbarPage("My Application",
    tabPanel("Page 1",
             sidebarLayout(
                 sidebarPanel(
                     sliderInput("slider", 
                                 label=("Select Five Point Ideology (1=Very liberal, 5=Very conservative)"),
                                 min=1,
                                 max=5,
                                 value=3),
                 ),
                 mainPanel(
                     tabsetPanel(
                         tabPanel("Tab1",
                                  plotOutput("plot1_1")),
                         tabPanel("Tab2",
                                  plotOutput("plot1_2"))
                         )
                     )
                 )
             ),
    tabPanel("Page 2",
             sidebarLayout(
                 sidebarPanel(
                     checkboxGroupInput("checkbox",
                              label="Select Gender",
                              choices=list("1"=1, "2"=2)
                              )
                     ),
                     mainPanel(plotlyOutput("plot2"))
             )
    ),
    tabPanel("Page 3",
             sidebarLayout(
                 sidebarPanel(
                     selectInput("textbox",
                                 label="Select Region",
                                 choices=list("1"=1, "2"=2, "3"=3, "4"=4),
                                 multiple=TRUE
                                 )
                     ),
                 mainPanel(dataTableOutput("datatable3", height="500"))
             )
    )
)

server<-function(input,output){
  
    output$plot1_1<-renderPlot({
        ideo_value<-input$slider
        ggplot(dat %>% filter(ideo5==ideo_value), aes(x=pid7)) + 
            geom_bar(stat="count") + 
            labs(x="7 Point Party ID, 1=Very D, 7=Very R", y="Count") + 
            scale_y_continuous(breaks=seq(0, 100, 25), limits=c(0, 100)) + 
            xlim(0, 8)
    })
    
    output$plot1_2<-renderPlot({
        ideo_value<-input$slider
        ggplot(dat %>% filter(ideo5==ideo_value), aes(x=CC18_308a)) + 
            geom_bar(stat="count") + 
            labs(x="Trump Support", y="count") + 
            xlim(0,5)
    })
    
    output$plot2<-renderPlotly({
        gender_value<-input$checkbox
        ggplotly(
            ggplot(dat %>% filter(gender %in% gender_value), aes(x=educ, y=pid7)) +
                geom_jitter() + 
                geom_smooth(method="lm")
        )
    })
    
    output$datatable3<-renderDataTable({
        dat %>% filter(region %in% input$textbox)
    })
  
} 

shinyApp(ui,server)