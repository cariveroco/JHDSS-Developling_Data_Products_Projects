
library(shiny)

shinyUI(fluidPage(
  withMathJax(),
  titlePanel("Central Limit Theorem: Proof by Simulation"),
  sidebarLayout(
  
    sidebarPanel(
      h4("Let's prove the CLT by simulation of a non-Gaussian distribution!"),
      h5("Enter the", strong("rate, \\(\\lambda\\)"), "of an exponential distribution:"),
      numericInput("lambda", NULL, 0.2, 0.2, 0.5, 0.05),
      tags$ul(
        tags$li("Population mean,", strong("\\(\\mu\\) =",
          textOutput("pop.mean", inline = TRUE))),
        tags$li("Population standard deviation,", strong("\\(\\sigma\\) =",
          textOutput("pop.sd", inline = TRUE)))
      ),
      h5("Proceed to the", strong("Random Exponentials"), "tab for visualization."),
      br(),
      h5("Next, enter the desired", strong("sample size, \\(n\\)"), "to be averaged:"),
      sliderInput("n", NULL, 10, 100, 40, 5),
      h5("The CLT predicts the following properties for the sample mean distribution:"),
      tags$ul(
          tags$li("Mean,", strong("Theoretical \\(\\bar x\\) =",
            textOutput("CLT.mean", inline = TRUE))),
          tags$li("Standard error,", strong("Theoretical \\(SEM\\) =",
            textOutput("CLT.SEM", inline = TRUE)))
      ),
      h5("Proceed to the", strong("Sample Means of Exponentials"), "tab for visualization and confirmation of CLT-predicted statistics.")
    ), ## sidebarPanel

    mainPanel(
      tabsetPanel(type = "tabs",   
        
        tabPanel(strong("CLT Concept"), br(),
          h5("The", strong("Central Limit Theorem (CLT)"), "states that given  samples of independent and identically distributed random variables from a population distribution, and given that the samples are sufficiently large with size \\(n\\) ≥ 30, then the", strong(em("sampling distribution of the sample mean")),  "will have the following properties:"),
          tags$ul(
            tags$li(
              h5(strong(em("Distribution"))),
              h5("Even if the population distribution is non-Gaussian, the distribution of the sample mean will be approximately normal.")
            ),
            tags$li(
              h5(strong(em("Center"))),
              h5("The center of the distribution of the sample mean \\(\\bar x\\) will be approximately equal to the population mean \\(\\mu\\).")
            ),
            tags$li(
              h5(strong(em("Spread"))),
              h5("The standard error of the distribution of the sample mean (SEM) will be approximately equal to the ratio of the population standard error \\(\\sigma\\) and square root of the sample size. $$SEM = \\frac{\\sigma}{\\sqrt{n}}$$")
            )
          ) ## tags$ul
        ), ## tabPanel Tab 1
        
        tabPanel(strong("Random Exponentials"), br(),
          h5("An exponential distribution has a population mean \\(\\mu\\) and standard deviation \\(\\sigma\\) both equal to \\(\\frac1\\lambda\\). A subset of \\(1000 \\times n\\) random variables were taken from the population of exponentials with the provided rate \\(\\lambda\\), with its histogram shown below."),
          plotOutput("plot1", height = 300),
          fluidRow(
            column(6,align = "center",
              checkboxInput("annotate1a", "Sample Mean", value = TRUE)),     
            column(6,align = "center",
              checkboxInput("annotate1b", "Population Density Curve", value = TRUE))
          ),
          h5("As expected, the sample statistics approximate the population statistics:"),
          tags$ul(
            tags$li("Sample mean,", strong("\\(\\bar x\\) =",
              textOutput("samp.mean", inline = TRUE))),
            tags$li("Sample standard deviation,", strong("\\(s\\) =",
              textOutput("samp.sd", inline = TRUE)))
          )
        ), ## tabPanel Tab 2
        
        tabPanel(strong("Sample Means of Exponentials"), br(),
          h5("The subset of \\(1000 \\times n\\) random variables were grouped into \\(1000\\) samples of \\(n\\) elements each. The mean of each of these samples were taken, each corresponding to a new random variable that has their own distribution as shown in the plot below. The Central Limit Theorem states that the properties of the distribution of these sample means may be approximated, as earlier explained."),
          plotOutput("plot2", height = 300),
          fluidRow(
            column(4,align = "center",
              checkboxInput("annotate2a", "Simulated Mean", value = TRUE)),     
            column(4,align = "center",
              checkboxInput("annotate2b", "Simulated Density Curve", value = TRUE)),
            column(4,align = "center",
              checkboxInput("annotate2c", "Theoretical Density Curve", value = TRUE))
          ),
          h5("Indeed, the simulated statistics of the sampling distribution of means are approximately equal to the theoretical statistics predicted by the CLT theorem:"),
          tags$ul(
            tags$li("Mean of sample means,", strong("Simulated \\(\\bar x\\) =",
              textOutput("sampmean.mean", inline = TRUE))),
            tags$li("Standard error of sample means,", strong("Simulated \\(SEM\\) =", 
              textOutput("sampmean.SEM", inline = TRUE)))
          )
        ) ## tabPabel Tab 3
        
      ) ## tabsetPanel
    ) ## mainPanel

  ) ## sidebarLayout
)) ## ShinyUI, fluidPage