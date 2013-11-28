# ----------------------convertToITsize----------------------

img=$(basename "$1")
extension="${img##*.}"
img="${img%.*}"

path=$(realpath "$1")
path="${path%\/*}"

imgN=$img"2"

extension="png"

convert -resize 128x128 $1 $path\/$imgN\.$extension

NS=`identify $path\/$imgN\.$extension  | awk '{print $3}' | awk '{gsub("x"," ");print $1}'`

EW=`identify $path\/$imgN\.$extension  | awk '{print $3}' | awk '{gsub("x"," ");print $2}'`

# NORTH SOUTH
a=`expr 128 - $NS`

aN=`expr $a / 2`

if [ `expr $a % 2` = 1 ]; 
	then aS=`expr $aN + 1` 
else aS=$aN 
fi

# WEST EAST
b=`expr 128 - $EW`

bW=`expr $b / 2`
if [ `expr $b % 2` = 1 ]; 
	then bE=`expr $bW + 1` 
else bE=$bW 
fi

imgNN=$imgN"3"

convert -gravity northeast -background transparent -splice $aN"x"$bE $path\/$imgN\.$extension $path\/$imgNN\.$extension

imgNNN=$imgNN"new"

convert -gravity southwest -background transparent -splice $aS"x"$bW $path\/$imgNN\.$extension $path\/$imgNNN\.$extension

rm $path\/$imgN\.$extension

rm $path\/$imgNN\.$extension