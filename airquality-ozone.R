# Primeiramente faça a instalação do shiny com o seguinte comando
install.packages("shiny")


#invoke a biblioteca shiny para assim conseguir utilizar
library(shiny)

#Aqui começas o ui ou o nosso Frontend que é constituída por Título, side Panel e main Panel

ui <- fluidPage(
  
  titlePanel("Ozone Level"),
  
  sidebarLayout(
    # no side bar pannel vai aparecer uma barra onde podemos definir a quantidade de dados que 
    # queremos
    sidebarPanel(
      # chamamos aqui de slider da quantidade de dados (bins)
      #com o valor mínimo e máximo e o valor padrão que foi definido por 30 
      # por final o step que significa que o slide vai andando de 2 em 2,
      # ou seja, a partir do ponto inicial 0 ela passa para o 2,4,6 e assim consecutivamente
      sliderInput(inputId = "bins",
                  label = "Number of bins:",
                  min = 0,
                  max = 40,
                  value = 30,
                  step = 2)
      
    ),
    # O Painel principal vai mostrar nosso histograma após o processamento da variável distPlot
    # que é retornada pelo server
    mainPanel(
      plotOutput(outputId = "distPlot")
    )
  )
)

# Define server logic required to draw a histogram ----
server <- function(input, output) {
  

  output$distPlot <- renderPlot({
    #airquality é uma base já disponível que possui várias colunas a que vamos utilizar é a coluna Ozone
    x    <- airquality$Ozone
    # A coluna ozone possui vários dados como NA e não queremos mostrar esses dados então seguimos em omitir estes dados
    x   <- na.omit(x)
    
    bins <- seq(min(x), max(x), length.out = input$bins + 1)
    # aqui estamos definindo nosso histograma com os dados x (Ozonio), com uma cor e borda das colunas definidas com o x label e título do histograma
    hist(x, breaks = bins, col = "#75AADB", border = "white",
         xlab = "Ozone Level",
         main = "Histogram of Ozone level")
    
  })
  
}

# Constrói o shinny app que vai fazer a comunicação entre o ui e server
shinyApp(ui = ui, server = server)

