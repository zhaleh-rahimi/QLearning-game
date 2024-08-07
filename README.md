## Game Nim
The game of Nim(N,m,k) involves m players who begin with a pile of N stones and
alternate turns, removing stones from the pile. Each player must remove between 1 and
k stones on their turn. The objective is to avoid taking the last stone. 
We will look at the case when N = 51, m = 2, and k = 3.
We have a small finite number of states(N+1 states) and action space only includes k actions {1,2,3}, that is the number of stones can be removed from the game.

## Configuration:
I trained the QLearner versus a Random player, 1e4 iterations.
With the following parameters:
N=51; k=3; m=2;
Discount= 0.99;
Alpha= 1/sqrt(n+2); n: #iterations
epsilon=1-(1/log(n+2))
Q-Learner always starts the game.
I tested the Q-Learner against a random player 1e3 times.
It wins around 99% of the times.

