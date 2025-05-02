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
ros2 run evaluation_3_randomdag uunifast_node -n node395_0_2 -p 37 -st topic395_0_1 -pt None -u 0.025103585554562657 > ./result_8chains/node395_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node395_1_2 -p 469 -st topic395_1_1 -pt None -u 0.0022745987995214656 > ./result_8chains/node395_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node395_2_2 -p 505 -st topic395_2_1 -pt None -u 0.007739426840276564 > ./result_8chains/node395_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node395_3_2 -p 602 -st topic395_3_1 -pt None -u 0.03265751873531547 > ./result_8chains/node395_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node395_4_2 -p 657 -st topic395_4_1 -pt None -u 0.0007521826775285512 > ./result_8chains/node395_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node395_5_2 -p 681 -st topic395_5_1 -pt None -u 0.006455363037152911 > ./result_8chains/node395_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node395_6_2 -p 880 -st topic395_6_1 -pt None -u 0.03815322730405214 > ./result_8chains/node395_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node395_7_2 -p 908 -st topic395_7_1 -pt None -u 0.007586036722797211 > ./result_8chains/node395_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node395_0_0 -p 37 -st none -pt topic395_0_0 -u 0.04362913644529537 > ./result_8chains/node395_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node395_1_0 -p 469 -st none -pt topic395_1_0 -u 0.002152371581591206 > ./result_8chains/node395_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node395_2_0 -p 505 -st none -pt topic395_2_0 -u 0.008942045357177297 > ./result_8chains/node395_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node395_3_0 -p 602 -st none -pt topic395_3_0 -u 0.010451135292842528 > ./result_8chains/node395_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node395_4_0 -p 657 -st none -pt topic395_4_0 -u 0.0069224060140214705 > ./result_8chains/node395_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node395_5_0 -p 681 -st none -pt topic395_5_0 -u 0.038979344363842094 > ./result_8chains/node395_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node395_6_0 -p 880 -st none -pt topic395_6_0 -u 0.004312717524303802 > ./result_8chains/node395_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node395_7_0 -p 908 -st none -pt topic395_7_0 -u 0.009398074317858548 > ./result_8chains/node395_7_0.txt &
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
    "./result_8chains/node395_0_0.txt 90"
    "./result_8chains/node395_0_2.txt 90"
    "./result_8chains/node395_1_0.txt 89"
    "./result_8chains/node395_1_2.txt 89"
    "./result_8chains/node395_2_0.txt 88"
    "./result_8chains/node395_2_2.txt 88"
    "./result_8chains/node395_3_0.txt 87"
    "./result_8chains/node395_3_2.txt 87"
    "./result_8chains/node395_4_0.txt 86"
    "./result_8chains/node395_4_2.txt 86"
    "./result_8chains/node395_5_0.txt 85"
    "./result_8chains/node395_5_2.txt 85"
    "./result_8chains/node395_6_0.txt 84"
    "./result_8chains/node395_6_2.txt 84"
    "./result_8chains/node395_7_0.txt 83"
    "./result_8chains/node395_7_2.txt 83"
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
sleep 180s
sudo pkill -USR1 uunifast_node
echo "Set timer signal!"
sleep 200s
echo "End Running"
sudo pkill uunifast_node
finalize_framework
/home/orin5/prio_ros2/evaluation_2_fig10/send_signal 127.0.0.1 9999
