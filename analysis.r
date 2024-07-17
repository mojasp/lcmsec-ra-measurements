players  <-  35
runsperplayer <- 50

#run following bash command to ensure good data (i.e., in the run all consensus phases resulted in successful key computation)
    # for ((i = 1 ; i < 21 ; i++)); do
    #         echo "$i:\n" && grep "gkexchg_success" last_run/result_${i}_* | wc
    # done
# actually seems i need to rerun 17&19&20; most likely i was overloading the cpu at the time with other tasks

require(data.table)
require(ggplot2)
# library(vioplot)
# library(gridExtra)
# library(cowplot)

d2  <- data.table()
for (i in 1:players) {
    col <- c()
    for (j in 1:runsperplayer) {
        filename <- paste("full_run_delays/result_", i, "_players_run_", j, ".csv", sep = "")
        # filename <- paste("tracy_run_20230223_091300/result_", i, "_players_run_", j, ".csv", sep = "")
        r <- read.csv(filename)
        r <- as.data.table(r)
        jrcount <- r[r$name=="on_JOIN_response"]
        jrcount <- jrcount$counts
        # cat("p: ", i,", r: ", j, ", c:", jrcount, "\n")
        col <- c(col, jrcount)
        print(paste("i=", i, "j=",j))
        print(jrcount)
    }
    print (length(col))
    d2[, as.character(i) :=  col]
}

#melt into long fmt
dt_long <- melt(d2, variable.name = "players", value.name = "count")
dt_long[, joins := as.numeric(players)* 2] #we know a priori that there are always two JOINS per player - one for each channel

#  # Calculate the average count for each number of players
# mean_dt <- dt_long[, .(Avg_count = mean(Count)), by = Num_players]

# #errorbar assuming normal distribution
# ggplot(dt_long, aes(x = players, y = count)) + 
#   stat_summary(fun.data = mean_sdl, geom = "errorbar") +
#   geom_point()+ 
#   labs(x = "Number of players", y = "Observed JOIN_Responses")

# # violin plot
# vioplot(dt_long$count ~ dt_long$players,
#         xlab = "Number of Players",
#         ylab = "Count",
#         main = "Count vs. Number of Players",
#         col = "lightblue")


#boxplot seems nicest for the usecase
p <- ggplot(data=dt_long, aes(x=players), text = element_text(family = "Times New Roman") )+
  geom_boxplot( aes(y=count, colour="JOIN_Responses")) +
  geom_point(aes(y = joins,colour="JOINs")) + 
  scale_colour_manual("", 
                      breaks = c("JOINs", "JOIN_Responses"),
                      values = c("brown", "blue")) +
  theme( legend.title=element_blank()) +
  theme(
    legend.position=c(0.15, 0.85),
    # legend.text=element_text(size=12)
    )+
  labs(x = "|J|", y = "count")
show(p)

ggsave("consensus_initial_delay.eps", p, width = 6, height = 4, dpi = 300)
