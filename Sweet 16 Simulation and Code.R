# --------------------------------------------------
# NCAA Sweet 16 Tournament Simulation & Bracket Plot
# --------------------------------------------------

# Loading Required Libraries
library(readxl)
library(dplyr)
library(tidyr)
library(ggplot2)

# Loading the dataset
df <- read_excel("Full_Sweet_16_Stats.xlsx")
df$Team <- trimws(df$Team)

# Defining Sweet 16 matchups
sweet16_matchups <- list(
  c("Auburn", "Michigan"),
  c("Ole Miss", "Michigan State"),
  c("Florida", "Maryland"),
  c("Texas Tech", "Arkansas"),
  c("Duke", "Arizona"),
  c("BYU", "Alabama"),
  c("Houston", "Purdue"),
  c("Kentucky", "Tennessee")
)

#Defining win probability function
win_probability <- function(team1, team2, df) {
  t1 <- df %>% filter(Team == team1)
  t2 <- df %>% filter(Team == team2)
  
  features <- c("ORtg", "DRtg", "AdjT", "Luck", 
                "SoS_NetRtg", "ORtg_Opp", "DRtg_Opp", "Three PT %")
  # Offensive rating, defensive rating, and three-point percentage were chosen 
  # to be the most heavily weighted variables due to the strong direct correlation 
  # with a team's ability to score efficiently, prevent scoring, and capitalize on high-value shots 
  #(a three-pointer is worth more than a two-pointer and the shot has become increasingly popular over the years).
  # Strength of schedule (SoS_NetRtg) and opponent offensive/defensive metrics were included 
  # to account for the quality of competition faced. Tempo/pace (AdjT) and Luck were lightly weighted 
  # as secondary influencers that may explain variance but don't directly determine head-to-head outcomes.
  # The weights reflect a blend of basketball logic and exploratory testing to balance offensive/defensive power 
  # with contextual factors like competition and shooting efficiency.
  weights  <- c(0.20, -0.20, 0.05, 0.05, 0.10, 0.05, -0.05, 0.15)
  
  #Calculating the weighted difference
  diff <- sum(mapply(function(f, w) w * (t1[[f]] - t2[[f]]), features, weights))
  #Converting to probability using logistic function
  prob <- 1 / (1 + exp(-diff / 5))
  return(prob)
}

#Defining the single game simulation function
simulate_game <- function(team1, team2, df) {
  prob <- win_probability(team1, team2, df)
  winner <- ifelse(runif(1) < prob, team1, team2)
  return(winner)
}

# Initializing results table
#Tracks how many times each team reaches each round
results <- data.frame(
  Team = df$Team,
  Elite8 = 0,
  FinalFour = 0,
  Championship = 0,
  Champion = 0
)

#Simulating the Tournament 10,000 Times 
#(10,000 to see how randomness affects deeper rounds and how often each team advances overall)
#One simulation gives one outcome, while 10,000 simulations shows the distribution of outcomes.
set.seed(42)
n_sims <- 10000


for (i in 1:n_sims) {
  r16 <- sapply(sweet16_matchups, function(m) simulate_game(m[1], m[2], df))
  
  #Odds to advance to Elite 8
  e8 <- c(
    simulate_game(r16[1], r16[2], df),
    simulate_game(r16[3], r16[4], df),
    simulate_game(r16[5], r16[6], df),
    simulate_game(r16[7], r16[8], df)
  )
  results$Elite8[results$Team %in% e8] <- results$Elite8[results$Team %in% e8] + 1
  
  #Odds to advance to Final 4
  f4 <- c(
    simulate_game(e8[1], e8[2], df),
    simulate_game(e8[3], e8[4], df)
  )
  results$FinalFour[results$Team %in% f4] <- results$FinalFour[results$Team %in% f4] + 1
  
  #Odds to advance to Championship
  results$Championship[results$Team %in% f4] <- results$Championship[results$Team %in% f4] + 1
  
  #Odds to win Championship
  champ <- simulate_game(f4[1], f4[2], df)
  results$Champion[results$Team == champ] <- results$Champion[results$Team == champ] + 1
}

# Normalizing results (Converting Counts to Probabilities)
results <- results %>%
  mutate(across(Elite8:Champion, ~ .x / n_sims)) %>%
  arrange(desc(Champion))

# Defining unique team colors
team_color_map <- c(
  "Auburn" = "#03244D", "Florida" = "#FA4616",
  "Houston" = "#C8102E", "Duke" = "#00539B",
  "Tennessee" = "#D35400", "Alabama" = "#7C0A02",
  "Texas Tech" = "#FF6F61", "Maryland" = "#FFD700",
  "Arizona" = "#E34234", "Kentucky" = "#89CFF0",
  "Purdue" = "#DAA520", "Michigan" = "#006400",
  "BYU" = "#4682B4", "Arkansas" = "#A12312",
  "Ole Miss" = "#708090", "Michigan State" = "#228B22"
)

# Preparing data for plotting (Reshaping Results to Long Format)
bracket_long <- results %>%
  pivot_longer(cols = c(Elite8, FinalFour, Championship, Champion),
               names_to = "Round", values_to = "Probability") %>%
  mutate(
    x = case_when(
      Round == "Elite8" ~ 2,
      Round == "FinalFour" ~ 3,
      Round == "Championship" ~ 4,
      Round == "Champion" ~ 5
    )
  )

#Adding Sweet 16 Round for Visual Layout Only (no percentages as all teams are already at this point)
sweet16_layer <- data.frame(
  Team = results$Team,
  Round = "Sweet16",
  Probability = NA,
  x = 1,
  y = 1:16,
  Top4 = FALSE
)

#Adding y-axis positions and flag Top 4 Teams per Round
#(top 4 teams per round marked with bolded text and bold borders)
bracket_long <- bracket_long %>%
  group_by(Round) %>%
  arrange(desc(Probability)) %>%
  mutate(y = row_number(), Top4 = rank(-Probability) <= 4) %>%
  ungroup()

#Combining Bracket Data
bracket_long <- bind_rows(bracket_long, sweet16_layer)

#Highlight top 4 teams per round
#(again, top 4 teams per round marked with bolded text and bold borders)
ggplot() +
  geom_tile(data = bracket_long,
            aes(x = x, y = y, fill = Team),
            color = "black", width = 0.9, height = 0.9, alpha = 0.95) +
  geom_tile(data = bracket_long %>% filter(Top4 == TRUE),
            aes(x = x, y = y),
            fill = NA, color = "black", linewidth = 1.8, width = 0.9, height = 0.9) +
  #Plotting team name and percentage for advancement to particular round
  geom_text(data = bracket_long,
            aes(x = x, y = y,
                label = ifelse(Round == "Sweet16", Team,
                               paste0(Team, "\n", round(Probability * 100), "%")),
                fontface = ifelse(Top4, "bold", "plain")),
            size = 3.2, color = "white") +
  #Applying custom team colors
  scale_fill_manual(values = team_color_map) +
  scale_x_continuous(
    breaks = 1:5,
    labels = c("Sweet 16", "Elite 8", "Final Four", "Championship", "Champion"),
    expand = expansion(mult = c(0.05, 0.05))
  ) +
  theme_minimal(base_size = 16) +
  theme(
    axis.text.y = element_blank(),
    axis.ticks.y = element_blank(),
    panel.grid = element_blank(),
    axis.title = element_blank(),
    legend.position = "none",
    plot.title = element_text(face = "bold", hjust = 0.5),
    plot.background = element_rect(fill = "white", color = NA),
    panel.background = element_rect(fill = "white", color = NA)
  ) +
  labs(title = "🏀 NCAA Tournament Bracket — Advancement Probabilities 🏀")