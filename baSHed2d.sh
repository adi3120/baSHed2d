#! /bin/bash

declare -A canvas

rows=30
cols=40

createCanvas() {
    for ((i = 0; i < $rows; i++)); do
        for ((j = 0; j < $cols; j++)); do
            canvas[$i, $j]="."
        done
    done
}

drawCanvas() {
    for ((i = 0; i < $rows; i++)); do
        str=()
        for ((j = 0; j < $cols; j++)); do
            str+="${canvas[$i, $j]} "
        done
        echo $str
    done
}

moveCursorToBegining() {
    echo -e "\e[H"
}

drawPointCustom() {
    local x=$1
    local y=$2
    local c=$3
    canvas["$x", "$y"]=$c
}

drawRectange() {
    l=$1
    b=$2
    x=$3
    y=$4
    c=$5
    i=0
    j=0

    for ((i = 0; i < $b; i++)); do
        for ((j = 0; j < $l; j++)); do
            px=$(($x + $i))
            py=$(($y + $j))
            drawPointCustom $px $py $c
        done
    done
}

drawCircle() {
    cx=$1
    cy=$2
    r=$3
    c=$4

    if [ $cx -lt $rows ] && [ $cy -lt $cols ] && [ $cx -gt 0 ] && [ $cy -gt 0 ]; then

        for ((yn = (-$r); yn <= $r; yn++)); do
            for ((xn = (-$r); xn <= $r; xn++)); do
                xsqr=$(($xn * $xn))
                ysqr=$(($yn * $yn))
                xsqr_plus_ysqr=$(($xsqr + $ysqr))
                rsqr=$(($r * $r))
                if [ $xsqr_plus_ysqr -lt $rsqr ]; then
                    px=$(($cx + $xn))
                    py=$(($cy + $yn))
                    drawPointCustom $px $py $c
                fi
            done
        done
    fi
}



drawLine() {
    y1=$1
    x1=$2
    y2=$3
    x2=$4
    c=$5

    dx=$(($x2 - $x1))
    dy=$(($y2 - $y1))
    dx1=$(($dx))
    dy1=$(($dy))

    if ((dx < 0)); then
        dx1=$((-$dx))
    fi
    if ((dy < 0)); then
        dy1=$((-$dy))
    fi
    twody1=(2*$dy1)
    twodx1=(2*$dx1)
    twody1_minus_dx1=$(($twody1 - $dx1))
    twodx1_minus_dy1=$(($twodx1 - $dy1))

    if ((dy1 <= dx1)); then
        if ((dx >= 0)); then
            x=$x1
            y=$y1
            xe=$x2
        else
            x=$x2
            y=$y2
            xe=$x1
        fi
        drawPointCustom $x $y $c
        for ((i = 0; x < $xe; i++)); do
            x=$(($x + 1))
            if ((px < 0)); then
                px=$(($px + $twody1))
            else
                if [ $dx -lt 0 ] && [ $dy -lt 0 ]; then
                    y=$(($y + 1))
                elif [ $dx -gt 0 ] && [ $dy -gt 0 ]; then
                    y=$(($y + 1))
                else
                    y=$(($y - 1))
                fi
                dy1_minus_dx1=$(($dy1 - $dx1))
                two_dy1_minus_dx1=(2*$dy1_minus_dx1)
                px=$(($px + $two_dy1_minus_dx1))
            fi
            drawPointCustom $x $y $c
        done

    else
        if ((dy >= 0)); then
            x=$x1
            y=$y1
            ye=$y2
        else
            x=$x2
            y=$y2
            ye=$y1
        fi
        drawPointCustom $x $y $c
        for ((i = 0; y < $ye; i++)); do
            y=$(($y + 1))
            if ((py <= 0)); then
                py=$(($py + $twodx1))
            else
                if [ $dx -lt 0 ] && [ $dy -lt 0 ]; then
                    x=$(($x + 1))
                elif [ $dx -gt 0 ] && [ $dy -gt 0 ]; then
                    x=$(($x + 1))
                else
                    x=$(($x - 1))
                fi
                dx1_minus_dy1=$(($dx1 - $dy1))
                two_dx1_minus_dy1=(2*$dx1_minus_dy1)
                py=$(($py + $two_dx1_minus_dy1))
            fi
            drawPointCustom $x $y $c
        done
    fi
}
