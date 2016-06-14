####
# This script will train, validate, and save a model
####



#### Import cleansed data ####
library(feather)
my_data <- read_feather("mydata.feather")






#### Split dataset ####

# Set % of data to use for training
split_percent <- 0.7

# Create an index for training data
train_index <- sample((1:nrow(my_data)),
                      round(split_percent * nrow(my_data)),
                      replace = FALSE)

training_data <- my_data[train_index, ]  # Training dataset using rows randomly sampled
testing_data <- my_data[-train_index, ]  # Test set using remaining rows







#### Train model ####
library(rpart)

# Define the objective function (syntax: target ~ feature1 + feature2 ... + featuren)
objective_function <- Species ~ Sepal.Length + Sepal.Width + Petal.Length + Petal.Width

# Fit the model to the training data using objective function
iris_model <- rpart(objective_function,
             data = training_data,
             method = "class",
             control = rpart.control(minsplit = 4))

# View resulting model
plot(iris_model)
text(iris_model)
model_summary <- summary(iris_model)
print(model_summary)






#### Cross-validation ####
testing_data$prediction <- predict(iris_model, testing_data, type = "class")


# Validation Metrics
confusion_matrix <- table(testing_data$Species,
                          testing_data$prediction)

true_positive_rate <- 100 * sum(testing_data$Species == testing_data$prediction) / nrow(testing_data)

# Print validation results
print(confusion_matrix)
print(true_positive_rate)






#### Export model ####
# Export model:
save(iris_model, file = "model.RData")

# Export validation results:
save(model_summary, file = "model_summary.RData")  # Model details
save(confusion_matrix, file = "model_confusion_matrix.RData")  # Confusion matrix
