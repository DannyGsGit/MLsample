####
# This script executes the model

library(rpart)
load("model.RData")

iris_prediction <- function(Sepal.Length, Sepal.Width, Petal.Length, Petal.Width){
  prediction_data <- data.frame(Sepal.Length = Sepal.Length,
                                Sepal.Width = Sepal.Width,
                                Petal.Length = Petal.Length,
                                Petal.Width = Petal.Width)

  prediction_data$Species <- predict(fit, prediction_data, type = "class")

  return(as.character(prediction_data$Species[1]))
}
