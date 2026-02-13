#!/bin/bash
# Created by Antonio Giacchetti
# Last Update Jan 23 2025
# Description:
    # simulate Turin's 5th level "wombo combo"
    # Bonus Action: Hunter's Mark
    # Attack: Longbow shot + extra attack shot
    # prompt and apply colossus slayer

ac=$1
if [[ "$1" == "" ]]; then
    # get ac value
    read -p "Enter the target AC (numeric): " ac
fi

# if input is numeric
if [[ "$ac" =~ ^[0-9]+$ ]]; then
    echo "Applying Hunter's Mark and taking 2 shots..."
    # FIRST ATTACK ##########################
    attRoll1=$(shuf -i 1-20 -n 1) # roll 1d20
    attTotal1=$(($attRoll1+8)) # add modifier

    echo "Rolling to hit... $attRoll1 + 8 = $attTotal1"

    if [[ $attTotal1 -ge $ac ]]; then
        att1="true"
        echo "You hit!"

        damRoll1=$(shuf -i 1-8 -n 1)
        damRoll2=$(shuf -i 1-6 -n 1)
        damTotal1=$(($damRoll1+$damRoll2+3))
        
        echo "Rolling for damage... $damRoll1 + $damRoll2 + 3"
        echo ">>---> $damTotal1 Damage!"

    else
        att1="false"
        echo "You missed!"
    fi

    # SECOND ATTACK ##########################
    attRoll2=$(shuf -i 1-20 -n 1) # roll 1d20
    attTotal2=$(($attRoll2+8)) # add modifier

    echo "Rolling to hit... $attRoll2 + 8 = $attTotal2"

    if [[ $attTotal2 -ge $ac ]]; then
        att2="true"
        echo "You hit!"

        damRoll3=$(shuf -i 1-8 -n 1)
        damRoll4=$(shuf -i 1-6 -n 1)
        damTotal2=$(($damRoll3+$damRoll4+3))
        
        echo "Rolling for damage... $damRoll3 + $damRoll4 + 3"
        echo ">>---> $damTotal2 Damage!"

    else
        att2="false"
        echo "You missed!"
    fi

    # COLOSSUS ##########################
    if [[ "$att1" == "true" || "$att2" == "true" ]]; then
        read -p "Apply Colossus Slayer damage? [y/n] " colSlay
        if [ "$colSlay" == "n" ]; then
            roundTotal=$(($damTotal1+$damTotal2))
            echo "Round total:
>>---> $roundTotal damage! <---<<"
        elif [ "$colSlay" == "y" ]; then
            colRoll1=$(shuf -i 1-8 -n 1)
            echo "Rolling another d8... $colRoll1"
            roundTotal=$(($damTotal1+$damTotal2+$colRoll1))
            echo "Round total:
>>---> $roundTotal damage! <---<<"
        else
            echo "Invalid input. Exiting."
            exit 1
        fi
    else
        echo "You did 0 damage this round :("
    fi

# if input is not numeric, exit
else
    echo "Invalid input. Exiting."
    exit 1
fi

