# NCAA March-Madness-Sweet-16-Simulation

The goal of this project was to build a data-driven simulation model to estimate each team’s probability of advancing through the NCAA Men’s Sweet 16 and winning the national championship by using advanced team metrics.

***
## Author
***
**Michael Mucciolo**
***
## Project Title 

**Predicting NCAA Tournament Outcomes with Team Efficiency Metrics**

---

## Overview
This project simulates the outcomes of the 2025 NCAA Men’s Sweet 16 tournament using team efficiency metrics. The model calculates win probabilities based on offensive and defensive efficiency, pace, three-point shooting, and other advanced metrics. 
Using these probabilities, the bracket is simulated 10,000 times to estimate each team’s likelihood of advancing to the Elite 8, Final Four, and winning the National Championship.
(10,000 times to see how randomness affects deeper rounds and how often each team advances overall; one simulation gives one outcome, while 10,000 simulations shows the distribution of outcomes).

The result of this analysis is a data-driven forecast presented visually in a grid-style plot with color-coded teams and advancement probabilities.

---

## Audience and Application
This project is applicable to the following groups of people for the following reasons:
- **Sports Analysts**: Seeking insights on team advancement odds.
- **Bracketologists**: Looking for simulation-backed predictions to back their claims.
- **Fans**: Helping visualize their team's potential path to the championship.
- **Data Scientists**: Exploring how to apply logistic models in sports prediction.

---


## Dataset
The dataset used (`Full_Sweet_16_Stats.xlsx`) includes the following columns for each of the 16 teams:
- **Team Name**
- **Offensive Rating (ORtg)**
- **Defensive Rating (DRtg)**
- **Adjusted Tempo (AdjT)**
- **Luck**
- **Strength of Schedule (SoS_NetRtg)**
- **Opponent ORtg/DRtg**
- **Three Point Percentage**
Variables also in the dataset (but not utilized)
- **Rank** (via Kenpom.com)
- **Region**
- **Conference** 

These statistics were sourced from both KenPom.com and NCAA.com

---

## Exploratory Data Analysis/Conference Likelihood to Win the Championship

The tournament field was analyzed by conference to evaluate each conference's theoretical chance of winning the championship based solely on the number of teams they had remaining in the Sweet 16.

SEC (7 Teams):
- Florida
- Auburn
- Tennessee
- Alabama
- Kentucky
- Ole Miss
- Arkansas

ACC (1 Team):
- Duke

B10 (4 Teams):
- Michigan State
- Maryland
- Purdue
- Michigan
  
B12 (4 Teams):
- Houston
- Texas Tech
- Arizona
- BYU

At a conceptual level: 

SEC = 7/16 = 43.75%

ACC = 1/16 = 6.25%

B10 = 4/16 = 25.00%

B12 = 4/16 = 25.00%

## Methodology

### 1. **Win Probability Function**
A custom logistic model was developed to estimate the probability that one team will beat another based on the weighted differences in their key performance metrics. The most heavily weighted variables were Offensive Rating (ORtg), Defensive Rating (DRtg), and Three-Point Percentage, as these are strongly correlated with scoring efficiency, shot value, and the ability to prevent points.

Three-point percentage was given particular emphasis alongside ORtg and DRtg due to its increased usage and strategic importance in modern basketball—as a higher-value shot, teams that shoot well from deep often have a significant advantage.

Strength of Schedule (SoS_NetRtg) and Opponent Offensive/Defensive Ratings were incorporated to contextualize team performance against the caliber of their competition. Adjusted Tempo (AdjT) and Luck were given lighter weights as secondary influencers; while they affect variance and playing style, they do not directly determine head-to-head superiority.

The weights reflect a balance of basketball reasoning and exploratory testing, aimed at capturing both skill and context. The logistic function transforms the weighted stat differential into a probability between 0 and 1 that team A will defeat team B.

### 2. **Tournament Simulation**
Using real Sweet 16 matchups, the full tournament was simulated 10,000 times:
- Each round is simulated by pairing teams and determining a winner using the win probability function.
- Teams that advance are counted for each round.
- At the end of the simulation, counts are converted into probabilities (for example, "Arkansas reached the Final Four in 6% of simulations").

### 3. **Bracket Visualization**
A custom bracket-style plot using `ggplot2` was generated:
- Teams are shown at each round they could advance from Sweet 16 to champion.
- Probabilities of advancement are displayed as percentages.
- Color-coded by team for visual clarity.
- Top 4 teams in each round are highlighted with bold borders and text.

---

## Tournament Simulation: Conference and Team-Level Odds to Win the Championship


![image](https://github.com/user-attachments/assets/e1a5c178-9919-4653-a3d4-57fe8ce37ac0)



![image](https://github.com/user-attachments/assets/e78fa87c-bde1-4fc6-b0f7-a058b90e92f3)



![image](https://github.com/user-attachments/assets/a2cdb3d7-df92-4a91-89a8-bac41dc5c661)


![image](https://github.com/user-attachments/assets/b6c1b08f-2d87-4d36-ae72-e8224c32effb)


After comparing each conference’s theoretical championship odds (based purely on the number of teams in the Sweet 16) with the model-based probabilities, several key insights emerge:

- **SEC**: The model projects a 7.12% boost over the SEC’s theoretical odds. This is largely driven by the strong title chances of Florida (10.79%) and Auburn (14.06%), two of the top three contenders overall. Alabama also contributes significantly at 8.94%, reinforcing the SEC’s dominance.

- **ACC**: Despite having only one team remaining, the ACC sees a +4.41% increase in projected title odds. This is due to Duke’s high probability (10.66%), placing them firmly among the tournament’s elite contenders.

- **Big Ten (B10)**: The Big Ten underperforms relative to expectation, with a -8.88% drop from its theoretical share. Although the conference has four teams in the Sweet 16, none are viewed by the model as top-tier threats — each has just a 3–4% chance of winning it all.

- **Big 12 (B12)**: The model assigns the Big 12 a slight underperformance of -2.65% compared to their theoretical odds. While Houston is a strong contender (10.19% champion odds via the model), the other three teams (Texas Tech, Arizona, BYU) are less favored, each falling between 2% and 6%.

![image](https://github.com/user-attachments/assets/3bf848ee-82d7-49ef-8c5f-7690eda0aa10)

![image](https://github.com/user-attachments/assets/fb3b7d56-6b38-4a3f-96d3-2e18c20565a8)
---
## Limitations and Future Directions

The following limitations within the model/data include:

### 1. **Static Team Strength Assumptions**
- The model assumes each team’s strength (based on KenPom-style efficiency metrics) is fixed.
- It doesn’t account for recent injuries, momentum, or matchup-specific dynamics (home court location) that could shift probabilities.

### 2. **Simplified Matchups**
- Simulations assume matchups are independent and based only on weighted efficiency stats.
- Factors like coaching, playing style, or historical head-to-head performance aren't included.

### 3. **Randomness and Sample Size**
- While 10,000 simulations offer stability, some randomness still persists — especially for lower-probability teams.
- Results may vary if weights/variables change; the weights used in the win probability function were based on basketball logic and exploratory testing, but they weren’t optimized using machine learning or cross-validation..

Future directions that can be taken for an analysis similar to this include:

### 1. **Using Historical Tournament Data to Train a Machine Learning Model**
- Models can be trained on past NCAA tournaments to better predict outcomes using not just team stats, but seed, region, historical performance, and coaching experience.

### 3. **Dynamic Bracket Updating**
- Creating a live model that updates probabilities round-by-round as games are played and upsets occur would be very interactive and more in-the-moment.

### 4. **Optimization of Model Weights**
- Instead of manually choosing weights, using a logistic regression or grid search to optimize feature weights based on past game results could prove helpful in an analysis similar to this.

### 5. **Simulating Individual Matchups**
- Including variables like defensive matchups, three-point variance, turnover margin, and player-specific statistics could prove to be very useful to analyze how impactful each detail is for a team.

---


## Conclusion

This project leveraged team efficiency metrics and logistic modeling to simulate the 2025 NCAA Men's March Madness (from the round of the Sweet 16) tournament 10,000 times, producing a data-driven prediction for each team’s likelihood of advancing through the bracket. By combining advanced stats like offensive and defensive ratings, tempo, and strength of schedule, the model offered a more detail-oriented perspective on tournament outcomes than traditional bracket picks.

The analysis revealed key insights at both the team and conference level — highlighting not just which teams are most likely to win it all, but also how conferences like the SEC and ACC have outperformed relative to expectations based on team count alone. Florida, Auburn, Duke, and Houston emerged as leading contenders, while other conferences see their championship hopes spread thinly across multiple lower-probability teams.

The interactive bracket visualization enhances interpretability, allowing fans and analysts alike to trace the statistical path each team would need to take to win the championship. This kind of simulation-based forecasting brings together sports analytics, probability theory, and data visualization in a way that’s accessible, predictive, and engaging.

Ultimately, while no model can fully capture the chaos and unpredictability that defines March Madness (and the odds of making a perfect bracket are definitely stacked against you) this approach offers a meaningful, data-driven perspective on how team strength and key performance metrics shape the path to a national championship.


---

## References
 https://kenpom.com/ 
 https://www.ncaa.com/stats/basketball-men/d1/current/team/152

## Instructions for User Implementation

### Requirements
- RStudio
- Required packages: `readxl`, `dplyr`, `tidyr`, `ggplot2`

### Steps
1. Place `Full_Sweet_16_Stats.xlsx` in your working directory.
2. Run the R script provided in this repo.
3. The script will:
   - Read the data
   - Simulate the tournament 10,000 times
   - Create a `results` table with advancement probabilities
   - Plot the custom NCAA bracket using `ggplot2`
### Code:
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


---
