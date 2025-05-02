#!/bin/bash

# Print usage information and exit
print_usage() {
    echo "Usage: $0 <vanilla|framework> <with_nonRT_pl|no>"
    exit 1
}

if [ "$#" -ne 2 ]; then
    print_usage
fi

type=$1
model=$2

# Create a directory to store the result data
# CreateDIR=result/
# if [ ! -d "$CreateDIR" ]; then
#    mkdir "$CreateDIR"
# fi
ros2 run evaluation_3_randomdag uunifast_node -n node100_0_2 -p 277 -st topic100_0_1 -pt None -u 0.06850939167155867 > ./result_10chains/node100_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node100_1_2 -p 402 -st topic100_1_1 -pt None -u 0.010018707028032259 > ./result_10chains/node100_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node100_2_2 -p 421 -st topic100_2_1 -pt None -u 0.036540028752461096 > ./result_10chains/node100_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node100_3_2 -p 456 -st topic100_3_1 -pt None -u 0.010023675949918848 > ./result_10chains/node100_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node100_4_2 -p 459 -st topic100_4_1 -pt None -u 0.01759734709684116 > ./result_10chains/node100_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node100_5_2 -p 506 -st topic100_5_1 -pt None -u 0.030104510523792177 > ./result_10chains/node100_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node100_6_2 -p 592 -st topic100_6_1 -pt None -u 0.018557905588758958 > ./result_10chains/node100_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node100_7_2 -p 666 -st topic100_7_1 -pt None -u 0.010182415399777434 > ./result_10chains/node100_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node100_8_2 -p 689 -st topic100_8_1 -pt None -u 0.01905311551036179 > ./result_10chains/node100_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node100_9_2 -p 796 -st topic100_9_1 -pt None -u 0.020058519899890843 > ./result_10chains/node100_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node100_0_0 -p 277 -st none -pt topic100_0_0 -u 0.005315611814579124 > ./result_10chains/node100_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node100_1_0 -p 402 -st none -pt topic100_1_0 -u 0.018461321294393207 > ./result_10chains/node100_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node100_2_0 -p 421 -st none -pt topic100_2_0 -u 0.01440965893573709 > ./result_10chains/node100_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node100_3_0 -p 456 -st none -pt topic100_3_0 -u 0.019643889844608853 > ./result_10chains/node100_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node100_4_0 -p 459 -st none -pt topic100_4_0 -u 0.0015755007833786194 > ./result_10chains/node100_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node100_5_0 -p 506 -st none -pt topic100_5_0 -u 0.01254179887370227 > ./result_10chains/node100_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node100_6_0 -p 592 -st none -pt topic100_6_0 -u 0.0061973576508154715 > ./result_10chains/node100_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node100_7_0 -p 666 -st none -pt topic100_7_0 -u 0.01243856883328777 > ./result_10chains/node100_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node100_8_0 -p 689 -st none -pt topic100_8_0 -u 0.0068642429966768725 > ./result_10chains/node100_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node100_9_0 -p 796 -st none -pt topic100_9_0 -u 0.018336718623611952 > ./result_10chains/node100_9_0.txt &
sleep 20
finalize_framework() {
    if [ "$type" == "framework" ]; then
        if [ "$model" == "with_nonRT" ]; then
            python3 pri_remove.py "$file_name_motor"
        fi
        for filepath in "${files[@]}"; do
            file=$(echo "$filepath" | cut -d' ' -f1)
            python3 pri_remove.py "$file"
        done
    fi
}


# Priority Assignments
declare -a files=(
    "./result_10chains/node100_0_0.txt 90"
    "./result_10chains/node100_0_2.txt 90"
    "./result_10chains/node100_1_0.txt 89"
    "./result_10chains/node100_1_2.txt 89"
    "./result_10chains/node100_2_0.txt 88"
    "./result_10chains/node100_2_2.txt 88"
    "./result_10chains/node100_3_0.txt 87"
    "./result_10chains/node100_3_2.txt 87"
    "./result_10chains/node100_4_0.txt 86"
    "./result_10chains/node100_4_2.txt 86"
    "./result_10chains/node100_5_0.txt 85"
    "./result_10chains/node100_5_2.txt 85"
    "./result_10chains/node100_6_0.txt 84"
    "./result_10chains/node100_6_2.txt 84"
    "./result_10chains/node100_7_0.txt 83"
    "./result_10chains/node100_7_2.txt 83"
    "./result_10chains/node100_8_0.txt 82"
    "./result_10chains/node100_8_2.txt 82"
    "./result_10chains/node100_9_0.txt 81"
    "./result_10chains/node100_9_2.txt 81"
)

for filepath in "${files[@]}"; do
    file=$(echo "$filepath" | cut -d' ' -f1)
    priority=$(echo "$filepath" | cut -d' ' -f2)
    if [ "$type" == "vanilla" ]; then
        python3 pri_assign.py $file $priority
    elif [ "$type" == "framework" ]; then
        python3 pri_identifier.py $file $priority
    fi
done
echo "End Priority Assignment"

# Finalize by performing a final command and killing any remaining processes
sleep 190s
sudo pkill -USR1 uunifast_node
echo "Set timer signal!"
sleep 200s
echo "End Running"
sudo pkill uunifast_node
finalize_framework
/home/orin5/prio_ros2/evaluation_2_fig10/send_signal 127.0.0.1 9999
