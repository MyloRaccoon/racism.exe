#!/bin/bash

width=50
height=20

score=0

playerX=1
playerY=1
playerChar="O"

enemyX=$((width-2))
enemyY=$((height-2))
enemyChar="X"
enemyMaxSpeed=2
enemySpeed=$(echo $enemyMaxSpeed)

coinX=5
coinY=5
coinChar="$"

wallChar="0"
emptyChar=" "

playing=true

randint() {
    local min=$1
    local max=$2

    echo $((RANDOM % (max - min + 1) + min))
}

abs() {
    local num=$1
    if (( num < 0 )); then
        echo $(( -num ))
    else
        echo $num
    fi
}

moveEntityUp() {
	local -n entityYRef=$1

    if [[ $entityYRef -gt 1 ]]; then
        entityYRef=$((entityYRef - 1))
    fi
}

moveEntityDown() {
	local -n entityYRef=$1

    if [[ $entityYRef -lt $((height-2)) ]]; then
        entityYRef=$((entityYRef + 1))
    fi
}

moveEntityRight() {
	local -n entityXRef=$1

    if [[ $entityXRef -lt $((width-2)) ]]; then
        entityXRef=$((entityXRef + 1))
    fi
}

moveEntityLeft() {
	local -n entityXRef=$1

    if [[ $entityXRef -gt 1 ]]; then
        entityXRef=$((entityXRef - 1))
    fi
}

setCoinPos() {
	coinX=$(randint 1 $((width-2)))
	coinY=$(randint 1 $((height-2)))
}

coinProcess() {
	if [[ $playerX -eq $coinX && $playerY -eq $coinY ]]; then
		score=$((score + 1))
		setCoinPos
	fi
}

enemyMove() {
	distX=$1
	distY=$2
	if [[ $distX -lt $distY ]]; then
		if [[ playerY -lt enemyY ]]; then
			moveEntityUp enemyY
		else
			moveEntityDown enemyY
		fi
	else
		if [[ playerX -gt enemyX ]]; then
			moveEntityRight enemyX
		else
			moveEntityLeft enemyX
		fi
	fi
}

enemyProcess() {
	local distX=$(abs $((playerX - enemyX)))
	local distY=$(abs $((playerY - enemyY)))

	enemySpeed=$((enemySpeed - 1))
	if [[ $enemySpeed -eq 0 ]]; then
		enemySpeed=$(echo $enemyMaxSpeed)
		enemyMove $distX $distY
	fi

	if [[ $distX -lt 2 && $distY -lt 2 ]]; then
		playing=false
	fi
}

printBoard() {
    for ((i=0; i<height; i++)); do
        local line=""
        for ((j=0; j<width; j++)); do
            if [[ $j -eq 0 || $i -eq 0 || $j -eq $((width-1)) || $i -eq $((height-1)) ]]; then
                line="${line}${wallChar}"
            elif [[ $j -eq $playerX && $i -eq $playerY ]]; then
                line="${line}${playerChar}"
            elif [[ $j -eq $enemyX && $i -eq $enemyY ]]; then
                line="${line}${enemyChar}"
            elif [[ $j -eq $coinX && $i -eq $coinY ]]; then
            	line="${line}${coinChar}"
            else
                line="${line}${emptyChar}"
            fi
        done
        echo "$line"
    done
}

playerPlay() {
	read command
	if [[ $command == 'z' ]]; then
		moveEntityUp playerY
	elif [[ $command == 's' ]]; then
		moveEntityDown playerY
	elif [[ $command == 'd' ]]; then
		moveEntityRight playerX
	elif [[ $command == 'q' ]]; then
		moveEntityLeft playerX
	elif [[ $command == 'e' ]]; then
		playing=false
	fi
}

setCoinPos
while [ "$playing" == true ]; do
	clear
	printBoard
	echo "score : $score"
	playerPlay
	coinProcess
	enemyProcess
done
clear
echo "your score : $score"