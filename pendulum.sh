source ./baSHed2d.sh

clear


rows=30
cols=50

originX=25
originY=0
PI=$(echo "scale=5; 4*a(1)" | bc -l)
bobX=20
bobY=20
len=20
angleV=0
angleA=0
angle=$(echo "scale=2; $PI/5" | bc -l)
gravity=$(echo "scale=5; 2" | bc -l)
force=$(echo "scale=5; $gravity * s($angle)" | bc -l)

xco=()
yco=()

n=13
coSize=0

while :; do
    createCanvas

    force=$(floatMultiplication $gravity $(floatDivision $angle $len))

    angleA=$(floatMultiplication -1 $force)

    angleV=$(floatAddition $angleA $angleV)

    angle=$(floatAddition $angle $angleV)

    angleV=$(floatMultiplication $angleV 0.99)

    bobX=$(floatAddition $(floatMultiplication $len $(sine $angle)) $originX)

    bobY=$(floatAddition $(floatMultiplication $len $(cosine $angle)) $originY)


    drawLine $originX $originY $(floatToInt $bobX) $(floatToInt $bobY) '@'

    yco+=($(floatToInt $bobX))

    xco+=($(floatToInt $bobY))

    coSize=$(($coSize + 1))

    if [[ $coSize -ge $n ]]
    then
        xco=("${xco[@]:1}")
        yco=("${yco[@]:1}")
        coSize=$n
    fi

    for ((i=0;i<$coSize;i++)); do   
        if((i==0))
        then
            drawPointCustom ${xco[$i]} ${yco[$i]} ';' 
        elif((i==1))
        then
            drawPointCustom ${xco[$i]} ${yco[$i]} '~'
        elif((i==2))
        then
            drawPointCustom ${xco[$i]} ${yco[$i]} '~'
        elif((i==3))
        then
            drawPointCustom ${xco[$i]} ${yco[$i]} '^'
        elif((i==4))
        then
            drawPointCustom ${xco[$i]} ${yco[$i]} '^'
        elif((i==5))
        then
            drawPointCustom ${xco[$i]} ${yco[$i]} 'o'
        elif((i==6))
        then
            drawPointCustom ${xco[$i]} ${yco[$i]} '%'
        elif((i==7))
        then
            drawPointCustom ${xco[$i]} ${yco[$i]} '$'
        elif((i==8))
        then
            drawPointCustom ${xco[$i]} ${yco[$i]} '&'
        elif((i==9))
        then
            drawPointCustom ${xco[$i]} ${yco[$i]} '@'
        fi 
    done
    drawCircle $(floatToInt $bobX) $(floatToInt $bobY) 3 'o'


    drawCanvas
    moveCursorToBegining
done