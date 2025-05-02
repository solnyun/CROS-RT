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
ros2 run evaluation_3_randomdag uunifast_node -n node373_0_2 -p 65 -st topic373_0_1 -pt None -u 0.007839510878311085 > ./result_6chains/node373_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node373_1_2 -p 286 -st topic373_1_1 -pt None -u 0.02350862689271299 > ./result_6chains/node373_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node373_2_2 -p 379 -st topic373_2_1 -pt None -u 0.05314429329099235 > ./result_6chains/node373_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node373_3_2 -p 709 -st topic373_3_1 -pt None -u 0.05857069803806936 > ./result_6chains/node373_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node373_4_2 -p 718 -st topic373_4_1 -pt None -u 0.022711142801125975 > ./result_6chains/node373_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node373_5_2 -p 841 -st topic373_5_1 -pt None -u 0.04916920083011401 > ./result_6chains/node373_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node373_0_0 -p 65 -st none -pt topic373_0_0 -u 0.0684018829975852 > ./result_6chains/node373_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node373_1_0 -p 286 -st none -pt topic373_1_0 -u 0.017226033619675007 > ./result_6chains/node373_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node373_2_0 -p 379 -st none -pt topic373_2_0 -u 0.014654485347371293 > ./result_6chains/node373_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node373_3_0 -p 709 -st none -pt topic373_3_0 -u 0.01203555012490315 > ./result_6chains/node373_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node373_4_0 -p 718 -st none -pt topic373_4_0 -u 0.0036190190143943757 > ./result_6chains/node373_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node373_5_0 -p 841 -st none -pt topic373_5_0 -u 0.053210147767548927 > ./result_6chains/node373_5_0.txt &
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
    "./result_6chains/node373_0_0.txt 90"
    "./result_6chains/node373_0_2.txt 90"
    "./result_6chains/node373_1_0.txt 89"
    "./result_6chains/node373_1_2.txt 89"
    "./result_6chains/node373_2_0.txt 88"
    "./result_6chains/node373_2_2.txt 88"
    "./result_6chains/node373_3_0.txt 87"
    "./result_6chains/node373_3_2.txt 87"
    "./result_6chains/node373_4_0.txt 86"
    "./result_6chains/node373_4_2.txt 86"
    "./result_6chains/node373_5_0.txt 85"
    "./result_6chains/node373_5_2.txt 85"
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
