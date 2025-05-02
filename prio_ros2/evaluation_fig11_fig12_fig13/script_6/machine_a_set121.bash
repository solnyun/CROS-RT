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
ros2 run evaluation_3_randomdag uunifast_node -n node121_0_2 -p 12 -st topic121_0_1 -pt None -u 0.03723148147382227 > ./result_6chains/node121_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node121_1_2 -p 63 -st topic121_1_1 -pt None -u 0.035513612716955634 > ./result_6chains/node121_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node121_2_2 -p 374 -st topic121_2_1 -pt None -u 0.01340163235884545 > ./result_6chains/node121_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node121_3_2 -p 506 -st topic121_3_1 -pt None -u 0.008190796645006992 > ./result_6chains/node121_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node121_4_2 -p 552 -st topic121_4_1 -pt None -u 0.052504738605046786 > ./result_6chains/node121_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node121_5_2 -p 621 -st topic121_5_1 -pt None -u 0.021130390921004927 > ./result_6chains/node121_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node121_0_0 -p 12 -st none -pt topic121_0_0 -u 0.03347603793118864 > ./result_6chains/node121_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node121_1_0 -p 63 -st none -pt topic121_1_0 -u 0.008787402698316016 > ./result_6chains/node121_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node121_2_0 -p 374 -st none -pt topic121_2_0 -u 0.016976786848160008 > ./result_6chains/node121_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node121_3_0 -p 506 -st none -pt topic121_3_0 -u 0.01215905803534989 > ./result_6chains/node121_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node121_4_0 -p 552 -st none -pt topic121_4_0 -u 0.027706756265390486 > ./result_6chains/node121_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node121_5_0 -p 621 -st none -pt topic121_5_0 -u 0.004315041286772951 > ./result_6chains/node121_5_0.txt &
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
    "./result_6chains/node121_0_0.txt 90"
    "./result_6chains/node121_0_2.txt 90"
    "./result_6chains/node121_1_0.txt 89"
    "./result_6chains/node121_1_2.txt 89"
    "./result_6chains/node121_2_0.txt 88"
    "./result_6chains/node121_2_2.txt 88"
    "./result_6chains/node121_3_0.txt 87"
    "./result_6chains/node121_3_2.txt 87"
    "./result_6chains/node121_4_0.txt 86"
    "./result_6chains/node121_4_2.txt 86"
    "./result_6chains/node121_5_0.txt 85"
    "./result_6chains/node121_5_2.txt 85"
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
