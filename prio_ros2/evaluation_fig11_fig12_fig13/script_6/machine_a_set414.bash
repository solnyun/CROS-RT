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
ros2 run evaluation_3_randomdag uunifast_node -n node414_0_2 -p 179 -st topic414_0_1 -pt None -u 0.037506513596160695 > ./result_6chains/node414_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node414_1_2 -p 208 -st topic414_1_1 -pt None -u 0.004131107479769525 > ./result_6chains/node414_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node414_2_2 -p 425 -st topic414_2_1 -pt None -u 0.000752898692653714 > ./result_6chains/node414_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node414_3_2 -p 443 -st topic414_3_1 -pt None -u 0.11405996717462281 > ./result_6chains/node414_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node414_4_2 -p 796 -st topic414_4_1 -pt None -u 0.021500753289206413 > ./result_6chains/node414_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node414_5_2 -p 941 -st topic414_5_1 -pt None -u 0.005477230524258303 > ./result_6chains/node414_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node414_0_0 -p 179 -st none -pt topic414_0_0 -u 0.00036943056408089703 > ./result_6chains/node414_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node414_1_0 -p 208 -st none -pt topic414_1_0 -u 0.11959982447579814 > ./result_6chains/node414_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node414_2_0 -p 425 -st none -pt topic414_2_0 -u 0.018193408919559784 > ./result_6chains/node414_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node414_3_0 -p 443 -st none -pt topic414_3_0 -u 0.028502608703287108 > ./result_6chains/node414_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node414_4_0 -p 796 -st none -pt topic414_4_0 -u 0.013504004699049263 > ./result_6chains/node414_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node414_5_0 -p 941 -st none -pt topic414_5_0 -u 0.030877409334456693 > ./result_6chains/node414_5_0.txt &
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
    "./result_6chains/node414_0_0.txt 90"
    "./result_6chains/node414_0_2.txt 90"
    "./result_6chains/node414_1_0.txt 89"
    "./result_6chains/node414_1_2.txt 89"
    "./result_6chains/node414_2_0.txt 88"
    "./result_6chains/node414_2_2.txt 88"
    "./result_6chains/node414_3_0.txt 87"
    "./result_6chains/node414_3_2.txt 87"
    "./result_6chains/node414_4_0.txt 86"
    "./result_6chains/node414_4_2.txt 86"
    "./result_6chains/node414_5_0.txt 85"
    "./result_6chains/node414_5_2.txt 85"
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
