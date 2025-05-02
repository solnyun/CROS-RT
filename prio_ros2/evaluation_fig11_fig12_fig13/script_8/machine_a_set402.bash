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
ros2 run evaluation_3_randomdag uunifast_node -n node402_0_2 -p 89 -st topic402_0_1 -pt None -u 0.0005578756082698089 > ./result_8chains/node402_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node402_1_2 -p 444 -st topic402_1_1 -pt None -u 0.026247360898468075 > ./result_8chains/node402_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node402_2_2 -p 454 -st topic402_2_1 -pt None -u 0.0038493088834084532 > ./result_8chains/node402_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node402_3_2 -p 547 -st topic402_3_1 -pt None -u 0.007075787141231832 > ./result_8chains/node402_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node402_4_2 -p 744 -st topic402_4_1 -pt None -u 0.0008468842393208886 > ./result_8chains/node402_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node402_5_2 -p 813 -st topic402_5_1 -pt None -u 0.035456933438573354 > ./result_8chains/node402_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node402_6_2 -p 898 -st topic402_6_1 -pt None -u 0.051556439855955066 > ./result_8chains/node402_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node402_7_2 -p 907 -st topic402_7_1 -pt None -u 0.010291309092581554 > ./result_8chains/node402_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node402_0_0 -p 89 -st none -pt topic402_0_0 -u 0.023894685574639862 > ./result_8chains/node402_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node402_1_0 -p 444 -st none -pt topic402_1_0 -u 0.059349761182055816 > ./result_8chains/node402_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node402_2_0 -p 454 -st none -pt topic402_2_0 -u 0.056539323724744406 > ./result_8chains/node402_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node402_3_0 -p 547 -st none -pt topic402_3_0 -u 0.013862437377042847 > ./result_8chains/node402_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node402_4_0 -p 744 -st none -pt topic402_4_0 -u 0.013906925380867602 > ./result_8chains/node402_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node402_5_0 -p 813 -st none -pt topic402_5_0 -u 0.0185221117564979 > ./result_8chains/node402_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node402_6_0 -p 898 -st none -pt topic402_6_0 -u 0.003026117766190453 > ./result_8chains/node402_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node402_7_0 -p 907 -st none -pt topic402_7_0 -u 0.011667297623392636 > ./result_8chains/node402_7_0.txt &
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
    "./result_8chains/node402_0_0.txt 90"
    "./result_8chains/node402_0_2.txt 90"
    "./result_8chains/node402_1_0.txt 89"
    "./result_8chains/node402_1_2.txt 89"
    "./result_8chains/node402_2_0.txt 88"
    "./result_8chains/node402_2_2.txt 88"
    "./result_8chains/node402_3_0.txt 87"
    "./result_8chains/node402_3_2.txt 87"
    "./result_8chains/node402_4_0.txt 86"
    "./result_8chains/node402_4_2.txt 86"
    "./result_8chains/node402_5_0.txt 85"
    "./result_8chains/node402_5_2.txt 85"
    "./result_8chains/node402_6_0.txt 84"
    "./result_8chains/node402_6_2.txt 84"
    "./result_8chains/node402_7_0.txt 83"
    "./result_8chains/node402_7_2.txt 83"
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
