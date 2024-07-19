library(ggplot2)

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

# Plot the data
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

###### NO VERIFICATION

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

# Plot the data
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
