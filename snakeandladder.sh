#!/bin/bash

echo "welcome to SNAKE & LADDER"
position=0;
playcount=0;
RollTheDice(){
    dice=$(($RANDOM%6+1)) 
}
while [ position -le 100 ]
do
    CheckingForOptions(){
        option=$(($RANDOM%2))
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
        echo "You chose not to play this move"
    }
    Ladder(){
        if [ $(($position+$dice)) -gt 100 ]
        then
            #roll the dice again
            echo "you don't have enough places to move.Roll the dice again."
            echo "....."
            sleep 1
            ((playcount++))
            RollTheDice
        else
            position=$(($position+$dice))
            echo "you got ladder,your current position is.."
            echo "$position"
            ((playcount++))
            RollTheDice
        fi
    }
    Snake(){
        #move behind
        position=$(($position-$dice))
        if [ $position -lt 0 ]
        then
            position=0;
            echo "you can't move below zero."
            RollTheDice
        fi
        echo "you caught snake, your current position is..."
        echo "$positon"
        ((playcount++))
        RollTheDice
    }
done