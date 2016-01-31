library(caret)
library(dplyr)
library(Rmisc)
library(rpart)
library(e1071)

set.seed(42)

audit <- read.csv("audit.csv")
newaudit <- audit[complete.cases(audit),] 
inTrain <- createDataPartition(y = newaudit$TARGET_Adjusted, p = 0.7, list = FALSE)
trainset <- newaudit[inTrain,]
testset <- newaudit[-inTrain,]

modelFit <- train(as.factor(TARGET_Adjusted) ~ Age + as.factor(Employment) + as.factor(Education) + 
                    as.factor(Marital) + as.factor(Occupation) + Income + as.factor(Gender) + 
                    Deductions,
                  data=trainset,
                  method = "rpart")

shinyServer(  
  function(input, output) {
      
      output$Prediction <- renderPrint(if(predict(modelFit, 
                                              newdata = data.frame(Age = input$Age,
                                                                   Employment = input$Employment,
                                                                   Education = input$Education,
                                                                   Marital = input$Marital, 
                                                                   Occupation = input$Occupation,
                                                                   Income = input$Income, 
                                                                   Gender = input$Gender, 
                                                                   Deductions = input$Deductions), 
                                              type = "raw") == 1) {
        ("Computer says...we should audit!")
      } else {
        "Computer says no...don't audit"
      })
    
      output$AgePlot <- renderPlot({
        gdata <- newaudit %>%
          mutate(Target = as.factor(TARGET_Adjusted))
        
        g <- ggplot(data = gdata, 
                    aes(x = Target, y = Age, 
                        fill = Target)) +
          geom_boxplot() +
          geom_hline(yintercept = input$Age) +
          ggtitle("Audit targets by Age")
        
        hdata <- as.data.frame(table(newaudit$Employment, newaudit$TARGET_Adjusted)) %>%
          filter(Var1 == input$Employment) %>%
          mutate(Target = as.factor(Var2))
        
        h <- ggplot(data = hdata, aes(x = Target, y = Freq, 
                                      fill = Target)) +
          geom_bar(stat = "identity") +
          ggtitle(paste("Audit targets for Employment Type:", input$Employment, sep = " "))
        
        idata <- as.data.frame(table(newaudit$Education, newaudit$TARGET_Adjusted)) %>%
          filter(Var1 == input$Education) %>%
          mutate(Target = as.factor(Var2))
        
        i <- ggplot(data = idata, aes(x = Target, y = Freq, 
                                      fill = Target)) +
          geom_bar(stat = "identity") +
          ggtitle(paste("Audit targets for Education Type:", input$Education, sep = " "))
        
        jdata <- as.data.frame(table(newaudit$Marital, newaudit$TARGET_Adjusted)) %>%
          filter(Var1 == input$Marital) %>%
          mutate(Target = as.factor(Var2))
        
        j <- ggplot(data = jdata, aes(x = Target, y = Freq, 
                                      fill = Target)) +
          geom_bar(stat = "identity") +
          ggtitle(paste("Audit targets for Marital Status:", input$Marital, sep = " "))
        
        kdata <- as.data.frame(table(newaudit$Occupation, newaudit$TARGET_Adjusted)) %>%
          filter(Var1 == input$Occupation) %>%
          mutate(Target = as.factor(Var2))
        
        k <- ggplot(data = kdata, aes(x = Target, y = Freq, 
                                      fill = Target)) +
          geom_bar(stat = "identity") +
          ggtitle(paste("Audit targets for Occupation Type:", input$Occupation, sep = " "))
        
        ldata <- newaudit %>%
          mutate(Target = as.factor(TARGET_Adjusted))
        
        l <- ggplot(data = ldata, 
                    aes(x = Target, y = Income, 
                        fill = Target)) +
          geom_boxplot() +
          geom_hline(yintercept = input$Income) +
          ggtitle("Audit targets by Income")
        
        mdata <- as.data.frame(table(newaudit$Gender, newaudit$TARGET_Adjusted)) %>%
          filter(Var1 == input$Gender) %>%
          mutate(Target = as.factor(Var2))
        
        m <- ggplot(data = mdata, aes(x = Target, y = Freq, 
                                      fill = Target)) +
          geom_bar(stat = "identity") +
          ggtitle(paste("Audit targets for Gender:", input$Gender, sep = " "))
        
        ndata <- newaudit %>%
          mutate(Target = as.factor(TARGET_Adjusted))
        
        n <- ggplot(data = ndata, 
                    aes(x = Target, y = Deductions, 
                        fill = Target)) +
          geom_boxplot() +
          geom_hline(yintercept = input$Deductions) +
          ggtitle("Audit targets by Deductions")
        
        multiplot(g, h, i, j, k, l, m, n, cols = 2)
        
      })
})