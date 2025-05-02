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
ros2 run evaluation_3_randomdag uunifast_node -n node331_0_2 -p 14 -st topic331_0_1 -pt None -u 0.013930437106014437 > ./result_8chains/node331_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node331_1_2 -p 51 -st topic331_1_1 -pt None -u 0.029870100653352216 > ./result_8chains/node331_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node331_2_2 -p 196 -st topic331_2_1 -pt None -u 0.002311685732951818 > ./result_8chains/node331_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node331_3_2 -p 255 -st topic331_3_1 -pt None -u 0.03627852159019046 > ./result_8chains/node331_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node331_4_2 -p 483 -st topic331_4_1 -pt None -u 0.01776086825657991 > ./result_8chains/node331_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node331_5_2 -p 526 -st topic331_5_1 -pt None -u 0.010744955351860985 > ./result_8chains/node331_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node331_6_2 -p 590 -st topic331_6_1 -pt None -u 0.02847684919213652 > ./result_8chains/node331_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node331_7_2 -p 671 -st topic331_7_1 -pt None -u 0.019486265963659963 > ./result_8chains/node331_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node331_0_0 -p 14 -st none -pt topic331_0_0 -u 0.05887389544151417 > ./result_8chains/node331_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node331_1_0 -p 51 -st none -pt topic331_1_0 -u 0.05463826124046073 > ./result_8chains/node331_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node331_2_0 -p 196 -st none -pt topic331_2_0 -u 0.037885176564972645 > ./result_8chains/node331_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node331_3_0 -p 255 -st none -pt topic331_3_0 -u 0.03524858236383349 > ./result_8chains/node331_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node331_4_0 -p 483 -st none -pt topic331_4_0 -u 0.024858179853068596 > ./result_8chains/node331_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node331_5_0 -p 526 -st none -pt topic331_5_0 -u 0.0003140099659687534 > ./result_8chains/node331_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node331_6_0 -p 590 -st none -pt topic331_6_0 -u 0.0026732832473395918 > ./result_8chains/node331_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node331_7_0 -p 671 -st none -pt topic331_7_0 -u 0.0011207637922587832 > ./result_8chains/node331_7_0.txt &
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
    "./result_8chains/node331_0_0.txt 90"
    "./result_8chains/node331_0_2.txt 90"
    "./result_8chains/node331_1_0.txt 89"
    "./result_8chains/node331_1_2.txt 89"
    "./result_8chains/node331_2_0.txt 88"
    "./result_8chains/node331_2_2.txt 88"
    "./result_8chains/node331_3_0.txt 87"
    "./result_8chains/node331_3_2.txt 87"
    "./result_8chains/node331_4_0.txt 86"
    "./result_8chains/node331_4_2.txt 86"
    "./result_8chains/node331_5_0.txt 85"
    "./result_8chains/node331_5_2.txt 85"
    "./result_8chains/node331_6_0.txt 84"
    "./result_8chains/node331_6_2.txt 84"
    "./result_8chains/node331_7_0.txt 83"
    "./result_8chains/node331_7_2.txt 83"
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
