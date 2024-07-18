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
  labs(title = "LCMsec GKA and Attestation, small delays",
       x = "Size of J",
       y = "ms", color="Size of P") +
  theme_minimal() +
  theme(plot.title = element_text(hjust = 0.5)) +
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
  labs(title = "LCMsec GKA and Attestation, small delays",
       x = "Size of J",
       y = "ms", color="Size of P") +
  theme_minimal() +
  theme(plot.title = element_text(hjust = 0.5)) +
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
  labs(title = "LCMsec GKA and Attestation with Eventlog Verification",
       x = "Size of J",
       y = "ms", color="Size of P") +
  theme_minimal() +
  theme(plot.title = element_text(hjust = 0.5)) +
  ylim(0, max(results$total_ms)) +
  scale_color_manual(values = c("p0" = "red", "p5" = "blue", "p10" = "green", "p15" = "purple", "p20" = "orange"),
                     labels = folder_labels)

show(p)

ggsave("latency_verif_long_delays.eps", p, width = 6, height = 4, dpi = 300)
