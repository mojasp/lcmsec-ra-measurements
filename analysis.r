#run following bash command to ensure good data (i.e., in the run all consensus phases resulted in successful key computation)
    # for ((i = 1 ; i < 21 ; i++)); do
    #         echo "$i:\n" && grep "gkexchg_success" last_run/result_${i}_* | wc
    # done

library(ggplot2)

measurement  <- "run_no_verif_low_delays/"

folders <- c("p0", "p5", "p10", "p15", "p20")

# Function to read a single CSV file and extract the required value
extract_value <- function(folder, filename) {
    file_path <- file.path(paste0(measurement, folder), filename)
    data <- tryCatch({
        read.csv(file_path)
      }, error = function(e) {
    message("Error reading file: ", file_path)
    message("Error: ", e)
    return(NULL)
    })
  
  if ( !is.null(data) && "gka and attest" %in% data$name) {
    value <- data[data$name == "gka and attest", "total_ns"]
    total_ms <- value / 1e6  # Convert from nanoseconds to milliseconds
    if(total_ms > 2000 ) {
        cat('OOB, ', folder, filename, '\n')
        return(NA)
    }
    return(total_ms)
    } else {
        cat('NA, ', folder, filename, '\n')
        return(NA)
  }
}

# Initialize an empty data frame to store the results
results <- data.frame(folder = character(), x = integer(), total_ms = numeric())

# Loop through the folders and files to extract the values
for (folder in folders) {
  for (x in 1:15) {
    filename <- paste0("result_", x, "_players_run_1.csv")
    total_ms <- extract_value(folder, filename)
    results <- rbind(results, data.frame(folder = folder, x = x, total_ms = total_ms))
  }
}

#order folders numerically 
results$folder <- factor(results$folder, levels = c("p0", "p5", "p10", "p15", "p20"))
folder_labels <- c("p0" = "0", "p5" = "5", "p10" = "10", "p15" = "15", "p20" = "20")

# Plot the results
p <- ggplot(results, aes(x = x, y = total_ms, color = folder, group = folder)) +
  geom_line() +
  geom_point() +
  labs(
       x = "Size of J",
       y = "ms", color="Size of P") +
  theme_minimal() +
  theme(plot.title = element_text(hjust = 0.5),

    # axis.title.x = element_text(size = 14),
    # axis.title.y = element_text(size = 14),
    # axis.text = element_text(size = 12),
    # legend.title = element_text(size = 14),
    # legend.text = element_text(size = 12),
        legend.position = c(0.95, 0.05),  # Position the legend at the bottom right
        legend.justification = c("right", "bottom")) +
  ylim(0, max(results$total_ms)) +
  scale_color_manual(values = c("p0" = "red", "p5" = "blue", "p10" = "green", "p15" = "purple", "p20" = "orange"),
                     labels = folder_labels)

ggsave("latency_no_verif_low_delay.eps", p, width = 6, height = 4, dpi = 300)

######### COPY PASTED PROGRAMMING FOR SECOND MEASUREMENT FOR SIMPLICITY

measurement  <- "run_no_verif_high_delays/"
folders <- c("p0", "p5", "p10", "p15", "p20")

# Function to read a single CSV file and extract the required value
extract_value <- function(folder, filename) {
    file_path <- file.path(paste0(measurement, folder), filename)
    data <- tryCatch({
        read.csv(file_path)
      }, error = function(e) {
    message("Error reading file: ", file_path)
    message("Error: ", e)
    return(NULL)
    })
  
  if ( !is.null(data) && "gka and attest" %in% data$name) {
    value <- data[data$name == "gka and attest", "total_ns"]
    total_ms <- value / 1e6  # Convert from nanoseconds to milliseconds
    if(total_ms > 2000 ) {
        cat('OOB, ', folder, filename, '\n')
        return(NA)
    }
    return(total_ms)
    } else {
        cat('NA, ', folder, filename, '\n')
        return(NA)
  }
}

# Initialize an empty data frame to store the results
results <- data.frame(folder = character(), x = integer(), total_ms = numeric())

# Loop through the folders and files to extract the values
for (folder in folders) {
  for (x in 1:15) {
    filename <- paste0("result_", x, "_players_run_1.csv")
    total_ms <- extract_value(folder, filename)
    results <- rbind(results, data.frame(folder = folder, x = x, total_ms = total_ms))
  }
}

#order folders numerically 
results$folder <- factor(results$folder, levels = c("p0", "p5", "p10", "p15", "p20"))
folder_labels <- c("p0" = "0", "p5" = "5", "p10" = "10", "p15" = "15", "p20" = "20")

# Plot the results
p <- ggplot(results, aes(x = x, y = total_ms, color = folder, group = folder)) +
  geom_line() +
  geom_point() +
  labs(
       x = "Size of J",
       y = "ms", color="Size of P") +

  theme_minimal() +
  theme(plot.title = element_text(hjust = 0.5),
    #
    # axis.title.x = element_text(size = 14),
    # axis.title.y = element_text(size = 14),
    # axis.text = element_text(size = 12),
    # legend.title = element_text(size = 14),
    # legend.text = element_text(size = 12),
    legend.position = c(0.95, 0.05),  # Position the legend at the bottom right
    legend.justification = c("right", "bottom")) +
  ylim(0, max(results$total_ms)) +
  scale_color_manual(values = c("p0" = "red", "p5" = "blue", "p10" = "green", "p15" = "purple", "p20" = "orange"),
                     labels = folder_labels)

ggsave("latency_no_verif_high_delay.eps", p, width = 6, height = 4, dpi = 300)


######### EXPENSIVE VERIFICATION

measurement  <- "run_eventlog_verif_long_delays/"
folders <- c("p0", "p5", "p10", "p15", "p20")

# Function to read a single CSV file and extract the required value
extract_value <- function(folder, filename) {
    file_path <- file.path(paste0(measurement, folder), filename)
    data <- tryCatch({
        read.csv(file_path)
      }, error = function(e) {
    message("Error reading file: ", file_path)
    message("Error: ", e)
    return(NULL)
    })
  
  if ( !is.null(data) && "gka and attest" %in% data$name) {
    value <- data[data$name == "gka and attest", "total_ns"]
    total_ms <- value / 1e6  # Convert from nanoseconds to milliseconds
    if(total_ms > 12000 ) { #higher values are possible here
        cat('OOB, ', folder, filename, '\n')
        return(NA)
    }
    return(total_ms)
    } else {
        cat('NA, ', folder, filename, '\n')
        return(NA)
  }
}

# Initialize an empty data frame to store the results
results <- data.frame(folder = character(), x = integer(), total_ms = numeric())

# Loop through the folders and files to extract the values
for (folder in folders) {
  for (x in 1:15) {
    filename <- paste0("result_", x, "_players_run_1.csv")
    total_ms <- extract_value(folder, filename)
    results <- rbind(results, data.frame(folder = folder, x = x, total_ms = total_ms))
  }
}

#order folders numerically 
results$folder <- factor(results$folder, levels = c("p0", "p5", "p10", "p15", "p20"))
folder_labels <- c("p0" = "0", "p5" = "5", "p10" = "10", "p15" = "15", "p20" = "20")

# Plot the results
p <- ggplot(results, aes(x = x, y = total_ms, color = folder, group = folder)) +
  geom_line() +
  geom_point() +
  labs(
       x = "Size of J",
       y = "ms", color="Size of P") +
  theme_minimal() +
  theme(
    legend.position = c(0.95, 0.05),  # Position the legend at the bottom right
    legend.justification = c("right", "bottom")) +
  ylim(0, max(results$total_ms)) +
  scale_color_manual(values = c("p0" = "red", "p5" = "blue", "p10" = "green", "p15" = "purple", "p20" = "orange"),
                     labels = folder_labels)

show(p)
ggsave("latency_verif_long_delays.eps", p, width = 6, height = 4, dpi = 300)

# GROUP KEY AGREEMENT LATENCY LOW

measurement  <- "run_no_verif_low_delays/"
folders <- c("p0", "p5", "p10", "p15", "p20")

# Function to read a single CSV file and extract the required value
extract_value <- function(folder, filename) {
    file_path <- file.path(paste0(measurement, folder), filename)
    data <- tryCatch({
        read.csv(file_path)
      }, error = function(e) {
    message("Error reading file: ", file_path)
    message("Error: ", e)
    return(NULL)
    })
  
  if ( !is.null(data) && "gka" %in% data$name) {
    value <- data[data$name == "gka", "total_ns"]
    total_ms <- value / 1e6  # Convert from nanoseconds to milliseconds
    if(total_ms > 2000 ) {
        cat('OOB, ', folder, filename, '\n')
        return(NA)
    }
    return(total_ms)
    } else {
        cat('NA, ', folder, filename, '\n')
        return(NA)
  }
}

# Initialize an empty data frame to store the results
results <- data.frame(folder = character(), x = integer(), total_ms = numeric())

# Loop through the folders and files to extract the values
for (folder in folders) {
  for (x in 1:15) {
    filename <- paste0("result_", x, "_players_run_1.csv")
    total_ms <- extract_value(folder, filename)
    results <- rbind(results, data.frame(folder = folder, x = x, total_ms = total_ms))
  }
}

#order folders numerically 
results$folder <- factor(results$folder, levels = c("p0", "p5", "p10", "p15", "p20"))
folder_labels <- c("p0" = "0", "p5" = "5", "p10" = "10", "p15" = "15", "p20" = "20")

# Plot the results
p <- ggplot(results, aes(x = x, y = total_ms, color = folder, group = folder)) +
  geom_line() +
  geom_point() +
  labs(
       x = "Size of J",
       y = "ms", color="Size of P") +

  theme_minimal() +
  theme(plot.title = element_text(hjust = 0.5),
    legend.position = c(0.95, 0.05),  # Position the legend at the bottom right
    legend.justification = c("right", "bottom")) +
  ylim(0, max(results$total_ms)) +
  scale_color_manual(values = c("p0" = "red", "p5" = "blue", "p10" = "green", "p15" = "purple", "p20" = "orange"),
                     labels = folder_labels)
show(p)

ggsave("latency_gka_no_verif_low_delay.eps", p, width = 6, height = 4, dpi = 300)

# GROUP KEY AGREEMENT LATENCY HIGH

measurement  <- "run_no_verif_high_delays/"
folders <- c("p0", "p5", "p10", "p15", "p20")

# Function to read a single CSV file and extract the required value
extract_value <- function(folder, filename) {
    file_path <- file.path(paste0(measurement, folder), filename)
    data <- tryCatch({
        read.csv(file_path)
      }, error = function(e) {
    message("Error reading file: ", file_path)
    message("Error: ", e)
    return(NULL)
    })
  
  if ( !is.null(data) && "gka" %in% data$name) {
    value <- data[data$name == "gka", "total_ns"]
    total_ms <- value / 1e6  # Convert from nanoseconds to milliseconds
    if(total_ms > 2000 ) {
        cat('OOB, ', folder, filename, '\n')
        return(NA)
    }
    return(total_ms)
    } else {
        cat('NA, ', folder, filename, '\n')
        return(NA)
  }
}

# Initialize an empty data frame to store the results
results <- data.frame(folder = character(), x = integer(), total_ms = numeric())

# Loop through the folders and files to extract the values
for (folder in folders) {
  for (x in 1:15) {
    filename <- paste0("result_", x, "_players_run_1.csv")
    total_ms <- extract_value(folder, filename)
    results <- rbind(results, data.frame(folder = folder, x = x, total_ms = total_ms))
  }
}

#order folders numerically 
results$folder <- factor(results$folder, levels = c("p0", "p5", "p10", "p15", "p20"))
folder_labels <- c("p0" = "0", "p5" = "5", "p10" = "10", "p15" = "15", "p20" = "20")

# Plot the results
p <- ggplot(results, aes(x = x, y = total_ms, color = folder, group = folder)) +
  geom_line() +
  geom_point() +
  labs(
       x = "Size of J",
       y = "ms", color="Size of P") +

  theme_minimal() +
  theme(plot.title = element_text(hjust = 0.5),
    legend.position = c(0.95, 0.05),  # Position the legend at the bottom right
    legend.justification = c("right", "bottom")) +
  ylim(0, 800) +
  scale_color_manual(values = c("p0" = "red", "p5" = "blue", "p10" = "green", "p15" = "purple", "p20" = "orange"),
                     labels = folder_labels)
show(p)

ggsave("latency_onlygka_no_verif_high_delay.eps", p, width = 6, height = 4, dpi = 300)

#### ONLY P=20 gka vs gka and attest -- HIGH latency

measurement  <- "run_no_verif_high_delays/"
folders <- c("p20")

extract_values <- function(folder, filename, row_name) {
    file_path <- file.path(paste0(measurement, folder), filename)
  data <- tryCatch({
    read.csv(file_path)
  }, error = function(e) {
    message("Error reading file: ", file_path)
    message("Error: ", e)
    return(NULL)
  })
  
  if (is.data.frame(data) && row_name %in% data$name) {
    value <- data[data$name == row_name, "total_ns"]
    return(value)
  } else {
    if (!is.null(data)) {
      message("File does not contain '", row_name, "': ", file_path)
    }
    return(NA)
  }
}

# Initialize empty data frames to store the results
results_gka_and_attest <- data.frame(folder = character(), x = integer(), total_ms = numeric())
results_gka <- data.frame(folder = character(), x = integer(), total_ms = numeric())

# Loop through the folders and files to extract the values
for (folder in folders) {
  for (x in 1:15) {
    filename <- paste0("result_", x, "_players_run_1.csv")
    total_ns_gka_and_attest <- extract_values(folder, filename, "gka and attest")
    total_ns_gka <- extract_values(folder, filename, "gka")
    
    if (!is.na(total_ns_gka_and_attest) && length(total_ns_gka_and_attest) == 1) {
      total_ms_gka_and_attest <- total_ns_gka_and_attest / 1e6  # Convert from nanoseconds to milliseconds
      if (total_ms_gka_and_attest <= 2000) {  # Disregard values greater than 2000 ms
        results_gka_and_attest <- rbind(results_gka_and_attest, data.frame(folder = folder, x = x, total_ms = total_ms_gka_and_attest))
      }
    }
    
    if (!is.na(total_ns_gka) && length(total_ns_gka) == 1) {
      total_ms_gka <- total_ns_gka / 1e6  # Convert from nanoseconds to milliseconds
      if (total_ms_gka <= 2000) {  # Disregard values greater than 2000 ms
        results_gka <- rbind(results_gka, data.frame(folder = folder, x = x, total_ms = total_ms_gka))
      }
    }
  }
}

# Convert 'folder' to a factor with specified levels to enforce order
results_gka_and_attest$folder <- factor(results_gka_and_attest$folder, levels = c("p0", "p5", "p10", "p15", "p20"))
results_gka$folder <- factor(results_gka$folder, levels = c("p0", "p5", "p10", "p15", "p20"))

# Map folder names to more meaningful legend labels
folder_labels <- c("p0" = "0", "p5" = "5", "p10" = "10", "p15" = "15", "p20" = "20")

# Plot the results
p  <- ggplot() +
  geom_line(data = results_gka_and_attest, aes(x = x, y = total_ms, color = folder, group = interaction(folder, "gka and attest")), linetype = "solid") +
  geom_point(data = results_gka_and_attest, aes(x = x, y = total_ms, color = folder, shape = "gka and attest"), size = 3) +
  geom_line(data = results_gka, aes(x = x, y = total_ms, color = folder, group = interaction(folder, "gka")), linetype = "dashed") +
  geom_point(data = results_gka, aes(x = x, y = total_ms, color = folder, shape = "gka"), size = 3) +
  scale_shape_manual(name = "Type", values = c("gka and attest" = 16, "gka" = 17)) +
  scale_color_manual(values = c("p0" = "red", "p5" = "blue", "p10" = "green", "p15" = "purple", "p20" = "orange"), labels = folder_labels) +
  labs(
       x = "Size of J",
       y = "ms",
       color = "Size of P") +
  theme_minimal() + 
  theme(
    legend.position = c(0.95, 0.05),  # Position the legend at the bottom right
    legend.justification = c("right", "bottom")
  ) +
  ylim(0, 1000)

ggsave("latency_gka_vs_attest_no_verif_high_delay_only_p20.eps", p, width = 6, height = 4, dpi = 300)

#### ONLY P=20 gka vs gka and attest -- LOW latency

measurement  <- "run_no_verif_low_delays/"
folders <- c("p0", "p5", "p10", "p15", "p20")

extract_values <- function(folder, filename, row_name) {
    file_path <- file.path(paste0(measurement, folder), filename)
  data <- tryCatch({
    read.csv(file_path)
  }, error = function(e) {
    message("Error reading file: ", file_path)
    message("Error: ", e)
    return(NULL)
  })
  
  if (is.data.frame(data) && row_name %in% data$name) {
    value <- data[data$name == row_name, "total_ns"]
    return(value)
  } else {
    if (!is.null(data)) {
      message("File does not contain '", row_name, "': ", file_path)
    }
    return(NA)
  }
}

# Initialize empty data frames to store the results
results_gka_and_attest <- data.frame(folder = character(), x = integer(), total_ms = numeric())
results_gka <- data.frame(folder = character(), x = integer(), total_ms = numeric())

# Loop through the folders and files to extract the values
for (folder in folders) {
  for (x in 1:15) {
    filename <- paste0("result_", x, "_players_run_1.csv")
    total_ns_gka_and_attest <- extract_values(folder, filename, "gka and attest")
    total_ns_gka <- extract_values(folder, filename, "gka")
    
    if (!is.na(total_ns_gka_and_attest) && length(total_ns_gka_and_attest) == 1) {
      total_ms_gka_and_attest <- total_ns_gka_and_attest / 1e6  # Convert from nanoseconds to milliseconds
      if (total_ms_gka_and_attest <= 2000) {  # Disregard values greater than 2000 ms
        results_gka_and_attest <- rbind(results_gka_and_attest, data.frame(folder = folder, x = x, total_ms = total_ms_gka_and_attest))
      }
    }
    
    if (!is.na(total_ns_gka) && length(total_ns_gka) == 1) {
      total_ms_gka <- total_ns_gka / 1e6  # Convert from nanoseconds to milliseconds
      if (total_ms_gka <= 2000) {  # Disregard values greater than 2000 ms
        results_gka <- rbind(results_gka, data.frame(folder = folder, x = x, total_ms = total_ms_gka))
      }
    }
  }
}

# Convert 'folder' to a factor with specified levels to enforce order
results_gka_and_attest$folder <- factor(results_gka_and_attest$folder, levels = c("p0", "p5", "p10", "p15", "p20"))
results_gka$folder <- factor(results_gka$folder, levels = c("p0", "p5", "p10", "p15", "p20"))

# Map folder names to more meaningful legend labels
folder_labels <- c("p0" = "0", "p5" = "5", "p10" = "10", "p15" = "15", "p20" = "20")

# Plot the results
p  <- ggplot() +
  geom_line(data = results_gka_and_attest, aes(x = x, y = total_ms, color = folder, group = interaction(folder, "gka and attest")), linetype = "solid") +
  geom_point(data = results_gka_and_attest, aes(x = x, y = total_ms, color = folder, shape = "gka and attest"), size = 3) +
  geom_line(data = results_gka, aes(x = x, y = total_ms, color = folder, group = interaction(folder, "gka")), linetype = "dashed") +
  geom_point(data = results_gka, aes(x = x, y = total_ms, color = folder, shape = "gka"), size = 3) +
  scale_shape_manual(name = "Type", values = c("gka and attest" = 16, "gka" = 17)) +
  scale_color_manual(values = c("p0" = "red", "p5" = "blue", "p10" = "green", "p15" = "purple", "p20" = "orange"), labels = folder_labels) +
  labs(
       x = "Size of J",
       y = "ms",
       color = "Size of P") +
  theme_minimal() 
  # theme(
  #   legend.position = c(0.95, 0.1),  # Position the legend at the bottom right
  #   legend.justification = c("right", "bottom")
  # )

show(p)

ggsave("latency_gka_vs_attest_no_verif_low_delay.eps", p, width = 6, height = 4, dpi = 300)
