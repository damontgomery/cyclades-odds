# Cyclades Battle Odds Calculations
Cyclades is a board game where players attempt to control two cities. They can do this by building cities or conquering areas. The gameplay takes the form of bidding for actions, building buildings, and simplistic combat between small numbers of units.

## How combat works in Cyclades
In Cyclades, you resolve battles using a pair of dice. The attacker and defender each roll a special dice (faces 0, 1, 1, 2, 2, 3) and add the results to their number of units and buildings. If one side has a larger total, the other loses a unit. If there is a tie, both lose 1. This is repeated until troops retreat or one side is eliminated. In the case where all troops are eliminated, the defender maintains control.

## How to use this program
ruby odds.rb > results.htm

## Findings
Discussed at [http://boardgamegeek.com/article/18016625](http://boardgamegeek.com/article/18016625).

The unique die means that more or less, if you attack with equal forces, you have a 50% chance of winning. If you attack with 1 more, you have a 90% chance of winning. If you attack with 2 more, you are more or less guarenteed to win.

This is pretty cool for such a simple system. The results are very simple to remember and let you make interesting decisions about what you will do without too much randomness.

## What is missing?
The odds slightly change when you take into consideration how buildings function. This simulation does not do this, but the odds have been calculated and discussed on BGG linked above.