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
ros2 run evaluation_3_randomdag uunifast_node -n node426_0_2 -p 73 -st topic426_0_1 -pt None -u 0.002715377354501225 > ./result_6chains/node426_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node426_1_2 -p 217 -st topic426_1_1 -pt None -u 0.045629115883614346 > ./result_6chains/node426_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node426_2_2 -p 463 -st topic426_2_1 -pt None -u 0.006590298722580601 > ./result_6chains/node426_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node426_3_2 -p 484 -st topic426_3_1 -pt None -u 0.036619099655447185 > ./result_6chains/node426_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node426_4_2 -p 794 -st topic426_4_1 -pt None -u 0.010414869181396308 > ./result_6chains/node426_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node426_5_2 -p 923 -st topic426_5_1 -pt None -u 0.07024234464968375 > ./result_6chains/node426_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node426_0_0 -p 73 -st none -pt topic426_0_0 -u 0.044265663753135176 > ./result_6chains/node426_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node426_1_0 -p 217 -st none -pt topic426_1_0 -u 0.011281934748565148 > ./result_6chains/node426_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node426_2_0 -p 463 -st none -pt topic426_2_0 -u 0.04380297923339643 > ./result_6chains/node426_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node426_3_0 -p 484 -st none -pt topic426_3_0 -u 0.02542083074544174 > ./result_6chains/node426_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node426_4_0 -p 794 -st none -pt topic426_4_0 -u 0.03822375548164739 > ./result_6chains/node426_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node426_5_0 -p 923 -st none -pt topic426_5_0 -u 0.03264102852177987 > ./result_6chains/node426_5_0.txt &
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
    "./result_6chains/node426_0_0.txt 90"
    "./result_6chains/node426_0_2.txt 90"
    "./result_6chains/node426_1_0.txt 89"
    "./result_6chains/node426_1_2.txt 89"
    "./result_6chains/node426_2_0.txt 88"
    "./result_6chains/node426_2_2.txt 88"
    "./result_6chains/node426_3_0.txt 87"
    "./result_6chains/node426_3_2.txt 87"
    "./result_6chains/node426_4_0.txt 86"
    "./result_6chains/node426_4_2.txt 86"
    "./result_6chains/node426_5_0.txt 85"
    "./result_6chains/node426_5_2.txt 85"
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
