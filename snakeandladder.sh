#!/bin/bash

echo "welcome to SNAKE & LADDER"
playerOnePosition=0;
playerTwoPosition=0;
playerOneMoves=0;
playerTwoMoves=0;

#who gets the first chance
player=$(($RANDOM%2+1))

ShowPlayer(){
    if [ $player -eq 1 ]
    then
        echo "player $player is playing."
    else
        echo "player $player is playing."
    fi
}
SwitchPlayer(){

    if [ $player -eq 1 ]
    then
        playerOneMoves=$(($playerOneMoves+$1))
        player=2;
    else
        playerTwoMoves=$(($playerTwoMoves+$1))
        player=1;
    fi
}
RollTheDice(){
    dice=$(($RANDOM%6+1)) 
}

while [ $playerOnePosition -le 100 ] && [ $playerTwoPosition -le 100 ]
do
    if [ $player -eq 1 ]
    then
        position=$playerOnePosition
        playerMoves=$playerOneMoves
    else
        position=$playerTwoPosition
        playerMoves=$playerTwoMoves
    fi

    CheckingForOptions(){
        option=$(($RANDOM%3))
        if [ $option -eq 0 ]
        then
            NoPlay
        elif [ $option -eq 1 ]
        then
            Ladder
        else
            Snake
        fi
    }
    NoPlay(){
        #Stay in the same position
        ShowPlayer
        echo "I'm not playing this move"
        playerMoves=$(($playerMoves+1))
        echo "Total moves so far: " $playerMoves
        SwitchPlayer $playerMoves
    }
    Ladder(){
        position=$(($position + $dice))
        if [ $position -gt 100 ]
        then
            #roll the dice again
            ShowPlayer
            echo "I don't have enough places to move.Roll the dice again."
            echo "....."
            playerMoves=$(($playerMoves+1))
            echo "Total moves so far: " $playerMoves
            SwitchPlayer $playerMoves
            RollTheDice
        else
            ShowPlayer
            position=$(($position + $dice))
            echo "you got ladder,your current position is.."
            echo "$position"
            playerMoves=$(($playerMoves+1))
            echo "Total moves so far: " $playerMoves
            SwitchPlayer $playerMoves
            RollTheDice
        fi
    }
    Snake(){
        #move behind
        ShowPlayer
        position=$(("$position" - "$dice"))
        if [ $position -lt 0 ]
        then
            position=0;
            echo "you can't move below zero."
            echo "Total moves so far: " $playerMoves
            SwitchPlayer $playerMoves
            RollTheDice
        else
            echo "you caught snake, your current position is..."
            echo "$positon"
            ((playerMoves++))
            echo "Total moves so far: " $playerMoves
            SwitchPlayer $playerMoves
            RollTheDice
        fi
    }
    RollTheDice
    CheckingForOptions
done