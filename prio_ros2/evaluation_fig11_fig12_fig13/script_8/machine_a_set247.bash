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
ros2 run evaluation_3_randomdag uunifast_node -n node247_0_2 -p 183 -st topic247_0_1 -pt None -u 0.028808059781185447 > ./result_8chains/node247_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node247_1_2 -p 301 -st topic247_1_1 -pt None -u 0.03472337507701029 > ./result_8chains/node247_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node247_2_2 -p 427 -st topic247_2_1 -pt None -u 0.003833607858757526 > ./result_8chains/node247_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node247_3_2 -p 483 -st topic247_3_1 -pt None -u 0.011665906751865796 > ./result_8chains/node247_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node247_4_2 -p 614 -st topic247_4_1 -pt None -u 0.010237919908390042 > ./result_8chains/node247_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node247_5_2 -p 649 -st topic247_5_1 -pt None -u 0.0019987627696382293 > ./result_8chains/node247_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node247_6_2 -p 699 -st topic247_6_1 -pt None -u 0.023440152436490183 > ./result_8chains/node247_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node247_7_2 -p 965 -st topic247_7_1 -pt None -u 0.015153762211870841 > ./result_8chains/node247_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node247_0_0 -p 183 -st none -pt topic247_0_0 -u 0.017285805518048813 > ./result_8chains/node247_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node247_1_0 -p 301 -st none -pt topic247_1_0 -u 0.04339064850922597 > ./result_8chains/node247_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node247_2_0 -p 427 -st none -pt topic247_2_0 -u 0.007490552200176859 > ./result_8chains/node247_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node247_3_0 -p 483 -st none -pt topic247_3_0 -u 0.004186420705328653 > ./result_8chains/node247_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node247_4_0 -p 614 -st none -pt topic247_4_0 -u 0.05403533983752107 > ./result_8chains/node247_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node247_5_0 -p 649 -st none -pt topic247_5_0 -u 0.003728759879611021 > ./result_8chains/node247_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node247_6_0 -p 699 -st none -pt topic247_6_0 -u 0.006127108985822471 > ./result_8chains/node247_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node247_7_0 -p 965 -st none -pt topic247_7_0 -u 0.024061884285220686 > ./result_8chains/node247_7_0.txt &
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
    "./result_8chains/node247_0_0.txt 90"
    "./result_8chains/node247_0_2.txt 90"
    "./result_8chains/node247_1_0.txt 89"
    "./result_8chains/node247_1_2.txt 89"
    "./result_8chains/node247_2_0.txt 88"
    "./result_8chains/node247_2_2.txt 88"
    "./result_8chains/node247_3_0.txt 87"
    "./result_8chains/node247_3_2.txt 87"
    "./result_8chains/node247_4_0.txt 86"
    "./result_8chains/node247_4_2.txt 86"
    "./result_8chains/node247_5_0.txt 85"
    "./result_8chains/node247_5_2.txt 85"
    "./result_8chains/node247_6_0.txt 84"
    "./result_8chains/node247_6_2.txt 84"
    "./result_8chains/node247_7_0.txt 83"
    "./result_8chains/node247_7_2.txt 83"
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
