
library(shiny)

shinyServer(function(input, output) {

## sidebarPanel
  invlambda <- reactive({1/input$lambda})
  output$pop.mean <- renderText(round(invlambda(),3))
  output$pop.sd <- renderText(round(invlambda(),3))
  output$CLT.mean <- renderText(round(invlambda(),3))
  output$CLT.SEM <- renderText(round(invlambda()/sqrt(input$n), 3))

## Tab 2  
  sample <- reactive({
        matrix(rexp(n = 1000*input$n, rate = input$lambda), nrow = 1000, ncol = input$n) 
  })
  output$samp.mean <- reactive({round(mean(sample()),3)})
  output$samp.sd <- reactive({round(sd(sample()),3)})
  output$plot1 <- renderPlot({
          hist(sample(), breaks = seq(0,100,0.5), xaxt = "n",
               freq = FALSE, xlim = c(0,20), ylim = c(0,0.4),
               main = "Sampling Distribution of Exponentials",
               xlab = "Values of Exponentials", ylab = "Density")
          axis(side = 1, at = seq(0,20,2), labels = as.character(seq(0,20,2)), tck=-.05)
          if(input$annotate1a){
            abline(v = mean(sample()), col = "red", lwd = 2)
          }
          if(input$annotate1b){
            curve(dexp(x, rate = input$lambda), add = TRUE, col = "blue", lwd = 2)
          }
  })

  
## Tab 3  
  means <- reactive({apply(sample(), MARGIN = 1, FUN = mean)})
  output$sampmean.mean <- reactive({round(mean(means()),3)})
  output$sampmean.SEM <- reactive({round(sd(means()),3)})  
  output$plot2 <- renderPlot({
          hist(means(), breaks = seq(0,100,0.125), xaxt = "n",
                freq = FALSE, xlim = c(0,10), ylim = c(0,2),
                main = "Sampling Distribution of Mean of Exponentials",
                xlab = expression(Mean~of~italic(n)~Exponentials), ylab = "Density")
          axis(side = 1, at = seq(0,10,1), labels = as.character(seq(0,10,1)), tck=-.05)
          if(input$annotate2a){
            abline(v = mean(means()), col = "red", lwd = 2)
          }
          if(input$annotate2b){
            library(EnvStats)
            curve(demp(x, as.vector(means())), add = TRUE, col = "red", lwd = 2)     
          }
          if(input$annotate2c){
            curve(dnorm(x, mean = invlambda(), sd = invlambda()/sqrt(input$n)),
              add=TRUE, col="blue", lwd = 2)
          }
  })
                
})
