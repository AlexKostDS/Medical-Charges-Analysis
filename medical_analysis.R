# Load the dataset
medical_data <- read.csv("medical.csv")

# Question 1: Check for duplicates
cat("Question 1: Number of duplicate rows:\n")
num_duplicates <- sum(duplicated(medical_data))
cat(num_duplicates, "\n\n")

# Question 2: Count males and females
cat("Question 2: Gender count:\n")
gender_counts <- table(medical_data$sex)
print(gender_counts)
cat("\n")

# Question 3: Count smokers and non-smokers
cat("Question 3: Smokers vs Non-smokers:\n")
smoker_counts <- table(medical_data$smoker)
print(smoker_counts)
cat("\n")

# Question 4: Average charges for smokers vs non-smokers
cat("Question 4: Average charges for smokers vs non-smokers:\n")
avg_smokers <- mean(medical_data$charges[medical_data$smoker == "yes"])
avg_nonsmokers <- mean(medical_data$charges[medical_data$smoker == "no"])
cat("Smokers:", avg_smokers, "\nNon-smokers:", avg_nonsmokers, "\n\n")

# Question 5: Person who paid the most and the least
cat("Question 5: Person who paid the most and the least:\n")
max_charge_index <- which.max(medical_data$charges)
min_charge_index <- which.min(medical_data$charges)
cat("Max charges:\n")
print(medical_data[max_charge_index, ])
cat("Min charges:\n")
print(medical_data[min_charge_index, ])
cat("\n")

# Question 6: Number of adults (age ≥18) and children
cat("Question 6: Number of adults and children:\n")
adults <- sum(medical_data$age >= 18)
children <- sum(medical_data$age < 18)
cat("Adults:", adults, "\nChildren:", children, "\n\n")

# Question 7: Average BMI by region
cat("Question 7: Average BMI by region:\n")
regions <- unique(medical_data$region)
for (r in regions) {
  avg_bmi <- mean(medical_data$bmi[medical_data$region == r])
  cat(r, ":", avg_bmi, "\n")
}
cat("\n")

# Question 8: Bar plot of male vs female
cat("Question 8: Gender distribution bar plot:\n")
barplot(gender_counts, main = "Gender Distribution", col = c("lightblue", "pink"))
cat("\n")

# Question 9: Bar plot of smokers by region
cat("Question 9: Smokers per region bar plot:\n")
smokers_by_region <- table(medical_data$region[medical_data$smoker == "yes"])
barplot(smokers_by_region, main = "Smokers per Region", col = "orange")
cat("\n")

# Question 10: Average charges for male smokers vs female smokers
cat("Question 10: Avg charges for male vs female smokers:\n")
male_smokers <- medical_data$charges[medical_data$sex == "male" & medical_data$smoker == "yes"]
female_smokers <- medical_data$charges[medical_data$sex == "female" & medical_data$smoker == "yes"]
cat("Male smokers:", mean(male_smokers), "\nFemale smokers:", mean(female_smokers), "\n\n")

# Question 11: Number of obese individuals (BMI ≥ 30)
cat("Question 11: Number of obese individuals (BMI ≥ 30):\n")
obese_count <- sum(medical_data$bmi >= 30)
cat("Obese people:", obese_count, "\n\n")

# Question 12: Recommend region with lowest average charges
cat("Question 12: Best region to move to for lower medical charges:\n")
avg_charges_by_region <- tapply(medical_data$charges, medical_data$region, mean)
best_region <- names(which.min(avg_charges_by_region))
cat("Recommended region:", best_region, "with average charges of", avg_charges_by_region[best_region], "\n\n")

# Question 13: Average charges for people with children vs without children
cat("Question 13: Average charges for people with children vs without:\n")
with_children <- mean(medical_data$charges[medical_data$children > 0])
without_children <- mean(medical_data$charges[medical_data$children == 0])
cat("With children:", with_children, "\nWithout children:", without_children, "\n\n")

# Question 14: Correlation between age, bmi, children, and charges
cat("Question 14: Correlation matrix:\n")
cor_matrix <- cor(medical_data[, c("age", "bmi", "children", "charges")])
print(round(cor_matrix, 3))

# Question 15: T-test for charges between smokers and non-smokers
cat("Question 15: T-test for charges smoker vs non-smoker:\n")
t_test_result <- t.test(charges ~ smoker, data = medical_data)
print(t_test_result)


# Question 16: Simple linear regression predicting charges
cat("Question 16: Linear regression summary (charges ~ bmi + age + smoker):\n")
medical_data$smoker_flag <- ifelse(medical_data$smoker == "yes", 1, 0)  # numeric smoker variable
lm_model <- lm(charges ~ bmi + age + smoker_flag, data = medical_data)
print(summary(lm_model))

# Question 17: Scatter plot with regression line (charges vs bmi)
cat("Question 17: Scatter plot of Charges vs BMI with regression line\n")
plot(medical_data$bmi, medical_data$charges,
     xlab = "BMI", ylab = "Medical Charges",
     main = "Charges vs BMI")
abline(lm(charges ~ bmi, data = medical_data), col = "red")

# Question 18: Boxplot of charges by smoker status
cat("Question 18: Boxplot of charges by smoker status\n")
boxplot(charges ~ smoker, data = medical_data,
        main = "Medical Charges by Smoking Status",
        col = c("lightgreen", "lightpink"))


# Question 19: Create BMI categories and show counts
cat("Question 19: BMI categories:\n")
medical_data$bmi_category <- cut(medical_data$bmi, 
                                 breaks = c(-Inf,18.5,25,30,35,40,Inf),
                                 labels = c("Underweight","Normal","Overweight","Obese","Severely Obese","Morbidly Obese"))
print(table(medical_data$bmi_category))


# Question 20: Average charges by BMI category, smoker, and sex (grouped summary)
cat("Question 20: Average charges by BMI category, smoker, and sex:\n")
avg_charges_grouped <- aggregate(charges ~ bmi_category + smoker + sex, data = medical_data, mean)
print(avg_charges_grouped)

# Question 21: Percent increase in charges for smokers compared to non-smokers
cat("Question 21: Percent increase in average charges for smokers vs non-smokers:\n")
percent_increase <- ((avg_smokers - avg_nonsmokers) / avg_nonsmokers) * 100
cat(round(percent_increase, 2), "%\n\n")

# Question 22: Average charges by number of children
cat("Question 22: Average charges by number of children:\n")
avg_charges_children <- aggregate(charges ~ children, data = medical_data, mean)
print(avg_charges_children)


# End of script
