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
ros2 run evaluation_3_randomdag uunifast_node -n node128_0_2 -p 34 -st topic128_0_1 -pt None -u 0.014560625785246195 > ./result_6chains/node128_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node128_1_2 -p 345 -st topic128_1_1 -pt None -u 0.02249311682126942 > ./result_6chains/node128_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node128_2_2 -p 347 -st topic128_2_1 -pt None -u 0.01565905857230032 > ./result_6chains/node128_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node128_3_2 -p 692 -st topic128_3_1 -pt None -u 0.05636582867108422 > ./result_6chains/node128_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node128_4_2 -p 730 -st topic128_4_1 -pt None -u 0.08798904512588862 > ./result_6chains/node128_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node128_5_2 -p 771 -st topic128_5_1 -pt None -u 0.013835139570402168 > ./result_6chains/node128_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node128_0_0 -p 34 -st none -pt topic128_0_0 -u 0.07442418640452197 > ./result_6chains/node128_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node128_1_0 -p 345 -st none -pt topic128_1_0 -u 0.005914139240752958 > ./result_6chains/node128_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node128_2_0 -p 347 -st none -pt topic128_2_0 -u 0.002805092133914888 > ./result_6chains/node128_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node128_3_0 -p 692 -st none -pt topic128_3_0 -u 0.0030424047010432775 > ./result_6chains/node128_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node128_4_0 -p 730 -st none -pt topic128_4_0 -u 0.03575162187758449 > ./result_6chains/node128_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node128_5_0 -p 771 -st none -pt topic128_5_0 -u 0.016947875501760943 > ./result_6chains/node128_5_0.txt &
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
    "./result_6chains/node128_0_0.txt 90"
    "./result_6chains/node128_0_2.txt 90"
    "./result_6chains/node128_1_0.txt 89"
    "./result_6chains/node128_1_2.txt 89"
    "./result_6chains/node128_2_0.txt 88"
    "./result_6chains/node128_2_2.txt 88"
    "./result_6chains/node128_3_0.txt 87"
    "./result_6chains/node128_3_2.txt 87"
    "./result_6chains/node128_4_0.txt 86"
    "./result_6chains/node128_4_2.txt 86"
    "./result_6chains/node128_5_0.txt 85"
    "./result_6chains/node128_5_2.txt 85"
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
sleep 130s
sudo pkill -USR1 uunifast_node
echo "Set timer signal!"
sleep 200s
echo "End Running"
sudo pkill uunifast_node
finalize_framework
/home/orin5/prio_ros2/evaluation_2_fig10/send_signal 127.0.0.1 9999
