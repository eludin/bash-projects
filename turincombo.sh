#!/bin/zsh
# Created by Eludin
# Last Update Feb 13 2026
# Description:
    # Simulate Turin's 9th level "wombo combo"
        # Bonus Action: Hunter's Mark
        # Attack Action: Bow of the Ram (2 shots)
        # On hit, prompt and apply colossus slayer
            # bonus is applied to a crit if present
# Notes:
    # could setup init vars that could be overwritten by args for:
        # attack bonus
        # damage bonus
            # these bonuses are currently hard-coded into the math for each roll

# if input is not numeric, exit
function is_int (){
    if [[ "$1" =~ ^-?[0-9]+$ ]]; then
        return 0  # True, it is an integer
    else
        return 1  # False, it is not an integer
        echo "Invalid input. Exiting."
        exit 1  
    fi
}

# COLOURS
RED=$'\033[0;31m'
GREEN=$'\033[0;32m'
YELLOW=$'\033[0;33m'
CYAN=$'\033[0;36m'
RESET=$'\033[0m'

# var inits
hit=0
critsniff=0
roundTotal=0
colTotal=0
damTotal=0
ac=$1
crit=20 # set crit target here if a feature lowers threshold

# if no arg is given, prompt for ac value
if [[ "$1" == "" ]]; then
	echo "Enter the target AC (numeric): "
    # get ac value
	read ac
fi
# check numeric
is_int $ac

# prompt for number of shots to take
echo "How many shots are you taking?"
read shots
# check numeric
is_int $shots
echo ""
echo -e "Applying Hunter's Mark and taking ${CYAN}$shots${RESET} shots..."
echo ""

# attack loop
for i in {1..$shots}; do
    attRoll=$(shuf -i 1-20 -n 1) # roll 1d20
    attTotal=$(($attRoll+10)) # add modifier
    echo -e ">>---> Shot $i: "
    echo -e "Rolling to hit... ${CYAN}$attRoll${RESET} + 10 = ${CYAN}$attTotal${RESET}"

    # if attack roll crits
    if [[ $attRoll -ge $crit ]]; then
        hit=1
        critsniff=1
        droll1=$(shuf -i 1-8 -n 1)
        droll2=$(shuf -i 1-8 -n 1)
        hmark1=$(shuf -i 1-6 -n 1)
        hmark2=$(shuf -i 1-6 -n 1)
        damTotal=$(($droll1+$hmark1+$droll2+$hmark2+5))
        echo -e "${GREEN}!! CRITICAL HIT !!${RESET}"
        echo -e "Rolling for damage... ${GREEN}$droll1${RESET} + ${GREEN}$droll2${RESET} + ${GREEN}$hmark1${RESET} + ${GREEN}$hmark2${RESET}"
        echo -e ">>---> ${GREEN}$damTotal Damage!${RESET} <---<<"

    # if attack roll hits (no crit)
    elif [[ $attRoll -lt $crit && $attTotal -ge $ac ]]; then
        hit=1
        droll=$(shuf -i 1-8 -n 1)
        hmark=$(shuf -i 1-6 -n 1)
        damTotal=$(($droll+$hmark+5))
        echo -e "${CYAN}You hit!${RESET}"
        echo -e "Rolling for damage... ${CYAN}$droll${RESET} + ${CYAN}$hmark${RESET} + 5"
        echo -e ">>---> ${CYAN}$damTotal${RESET} Damage!"
    
    # if attack roll misses
    else    
        damTotal=0
        echo -e "${RED}You missed! >>-/->${RESET}"
    fi
    echo ""
    roundTotal=$(($roundTotal+$damTotal))
done

# if any attack hits, prompt to apply colossus slayer
if [[ $hit == 1 ]]; then
    echo -e "Apply Colossus Slayer damage? [y/n] "
    read colSlay
    # if user inputs "y/Y"
    if [[ "$colSlay" == "y" || "$colSlay" == "Y" ]]; then
        # if crit was detected this round
        if [[ $critsniff -eq 1 ]]; then
            colRoll1=$(shuf -i 1-8 -n 1)
            colRoll2=$(shuf -i 1-8 -n 1)
            colTotal=$(($colRoll1+$colRoll2))
            echo -e "Rolling another 2d8... ${GREEN}$colRoll1${RESET} + ${GREEN}$colRoll2${RESET}"
        # if no crit was detected
        elif [[ $critsniff -ne 1 ]]; then
            colTotal=$(shuf -i 1-8 -n 1)
            echo -e "Rolling another d8... ${CYAN}$colTotal${RESET}"
        fi
    fi
fi

# round total
echo ""
roundTotal=$(($roundTotal+$colTotal))
# if damage was dealt
if [[ $roundTotal -gt 0 ]]; then
    echo -e "${CYAN}Round total:${RESET} >>---> ${GREEN}$roundTotal damage!${RESET} <---<<"
# if all attacks missed
else
    echo -e "You did ${RED}0${RESET} damage this round :("
fi
echo ""
