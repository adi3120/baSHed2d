source ./baSHed2d.sh

rows=40
cols=70

len=10
fillChar='#'

clear

angle=0

declare -A a

a[0,0]=1
a[0,1]=0
a[0,2]=0

a[1,0]=0
a[1,1]=1
a[1,2]=0

a[2,0]=0
a[2,1]=0
a[2,2]=0

declare -A b

b[0,0]=$(giveNeg $len)
b[0,1]=$(giveNeg $len)
b[0,2]=$(giveNeg $len)

b[1,0]=$len
b[1,1]=$(giveNeg $len)
b[1,2]=$(giveNeg $len)

b[2,0]=$len
b[2,1]=$len
b[2,2]=$(giveNeg $len)

b[3,0]=$(giveNeg $len)
b[3,1]=$len
b[3,2]=$(giveNeg $len)

b[4,0]=$(giveNeg $len)
b[4,1]=$(giveNeg $len)
b[4,2]=$len

b[5,0]=$len
b[5,1]=$(giveNeg $len)
b[5,2]=$len

b[6,0]=$len
b[6,1]=$len
b[6,2]=$len

b[7,0]=$(giveNeg $len)
b[7,1]=$len
b[7,2]=$len

declare -A rotationX
declare -A rotationY
declare -A rotationZ

rotationX[1,0]=0
rotationX[2,0]=0
rotationX[0,1]=0
rotationX[0,2]=0

rotationY[0,1]=0
rotationY[1,0]=0  
rotationY[1,2]=0
rotationY[2,1]=0

rotationZ[2,0]=0
rotationZ[2,1]=0
rotationZ[0,2]=0
rotationZ[1,2]=0 




rotationX[0,0]=1
rotationY[1,1]=1
rotationZ[2,2]=1


declare -A mat
declare -A rotated
declare -A projected


xoff=$(floatToInt $(floatDivision $cols 2))
yoff=$(floatToInt $(floatDivision $rows 2))

while :; do
    createCanvas

    rotationZ[0,0]=$(cosine $angle)
    rotationZ[0,1]=$(echo "scale=5; -s($angle)" | bc -l)

    rotationZ[1,0]=$(sine $angle)
    rotationZ[1,1]=$(cosine $angle)

    rotationX[1,1]=$(cosine $angle)
    rotationX[1,2]=$(echo "scale=5; -s($angle)" | bc -l)

    rotationX[2,1]=$(sine $angle)
    rotationX[2,2]=$(cosine $angle)

    rotationY[0,0]=$(cosine $angle)
    rotationY[0,2]=$(echo "scale=5; -s($angle)" | bc -l)

    rotationY[2,0]=$(sine $angle)
    rotationY[2,2]=$(cosine $angle)


    index=0

    for((i=0;i<8;i++))
    do
        xpo=${b[$i,0]}
        ypo=${b[$i,1]}
        zpo=${b[$i,2]}


        val_a=$(floatMultiplication ${rotationY[0,0]} $xpo) 
        val_b=0 
        val_c=$(floatMultiplication ${rotationY[0,2]} $zpo) 


        val_a_plus_b=$(floatAddition $val_a $val_b)
        val_a_plus_b_plus_c=$(floatAddition $val_a_plus_b $val_c)

        hereX=$val_a_plus_b_plus_c

        val_a=0
        val_b=$ypo
        val_c=0 

        val_a_plus_b=$(floatAddition $val_a $val_b)
        val_a_plus_b_plus_c=$(floatAddition $val_a_plus_b $val_c)

        hereY=$val_a_plus_b_plus_c

        val_a=$(floatMultiplication ${rotationY[2,0]} $xpo) 
        val_b=0 
        val_c=$(floatMultiplication ${rotationY[2,2]} $zpo) 

        val_a_plus_b=$(floatAddition $val_a $val_b)
        val_a_plus_b_plus_c=$(floatAddition $val_a_plus_b $val_c)

        hereZ=$val_a_plus_b_plus_c

        rotated[0,0]=$hereX
        rotated[1,0]=$hereY
        rotated[2,0]=$hereZ

        val_a=${rotated[0,0]}
        val_b=0
        val_c=0


        val_a_plus_b=$(floatAddition $val_a $val_b)
        val_a_plus_b_plus_c=$(floatAddition $val_a_plus_b $val_c)

        hereX=$val_a_plus_b_plus_c

        val_a=0 
        val_b=$(floatMultiplication ${rotationX[1,1]} ${rotated[1,0]}) 
        val_c=$(floatMultiplication ${rotationX[1,2]} ${rotated[2,0]}) 

        val_a_plus_b=$(floatAddition $val_a $val_b)
        val_a_plus_b_plus_c=$(floatAddition $val_a_plus_b $val_c)

        hereY=$val_a_plus_b_plus_c

        val_a=0
        val_b=$(floatMultiplication ${rotationX[2,1]} ${rotated[1,0]}) 
        val_c=$(floatMultiplication ${rotationX[2,2]} ${rotated[2,0]}) 

        val_a_plus_b=$(floatAddition $val_a $val_b)
        val_a_plus_b_plus_c=$(floatAddition $val_a_plus_b $val_c)

        hereZ=$val_a_plus_b_plus_c

        rotated[0,0]=$hereX
        rotated[1,0]=$hereY
        rotated[2,0]=$hereZ

        val_a=$(floatMultiplication ${rotationZ[0,0]} ${rotated[0,0]}) 
        val_b=$(floatMultiplication ${rotationZ[0,1]} ${rotated[1,0]}) 
        val_c=0


        val_a_plus_b=$(floatAddition $val_a $val_b)
        val_a_plus_b_plus_c=$(floatAddition $val_a_plus_b $val_c)

        hereX=$val_a_plus_b_plus_c

        val_a=$(floatMultiplication ${rotationZ[1,0]} ${rotated[0,0]}) 
        val_b=$(floatMultiplication ${rotationZ[1,1]} ${rotated[1,0]}) 
        val_c=0

        val_a_plus_b=$(floatAddition $val_a $val_b)
        val_a_plus_b_plus_c=$(floatAddition $val_a_plus_b $val_c)

        hereY=$val_a_plus_b_plus_c

        val_a=0 
        val_b=0
        val_c=${rotated[2,0]}

        val_a_plus_b=$(floatAddition $val_a $val_b)
        val_a_plus_b_plus_c=$(floatAddition $val_a_plus_b $val_c)

        hereZ=$val_a_plus_b_plus_c

        rotated[0,0]=$hereX
        rotated[1,0]=$hereY
        rotated[2,0]=$hereZ

        val_a=$(floatMultiplication ${a[0,0]} ${rotated[0,0]}) 
        val_b=$(floatMultiplication ${a[0,1]} ${rotated[1,0]}) 
        val_c=$(floatMultiplication ${a[0,2]} ${rotated[2,0]}) 


        val_a_plus_b=$(floatAddition $val_a $val_b)
        val_a_plus_b_plus_c=$(floatAddition $val_a_plus_b $val_c)

        hereX=$val_a_plus_b_plus_c

        val_a=$(floatMultiplication ${a[1,0]} ${rotated[0,0]}) 
        val_b=$(floatMultiplication ${a[1,1]} ${rotated[1,0]}) 
        val_c=$(floatMultiplication ${a[1,2]} ${rotated[2,0]}) 

        val_a_plus_b=$(floatAddition $val_a $val_b)
        val_a_plus_b_plus_c=$(floatAddition $val_a_plus_b $val_c)

        hereY=$val_a_plus_b_plus_c

        val_a=$(floatMultiplication ${a[2,0]} ${rotated[0,0]}) 
        val_b=$(floatMultiplication ${a[2,1]} ${rotated[1,0]}) 
        val_c=$(floatMultiplication ${a[2,2]} ${rotated[2,0]}) 

        val_a_plus_b=$(floatAddition $val_a $val_b)
        val_a_plus_b_plus_c=$(floatAddition $val_a_plus_b $val_c)

        hereZ=$val_a_plus_b_plus_c

        mat[0,0]=$(floatAddition $hereX $xoff)
        mat[1,0]=$(floatAddition $hereY $yoff)

        projected[$index,0]=${mat[0,0]}
        projected[$index,1]=${mat[1,0]}

        index=$(($index+1))
    done

    drawLine $(floatToInt ${projected[0,0]}) $(floatToInt ${projected[0,1]}) $(floatToInt ${projected[1,0]}) $(floatToInt ${projected[1,1]}) $fillChar
    drawLine $(floatToInt ${projected[1,0]}) $(floatToInt ${projected[1,1]}) $(floatToInt ${projected[2,0]}) $(floatToInt ${projected[2,1]}) $fillChar
    drawLine $(floatToInt ${projected[2,0]}) $(floatToInt ${projected[2,1]}) $(floatToInt ${projected[3,0]}) $(floatToInt ${projected[3,1]}) $fillChar
    drawLine $(floatToInt ${projected[3,0]}) $(floatToInt ${projected[3,1]}) $(floatToInt ${projected[0,0]}) $(floatToInt ${projected[0,1]}) $fillChar
    
    drawLine $(floatToInt ${projected[4,0]}) $(floatToInt ${projected[4,1]}) $(floatToInt ${projected[5,0]}) $(floatToInt ${projected[5,1]}) $fillChar
    drawLine $(floatToInt ${projected[5,0]}) $(floatToInt ${projected[5,1]}) $(floatToInt ${projected[6,0]}) $(floatToInt ${projected[6,1]}) $fillChar
    drawLine $(floatToInt ${projected[6,0]}) $(floatToInt ${projected[6,1]}) $(floatToInt ${projected[7,0]}) $(floatToInt ${projected[7,1]}) $fillChar
    drawLine $(floatToInt ${projected[7,0]}) $(floatToInt ${projected[7,1]}) $(floatToInt ${projected[4,0]}) $(floatToInt ${projected[4,1]}) $fillChar

    drawLine $(floatToInt ${projected[0,0]}) $(floatToInt ${projected[0,1]}) $(floatToInt ${projected[4,0]}) $(floatToInt ${projected[4,1]}) $fillChar
    drawLine $(floatToInt ${projected[1,0]}) $(floatToInt ${projected[1,1]}) $(floatToInt ${projected[5,0]}) $(floatToInt ${projected[5,1]}) $fillChar
    drawLine $(floatToInt ${projected[2,0]}) $(floatToInt ${projected[2,1]}) $(floatToInt ${projected[6,0]}) $(floatToInt ${projected[6,1]}) $fillChar
    drawLine $(floatToInt ${projected[3,0]}) $(floatToInt ${projected[3,1]}) $(floatToInt ${projected[7,0]}) $(floatToInt ${projected[7,1]}) $fillChar
    

    drawCanvas
    angle=$(floatAddition $angle $(floatDivision $PI 30))
    moveCursorToBegining
done