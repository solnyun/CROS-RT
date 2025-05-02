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
ros2 run evaluation_3_randomdag uunifast_node -n node476_0_2 -p 179 -st topic476_0_1 -pt None -u 0.007455405423417549 > ./result_6chains/node476_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node476_1_2 -p 266 -st topic476_1_1 -pt None -u 0.0053121295705158555 > ./result_6chains/node476_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node476_2_2 -p 432 -st topic476_2_1 -pt None -u 0.007859125303031622 > ./result_6chains/node476_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node476_3_2 -p 706 -st topic476_3_1 -pt None -u 0.02636768474173598 > ./result_6chains/node476_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node476_4_2 -p 733 -st topic476_4_1 -pt None -u 0.05606960610408465 > ./result_6chains/node476_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node476_5_2 -p 989 -st topic476_5_1 -pt None -u 0.007098157261631272 > ./result_6chains/node476_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node476_0_0 -p 179 -st none -pt topic476_0_0 -u 0.05509315563134837 > ./result_6chains/node476_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node476_1_0 -p 266 -st none -pt topic476_1_0 -u 0.0015667482488989082 > ./result_6chains/node476_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node476_2_0 -p 432 -st none -pt topic476_2_0 -u 0.047394743744213874 > ./result_6chains/node476_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node476_3_0 -p 706 -st none -pt topic476_3_0 -u 0.03433791536113645 > ./result_6chains/node476_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node476_4_0 -p 733 -st none -pt topic476_4_0 -u 0.005941970590013834 > ./result_6chains/node476_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node476_5_0 -p 989 -st none -pt topic476_5_0 -u 0.009013224340740159 > ./result_6chains/node476_5_0.txt &
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
    "./result_6chains/node476_0_0.txt 90"
    "./result_6chains/node476_0_2.txt 90"
    "./result_6chains/node476_1_0.txt 89"
    "./result_6chains/node476_1_2.txt 89"
    "./result_6chains/node476_2_0.txt 88"
    "./result_6chains/node476_2_2.txt 88"
    "./result_6chains/node476_3_0.txt 87"
    "./result_6chains/node476_3_2.txt 87"
    "./result_6chains/node476_4_0.txt 86"
    "./result_6chains/node476_4_2.txt 86"
    "./result_6chains/node476_5_0.txt 85"
    "./result_6chains/node476_5_2.txt 85"
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
