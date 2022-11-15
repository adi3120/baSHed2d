source ./baSHed2d.sh

clear

originX=20
originY=0
PI=$(echo "scale=5; 4*a(1)" | bc -l)
bobX=20
bobY=20
len=20
angleV=$(echo "scale=2; 0" | bc -l)
angleA=$(echo "scale=2; 0" | bc -l)
angle=$(echo "scale=2; $PI/3" | bc -l)
gravity=$(echo "scale=5; 1" | bc -l)
force=$(echo "scale=5; $gravity * s($angle)" | bc -l)

xco=()
yco=()

n=13
coSize=0

while :; do
    createCanvas
    force=$(echo "scale=5; $gravity * s($angle)/$len" | bc -l)

    angleA=$(echo "scale=5; -1 * $force" | bc -l)
    angleV=$(echo "scale=5; $angleV + $angleA" | bc -l)

    angle=$(echo "scale=5; $angle + $angleV" | bc -l)
    angleV=$(echo "scale=5; $angleV * 0.99" | bc -l)

    bobX=$(echo "scale=10; $len * s($angle)+$originX" | bc -l)
    bobY=$(echo "scale=10; $len * c($angle)+$originY" | bc -l)
    drawLine $originX $originY ${bobX%.*} ${bobY%.*} '@'

    yco+=(${bobX%.*})

    xco+=(${bobY%.*})

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
    drawCircle ${bobY%.*} ${bobX%.*} 5 'o'


    drawCanvas
    moveCursorToBegining
done
