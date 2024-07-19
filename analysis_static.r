
library(ggplot2)

###### NAIVE - NO EVENTLOG VERIFICATION

results <- data.frame(x = integer(), total_ns = numeric())

directory <- "run_static_naive_noverif"

for (i in 1:20) {
    file_name <- paste0(directory, "/result_", i, "_players_run_1.csv")
    data <- read.csv(file_name)
    if ("ra_static" %in% data$name) {
        ra_static_value <- data$total_ns[data$name == "ra_static"]
        results <- rbind(results, data.frame(x = i, total_s = ra_static_value / 1e9))
    } else {
        results <- rbind(results, data.frame(x = i, total_s = NA))
    }
}

ggplot(results, aes(x = x, y = total_s)) +
    geom_line() +
    geom_point() +
    labs(
        title = "Total_ns for ra_static across different runs",
        x = "Run number",
        y = "Total_ns for ra_static"
    ) +
    ylim(0, max(results$total_s)) +
    theme_minimal()

###### STATIC TREE - NO EVENTLOG VERIFICATION

results <- data.frame(x = integer(), total_ns = numeric())

directory <- "run_static_tree_noverif"

for (i in 1:20) {
    file_name <- paste0(directory, "/result_", i, "_players_run_1.csv")
    data <- read.csv(file_name)
    if ("ra_static" %in% data$name) {
        ra_static_value <- data$total_ns[data$name == "ra_static"]
        results <- rbind(results, data.frame(x = i, total_s = ra_static_value / 1e9))
    } else {
        results <- rbind(results, data.frame(x = i, total_s = NA))
    }
}

ggplot(results, aes(x = x, y = total_s)) +
    geom_line() +
    geom_point() +
    labs(
        title = "Total_ns for ra_static across different runs",
        x = "Run number",
        y = "Total_ns for ra_static"
    ) +
    ylim(0, max(results$total_s)) +
    theme_minimal()

###### NAIVE - EVENTLOG VERIFICATION

results <- data.frame(x = integer(), total_ns = numeric())

directory <- "run_static_naive_verif"

for (i in 1:20) {
    file_name <- paste0(directory, "/result_", i, "_players_run_1.csv")
    data <- read.csv(file_name)
    if ("ra_static" %in% data$name) {
        ra_static_value <- data$total_ns[data$name == "ra_static"]
        results <- rbind(results, data.frame(x = i, total_s = ra_static_value / 1e9))
    } else {
        results <- rbind(results, data.frame(x = i, total_s = NA))
    }
}

ggplot(results, aes(x = x, y = total_s)) +
    geom_line() +
    geom_point() +
    labs(
        title = "Total_ns for ra_static across different runs",
        x = "Run number",
        y = "Total_ns for ra_static"
    ) +
    ylim(0, max(results$total_s)) +
    theme_minimal()


######## STATIC TREE- EVENTLOG VERIFICATION

results <- data.frame(x = integer(), total_ns = numeric())

directory <- "run_static_tree_verif"

for (i in 1:20) {
    file_name <- paste0(directory, "/result_", i, "_players_run_1.csv")
    data <- read.csv(file_name)
    if ("ra_static" %in% data$name) {
        ra_static_value <- data$total_ns[data$name == "ra_static"]
        results <- rbind(results, data.frame(x = i, total_s = ra_static_value / 1e9))
    } else {
        results <- rbind(results, data.frame(x = i, total_ns = NA))
    }
}

ggplot(results, aes(x = x, y = total_s)) +
    geom_line() +
    geom_point() +
    labs(
        title = "Total_ns for ra_static across different runs",
        x = "Run number",
        y = "Total_ns for ra_static"
    ) +
    ylim(0, max(results$total_s)) +
    theme_minimal()


###### COMBINED -- NO EVENTLOG VERIFICATION

# Load necessary library
library(ggplot2)

# Initialize a data frame to store the results
results_naive <- data.frame(x = integer(), total_s = numeric(), method = character())
results_static_tree <- data.frame(x = integer(), total_s = numeric(), method = character())

# Directory containing the CSV files for naive method
directory_naive <- "run_static_naive_noverif"

for (i in 1:20) {
    file_name <- paste0(directory_naive, "/result_", i, "_players_run_1.csv")
    data <- read.csv(file_name)
    if ("ra_static" %in% data$name) {
        ra_static_value <- data$total_ns[data$name == "ra_static"]
        results_naive <- rbind(results_naive, data.frame(x = i, total_s = ra_static_value / 1e9, method = "Naive"))
    } else {
        results_naive <- rbind(results_naive, data.frame(x = i, total_s = NA, method = "Naive"))
    }
}

# Directory containing the CSV files for static tree method
directory_static_tree <- "run_static_tree_noverif"

for (i in 1:20) {
    file_name <- paste0(directory_static_tree, "/result_", i, "_players_run_1.csv")
    data <- read.csv(file_name)
    if ("ra_static" %in% data$name) {
        ra_static_value <- data$total_ns[data$name == "ra_static"]
        results_static_tree <- rbind(results_static_tree, data.frame(x = i, total_s = ra_static_value / 1e9, method = "Tree"))
    } else {
        results_static_tree <- rbind(results_static_tree, data.frame(x = i, total_s = NA, method = "Tree"))
    }
}

# Combine the two datasets into one
combined_results <- rbind(results_naive, results_static_tree)

# Plot the combined data
p  <- ggplot(combined_results, aes(x = x, y = total_s, color = method)) +
    geom_line() +
    geom_point() +
    labs(
        x = "size of P",
        y = "seconds",
        color = "Method"
    ) +
    ylim(0, max(combined_results$total_s, na.rm = TRUE)) +
    theme_minimal()
ggsave("latency_static_noevlog.eps", p, width = 6, height = 4, dpi = 300)

###### COMBINED - EVENTLOG VERIFICATION


library(ggplot2)

results_naive_verif <- data.frame(x = integer(), total_s = numeric(), method = character())
results_static_tree_verif <- data.frame(x = integer(), total_s = numeric(), method = character())
directory_naive_verif <- "run_static_naive_verif"

for (i in 1:20) {
    file_name <- paste0(directory_naive_verif, "/result_", i, "_players_run_1.csv")
    data <- read.csv(file_name)
    if ("ra_static" %in% data$name) {
        ra_static_value <- data$total_ns[data$name == "ra_static"]
        results_naive_verif <- rbind(results_naive_verif, data.frame(x = i, total_s = ra_static_value / 1e9, method = "Naive"))
    } else {
        results_naive_verif <- rbind(results_naive_verif, data.frame(x = i, total_s = NA, method = "Naive"))
    }
}

directory_static_tree_verif <- "run_static_tree_verif"

for (i in 1:20) {
    file_name <- paste0(directory_static_tree_verif, "/result_", i, "_players_run_1.csv")
    data <- read.csv(file_name)
    if ("ra_static" %in% data$name) {
        ra_static_value <- data$total_ns[data$name == "ra_static"]
        results_static_tree_verif <- rbind(results_static_tree_verif, data.frame(x = i, total_s = ra_static_value / 1e9, method = "Tree"))
    } else {
        results_static_tree_verif <- rbind(results_static_tree_verif, data.frame(x = i, total_s = NA, method = "Tree"))
    }
}

combined_results_verif <- rbind(results_naive_verif, results_static_tree_verif)

p <- ggplot(combined_results_verif, aes(x = x, y = total_s, color = method)) +
    geom_line() +
    geom_point() +
    labs(
        x = "size of P",
        y = "seconds",
        color = "Method"
    ) +
    ylim(0, max(combined_results_verif$total_s, na.rm = TRUE)) +
    theme_minimal()


ggsave("latency_static_evlog.eps", p, width = 6, height = 4, dpi = 300)
