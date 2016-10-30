library(shiny)

# Define UI for application that draws a scatterplot containing Harmonic Motion data
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Simple Harmonic Oscillator"),
  
  # Sidebar with a slider input for mass, spring force and damping factor 
  sidebarLayout(
    sidebarPanel(
        h3("Move sliders to select Bob-weight mass, Spring Force and Dampening constant"),
        h2(""),
        sliderInput("slider_mass", "Mass of bob-weight (kg):", min = 1, max = 20, value = 5),
        sliderInput("slider_sfConstant", "Spring Force constant (N/m):", min = 1, max = 20, value = 10),
        sliderInput("slider_dConstant", "Damping constant:", min = 0, max = 2, value = 0.2, step = 0.1)
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
        h3("Scatter plot of Simple Harmonic Motion", align = "center"),
        plotOutput("SHMPlot")
    )
  )
))
