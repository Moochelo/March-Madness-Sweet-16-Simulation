# NCAA March-Madness-Sweet-16-Simulation

## Project Title
**Predicting NCAA Tournament Outcomes with Team Efficiency Metrics**

## Author
**Michael Mucciolo**

---

## Overview
This project simulates the outcomes of the 2025 NCAA Men’s Sweet 16 tournament using team efficiency metrics. The model calculates win probabilities based on offensive and defensive efficiency, pace, three-point shooting, and other advanced metrics. 
Using these probabilities, the bracket is simulated 10,000 times to estimate each team’s likelihood of advancing to the Elite 8, Final Four, and winning the National Championship.
(10,000 times to see how randomness affects deeper rounds and how often each team advances overall; one simulation gives one outcome, while 10,000 simulations shows the distribution of outcomes).

The result of this analysis is a data-driven forecast presented visually in a grid-style plot with color-coded teams and advancement probabilities.

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

Team	   Conference	Champion Prob
Auburn	   SEC	      14.06%
Florida	   SEC	      10.79%
Alabama	   SEC	      8.94%
Tennessee   SEC	      5.82%
Kentucky	   SEC	      5.08%
Ole Miss	   SEC	      4.13%
Arkansas	   SEC	      2.05%

## SEC Total		   50.87%

Duke	      ACC	10.66%

ACC Total		   10.66%

M.State	   B10	3.90%
Maryland	   B10	4.90%
Purdue	   B10	4.05%
Michigan	   B10	3.27%

B10 Total		16.12%

Houston	   B12	10.19%
Texas Tech	B12	5.35%
Arizona	   B12	4.04%
BYU	      B12	2.77%

B12 Total		22.35%



## Audience and Application
This project is applicable to the following groups of people for the following reasons:
- **Sports Analysts**: Seeking insights on team advancement odds.
- **Bracketologists**: Looking for simulation-backed predictions to back their claims.
- **Fans**: Helping visualize their team's potential path to the championship.
- **Data Scientists**: Exploring how to apply logistic models in sports prediction.

---

## 

## How to Run

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

---

## Limitations & Future Directions
- **Randomness**: Results may vary slightly due to simulated randomness.
- **Injuries or late-season form**: Not accounted for.
- **Future Enhancements**:
  - Include seed information and team logos.
  - Build an interactive version using `shiny`.
  - Tune model weights using historical tournament outcomes.

---

## Acknowledgments
Inspired by the structure of sports prediction projects like the SEI x Phillies Hackathon. Credit to KenPom for efficiency metrics and the NCAA for tournament structure.

---

## Contact
For questions, reach out to **Michael Mucciolo** or connect on GitHub: [@Moochelo](https://github.com/Moochelo)

