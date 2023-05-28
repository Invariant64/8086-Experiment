if (($# < 1))
then
    echo "Usage: ./new.sh <task_name>"
    exit
fi

if [ -d "./"$1/ ];
then
    echo $1" is existed!"
    exit
fi

mkdir $1

cp program.asm ./$1/$1.asm
