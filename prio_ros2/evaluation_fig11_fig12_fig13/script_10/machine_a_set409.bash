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
ros2 run evaluation_3_randomdag uunifast_node -n node409_0_2 -p 341 -st topic409_0_1 -pt None -u 0.01879415965112452 > ./result_10chains/node409_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node409_1_2 -p 445 -st topic409_1_1 -pt None -u 0.06738142903998762 > ./result_10chains/node409_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node409_2_2 -p 467 -st topic409_2_1 -pt None -u 0.024436063939693553 > ./result_10chains/node409_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node409_3_2 -p 482 -st topic409_3_1 -pt None -u 0.004303784569976321 > ./result_10chains/node409_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node409_4_2 -p 551 -st topic409_4_1 -pt None -u 0.01196746803947496 > ./result_10chains/node409_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node409_5_2 -p 644 -st topic409_5_1 -pt None -u 0.008706894479725447 > ./result_10chains/node409_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node409_6_2 -p 667 -st topic409_6_1 -pt None -u 0.019210362578952783 > ./result_10chains/node409_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node409_7_2 -p 701 -st topic409_7_1 -pt None -u 0.005142146371104037 > ./result_10chains/node409_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node409_8_2 -p 720 -st topic409_8_1 -pt None -u 0.007670898300839515 > ./result_10chains/node409_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node409_9_2 -p 868 -st topic409_9_1 -pt None -u 0.004115462216105754 > ./result_10chains/node409_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node409_0_0 -p 341 -st none -pt topic409_0_0 -u 0.0035446291970024357 > ./result_10chains/node409_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node409_1_0 -p 445 -st none -pt topic409_1_0 -u 0.015323299871950469 > ./result_10chains/node409_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node409_2_0 -p 467 -st none -pt topic409_2_0 -u 0.006489420534574408 > ./result_10chains/node409_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node409_3_0 -p 482 -st none -pt topic409_3_0 -u 0.006300932456913377 > ./result_10chains/node409_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node409_4_0 -p 551 -st none -pt topic409_4_0 -u 0.015484657385541695 > ./result_10chains/node409_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node409_5_0 -p 644 -st none -pt topic409_5_0 -u 0.004220739677228608 > ./result_10chains/node409_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node409_6_0 -p 667 -st none -pt topic409_6_0 -u 0.023840927383503435 > ./result_10chains/node409_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node409_7_0 -p 701 -st none -pt topic409_7_0 -u 0.0335655503180424 > ./result_10chains/node409_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node409_8_0 -p 720 -st none -pt topic409_8_0 -u 0.020126646201154508 > ./result_10chains/node409_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node409_9_0 -p 868 -st none -pt topic409_9_0 -u 0.01298151266211189 > ./result_10chains/node409_9_0.txt &
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
    "./result_10chains/node409_0_0.txt 90"
    "./result_10chains/node409_0_2.txt 90"
    "./result_10chains/node409_1_0.txt 89"
    "./result_10chains/node409_1_2.txt 89"
    "./result_10chains/node409_2_0.txt 88"
    "./result_10chains/node409_2_2.txt 88"
    "./result_10chains/node409_3_0.txt 87"
    "./result_10chains/node409_3_2.txt 87"
    "./result_10chains/node409_4_0.txt 86"
    "./result_10chains/node409_4_2.txt 86"
    "./result_10chains/node409_5_0.txt 85"
    "./result_10chains/node409_5_2.txt 85"
    "./result_10chains/node409_6_0.txt 84"
    "./result_10chains/node409_6_2.txt 84"
    "./result_10chains/node409_7_0.txt 83"
    "./result_10chains/node409_7_2.txt 83"
    "./result_10chains/node409_8_0.txt 82"
    "./result_10chains/node409_8_2.txt 82"
    "./result_10chains/node409_9_0.txt 81"
    "./result_10chains/node409_9_2.txt 81"
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
