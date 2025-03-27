#NCAA March-Madness-Sweet-16-Simulation

## Project Title
**Predicting NCAA Tournament Outcomes with Team Efficiency Metrics**

## Author
**Michael Mucciolo**

---

## Overview
This project simulates the outcomes of the 2025 NCAA Men’s Sweet 16 tournament using team efficiency metrics. The model calculates win probabilities based on offensive and defensive efficiency, pace, three-point shooting, and other advanced metrics. 
Using these probabilities, the bracket is simulated 10,000 times to estimate each team’s likelihood of advancing to the Elite 8, Final Four, and winning the National Championship.

The result is a data-driven forecast presented visually in a grid-style plot with color-coded teams and advancement probabilities.

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

## Methodology

### 1. **Win Probability Function**
A custom logistic model was created using a weighted sum of stat differences between teams. Higher weights were assigned to ORtg, DRtg, and 3PT%, given their strong correlation with game outcomes. The logistic function returns a probability of team A beating team B.

### 2. **Tournament Simulation**
Using real Sweet 16 matchups, we simulate the full tournament 10,000 times:
- Each round is simulated by pairing teams and determining a winner using the win probability function.
- Teams that advance are counted for each round.
- At the end of the simulation, counts are converted into probabilities (e.g., "Team A reached the Final Four in 28.7% of simulations").

### 3. **Bracket Visualization**
We generate a custom bracket-style plot using `ggplot2`:
- Teams are shown at each round they could reach (Sweet 16 to Champion).
- Probabilities of advancement are displayed as percentages.
- Color-coded by team for visual clarity.
- Top 4 teams in each round are highlighted with bold borders and text.

---

## Use Cases and Audience
This project is ideal for:
- **Sports Analysts**: Seeking insights on team advancement odds.
- **Bracketologists**: Looking for simulation-backed predictions.
- **Fans**: Visualizing their team's potential path.
- **Data Scientists**: Exploring how to apply logistic models in sports prediction.

---

## How to Run

### Requirements
- R
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

