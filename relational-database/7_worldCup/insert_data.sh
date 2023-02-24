#! /bin/bash

if [[ $1 == "test" ]]
then
  PSQL="psql --username=postgres --dbname=worldcuptest -t --no-align -c"
else
  PSQL="psql --username=freecodecamp --dbname=worldcup -t --no-align -c"
fi

# Do not change code above this line. Use the PSQL variable above to query your database.

# Clean all the tables before adding data:
echo $($PSQL "TRUNCATE teams, games")

# Read games csv and assign the variables:
cat games.csv | while IFS="," read YEAR ROUND WINNER OPPONENT WINNER_GOALS OPPONENT_GOALS

do
  if [[ $YEAR != "year" ]]
    then
    WINNER_ID=$($PSQL "SELECT team_id FROM teams WHERE name = '$WINNER'")
    # If winner not found
    if [[ -z $WINNER_ID ]]
      then
      INSERT_WINNER=$($PSQL "INSERT INTO teams(name) VALUES('$WINNER')")
        # Print insert
        if [[ $INSERT_WINNER == "INSERT 0 1" ]]
          then
          echo Inserted winner $WINNER into teams.
        fi
    fi
    OPPONENT_ID=$($PSQL "SELECT team_id FROM teams WHERE name = '$OPPONENT'")
    # If winner not found
    if [[ -z $OPPONENT_ID ]]
      then
      INSERT_OPPONENT=$($PSQL "INSERT INTO teams(name) VALUES('$OPPONENT')")
        # Print insert
        if [[ $INSERT_OPPONENT == "INSERT 0 1" ]]
          then
          echo Inserted opponent $OPPONENT into teams.
        fi
    fi
  fi
done

cat games.csv | while IFS="," read YEAR ROUND WINNER OPPONENT WINNER_GOALS OPPONENT_GOALS
do
  if [[ $YEAR != "year" ]]
    then
    # Get the winner ID and Opponent ID 
    GAME_WINNER_ID=$($PSQL "SELECT team_id FROM teams WHERE name = '$WINNER'")
    GAME_OPPONENT_ID=$($PSQL "SELECT team_id FROM teams WHERE name = '$OPPONENT'")
    # Insert the games
    INSERT_GAME=$($PSQL "INSERT INTO games(year, round, winner_id, opponent_id, winner_goals, opponent_goals) 
    VALUES($YEAR, '$ROUND', $GAME_WINNER_ID, $GAME_OPPONENT_ID, $WINNER_GOALS, $OPPONENT_GOALS)")
      if [[ $INSERT_GAME == "INSERT 0 1" ]]
        then
        # Print a nice receipt
        echo Inserted game $YEAR $ROUND $WINNER $WINNER_GOALS - $OPPONENT $OPPONENT_GOALS into games.
      fi
  fi
done