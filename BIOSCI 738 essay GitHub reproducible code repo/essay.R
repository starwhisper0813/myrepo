library(tidyverse)
library(readxl)
library(openxlsx)
library(ggplot2)
library(rethinking)
library(dplyr)
library(corrplot)
library(factoextra)
library(GGally)
library(plotly)
library(MASS)
library(pheatmap)

# Read the file
nests <- read.xlsx("D:/学习工作/出国留学相关/master of science/2023 semester one/BIOSCI 738 Advanced Biological Data Analysis/essay/Supporting_Data_Passerine_Nests.xlsx", sheet = 1)
names(nests)
# Clean the data
nest <- na.omit(nests)

# Select the data 
variances <- apply(nest, 2, var)
constant_columns <- names(variances[variances == 0])
constant_columns_logical <- !(names(nest) %in% constant_columns)
nest_clean <- nest[, constant_columns_logical]
names(nest_clean)

# Make the PCA Analysis
numeric_vars <- select_if(nest_clean, is.numeric)
pca_result <- prcomp(numeric_vars, scale. = TRUE)
# print the main information of PCA
summary(pca_result)

# It's an example of how to get the pca contribution and scores of one variables(such as outer volume full)
# Get principal component scores
pca_contributions <- as.data.frame(pca_result$Outer_volume_full..cm3)
# Get the principal component contribution
pca_variances <- pca_result$sdev^2
pca_contributions <- pca_variances / sum(pca_variances)
# Draw a cumulative contribution plot
plot(cumsum(pca_contributions), type = "b", xlab = "Number of Principal Components", ylab = "Cumulative Contribution")

# Get the screen plot
fviz_screeplot(pca_result)
# Get the biplot
fviz_pca_biplot(pca_result, geom = "point") +
  geom_point (alpha = 0.2)
fviz_pca_biplot(pca, axes = c(2,3),geom = "point") +
  geom_point (alpha = 0.2)
# Get the loading plot
pca_result$rotation %>%
  as.data.frame() %>%
  mutate(variables = rownames(.)) %>%
  gather(PC,loading,PC1:PC4) %>%
  ggplot(aes(abs(loading), variables, fill = loading > 0)) +
  geom_col() +
  facet_wrap(~PC, scales = "free_y") +
  labs(x = "loading absolute value",y = NULL, fill = "Positive")+
  scale_fill_manual(values = c("lightblue", "lightyellow"))  

## Extract numeric variables
numeric_vars <- sapply(nest_clean, is.numeric)
numeric_nest <- nest_clean[, numeric_vars]

# Get the correlation matrix
correlation_matrix <- cor(numeric_nest)
# Get the corrploy 
corrplot(correlation_matrix, method = "circle")

## Get the heatmap
pheatmap(scaled_vars)
pheatmap(correlation_matrix)

## Point plot between Range midpoint latitude and Clutch size
ggplot(nest_clean, aes(x = Range_midpoint_latitude, y = Clutch_size)) +
  geom_point(stat = "summary", fun = "mean", color = "red", size = 3) 

# Range_midpoint_latitude and Clutch_size
# Calculate correlation coeficient
# Pearson correlation coefficient
pearson_corr <- cor(nest_clean$Range_midpoint_latitude, nest_clean$Clutch_size, method = "pearson")
print(paste("Pearson correlation coefficient:", pearson_corr))
# Spearman correlation coefficient
spearman_corr <- cor(nest_clean$Range_midpoint_latitude, nest_clean$Clutch_size, method = "spearman")
print(paste("Spearman correlation coefficient:", spearman_corr))
# Kendall correlation coefficient
kendall_corr <- cor(nest_clean$Range_midpoint_latitude, nest_clean$Clutch_size, method = "kendall")
print(paste("Kendall correlation coefficient:", kendall_corr))
# Set lm model
lm_clutch <- lm(Range_midpoint_latitude ~ Clutch_size, data = nest_clean)
summary(lm_clutch)

# Violin plot 
nest_clean$log_Body_mass..g <- log(nest_clean$Body_mass..g)
ggplot(nest_clean, aes(x = `Migration_status`, y = `log_Body_mass..g`, col = `Migration_status`, fill = "Migration_status")) +
  geom_violin(trim = FALSE) +
  geom_boxplot(width = 0.1, fill = "white", color = "black") +
  stat_summary(fun = mean, geom = "point", color = "red", size = 3) +
  stat_summary(fun = median, geom = "point", color = "blue", size = 3) +
  stat_summary(fun = function(x) quantile(x, 0.25), geom = "point", color = "green", size = 3) +
  stat_summary(fun = function(x) quantile(x, 0.75), geom = "point", color = "yellow", size = 3) +
  labs(x = "Migration_status", y = "log_Body_mass..g", fill = "Migration_status") +
  scale_fill_manual(values = c( "lightblue")) +
  theme_minimal()




