####
# This script executes the model
####

library(rpart)


# Import our iris model
load("model.RData")


# Define a function to execute the model
iris_prediction <- function(Sepal.Length, Sepal.Width, Petal.Length, Petal.Width){

  # Make a data frame from the input data
  prediction_data <- data.frame(Sepal.Length = Sepal.Length,
                                Sepal.Width = Sepal.Width,
                                Petal.Length = Petal.Length,
                                Petal.Width = Petal.Width)


  # Run prediction with input data
  prediction_data$Species <- predict(iris_model, prediction_data, type = "class")


  # Return the species
  return(as.character(prediction_data$Species[1]))
}
