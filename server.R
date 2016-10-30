library(shiny)
library(ggplot2)

# Define server logic required to create and plot the Harmonic Motion data
shinyServer(function(input, output) {
   
  output$SHMPlot <- renderPlot({

# This application reads in the Mass and Spring Force constant and calculates the
# Simple Harmonic Motion using the following formula:

# x is the displacement of a mass from the spring centre (in metres)     
# m is mass of the weight (in kg)
# k is the spring force (in N/m)        
# A is the starting Amplitude (in metres)
# t is elapsed time (in seconds)
# phi is the phase shift (in radians)
# w0 is the undamped natural frequency (in radians/sec)
# d is the viscous damping factor (dimensionless)
 
# Equation for w0 = sqrt(k/m)
# Equation for w1 = w0 * sqrt(1 - d^2)
# Equation for w2 = w0 * sqrt(d^2 - 1)
# Equation for undamped (d = 0) Harmonic Motion: x(t) = A*Cos(w0t + phi)
# Equation for underdamped (d < 1): x(t) = A*cos(w1*t - phi)*e^-(g*w0*t)
# Equation for critical damped (d = 1): x(t) = A*(1 + w0*t)*e^-(w0*t)
# Equation for overdamped (d > 1): x(t) = (A*cosh(w2*t) + (A*d*w0/w2)*sinh(w2*t))*e^-(d*w0*t)
#
          
          #define chosen starting values 
          A <- 1
          phi <- 0
          t <- seq(0.1, 20, 0.1) #set time between 1 to 10 secs, fidelity 0.1 sec
          
          #read in slider values
          m <- input$slider_mass
          k <- input$slider_sfConstant
          d <- input$slider_dConstant

          #calculate undamped data (d != 0)
          w0 <- sqrt(k/m)
          x0 <- A*cos(w0*t)
          x1 <- x0
          
          #calculate for damped
          if (d != 0 & d < 1) { #underdamped
                  w1 <- w0 * sqrt(1 - d^2)
                  x1 <- A*cos(w1*t - phi)*exp(-d*w0*t)
          } else
          if (d == 1) { #critical damped
                  x1 <- A*(1 + w0*t)*exp(-w0*t)
          } else
          if (d > 1) { #overdamped
                  w2 <- w0 * sqrt(d^2 - 1)
                  x1 <- (A*cosh(w2*t) + (A*d*w0/w2)*sinh(w2*t))*exp(-d*w0*t)
          }
          
          #generate the plot
          df1 <- as.data.frame(cbind(t, x0, 0))
          names(df1) <- c("t", "x", "d")
          df2 <- as.data.frame(cbind(t, x1, 1))
          names(df2) <- c("t", "x", "d")
          df <- rbind(df1, df2)
          g <- ggplot(data = df, aes(x = t, y = x, group = d))
          g + geom_point(aes(color = d), alpha = 0.5, size = 4) +
                  geom_line() + theme(legend.position = "none") +
                  xlab("Time (seconds)") + ylab("Dispalcement (metres)")
  })
})
