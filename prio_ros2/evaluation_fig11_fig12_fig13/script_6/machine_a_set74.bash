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
ros2 run evaluation_3_randomdag uunifast_node -n node74_0_2 -p 206 -st topic74_0_1 -pt None -u 0.012717033119085674 > ./result_6chains/node74_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node74_1_2 -p 315 -st topic74_1_1 -pt None -u 0.017369814666830852 > ./result_6chains/node74_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node74_2_2 -p 718 -st topic74_2_1 -pt None -u 0.006447014406185336 > ./result_6chains/node74_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node74_3_2 -p 852 -st topic74_3_1 -pt None -u 0.003280200801466321 > ./result_6chains/node74_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node74_4_2 -p 882 -st topic74_4_1 -pt None -u 0.07788799178080222 > ./result_6chains/node74_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node74_5_2 -p 992 -st topic74_5_1 -pt None -u 0.007163073313970619 > ./result_6chains/node74_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node74_0_0 -p 206 -st none -pt topic74_0_0 -u 0.04150523452630894 > ./result_6chains/node74_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node74_1_0 -p 315 -st none -pt topic74_1_0 -u 0.019693369755005796 > ./result_6chains/node74_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node74_2_0 -p 718 -st none -pt topic74_2_0 -u 0.020120848729030694 > ./result_6chains/node74_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node74_3_0 -p 852 -st none -pt topic74_3_0 -u 0.07263828451347143 > ./result_6chains/node74_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node74_4_0 -p 882 -st none -pt topic74_4_0 -u 0.03318765090611209 > ./result_6chains/node74_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node74_5_0 -p 992 -st none -pt topic74_5_0 -u 0.027035864883742995 > ./result_6chains/node74_5_0.txt &
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
    "./result_6chains/node74_0_0.txt 90"
    "./result_6chains/node74_0_2.txt 90"
    "./result_6chains/node74_1_0.txt 89"
    "./result_6chains/node74_1_2.txt 89"
    "./result_6chains/node74_2_0.txt 88"
    "./result_6chains/node74_2_2.txt 88"
    "./result_6chains/node74_3_0.txt 87"
    "./result_6chains/node74_3_2.txt 87"
    "./result_6chains/node74_4_0.txt 86"
    "./result_6chains/node74_4_2.txt 86"
    "./result_6chains/node74_5_0.txt 85"
    "./result_6chains/node74_5_2.txt 85"
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
