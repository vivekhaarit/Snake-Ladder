#!/bin/bash

echo "*******WELCOME TO LUDO**********"
echo ""
STARTING_POSITION=0
ENDING_POSITION=100
player_currentPosition=$STARTING_POSITION
player_moves=0
flag="true"

echo "Enter the First player name"
read player1
echo "Enter the Second player name"
read player2
echo "----------------------------"
echo "player1 :"$player1
echo "player2 :"$player2
echo "----------------------------"

function positionCheck(){
	if (( $player_currentPosition < $STARTING_POSITION))
	then
		player_currentPosition=0
		echo "You're at: " $player_currentPosition
	elif (( $player_currentPosition > $ENDING_POSITION))
	then
		player_currentPosition=$(($player_currentPosition-$dice))
		echo "You're at: "$player_currentPosition
	else
		echo "You're at: "$player_currentPosition
	fi
}

function diceRoll(){
	echo "press any key to roll a dice"
	read presskey
	dice=$((1+RANDOM%6))
	echo "...ROLLING.........You Got: "$dice
	scenario=$((1+RANDOM%3))
	case $scenario in
			 1)
			echo "You choose to stay in same position"
			echo "-----------------------------------"
			player_currentPosition=$player_currentPosition
			;;
			 2)
			echo "You got ladder.."
			player_currentPosition=$(($player_currentPosition+$dice))
			positionCheck
			echo "-----------------------------------"
			;;
			 3)
			echo "...Snake...."
			player_currentPosition=$(($player_currentPosition-$dice))
			positionCheck
			echo "-----------------------------------"
			;;
	esac
	player_moves=$(($player_moves+1))
}


while [[ $flag -eq "true" ]]
do
	echo "$player1 turn's"
	diceRoll
	if (( $player_currentPosition == $ENDING_POSITION))
		then
		echo "Total number of times dice throw to finish the game= "$player_moves
		echo "yeah $player1 I won....."
		flag="false"
		break
	fi

	echo "$player2 turn's"
	diceRoll
	if (( $player_currentPosition == $ENDING_POSITION))
	then
		echo "Total number of times dice throw to finish the game= "$player_moves
		echo "yeah $player2 I won....."
		flag="false"
		break
	fi

done



