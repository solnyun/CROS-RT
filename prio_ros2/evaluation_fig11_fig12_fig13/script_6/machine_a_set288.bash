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
ros2 run evaluation_3_randomdag uunifast_node -n node288_0_2 -p 108 -st topic288_0_1 -pt None -u 0.06054105306465846 > ./result_6chains/node288_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node288_1_2 -p 125 -st topic288_1_1 -pt None -u 0.07840604665654788 > ./result_6chains/node288_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node288_2_2 -p 237 -st topic288_2_1 -pt None -u 0.07963896842519103 > ./result_6chains/node288_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node288_3_2 -p 371 -st topic288_3_1 -pt None -u 0.028595502760301955 > ./result_6chains/node288_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node288_4_2 -p 566 -st topic288_4_1 -pt None -u 0.006722716584140434 > ./result_6chains/node288_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node288_5_2 -p 820 -st topic288_5_1 -pt None -u 0.0033059974026954783 > ./result_6chains/node288_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node288_0_0 -p 108 -st none -pt topic288_0_0 -u 0.007704049064190144 > ./result_6chains/node288_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node288_1_0 -p 125 -st none -pt topic288_1_0 -u 0.005144566700241826 > ./result_6chains/node288_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node288_2_0 -p 237 -st none -pt topic288_2_0 -u 0.005024938436778148 > ./result_6chains/node288_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node288_3_0 -p 371 -st none -pt topic288_3_0 -u 0.02056014438846504 > ./result_6chains/node288_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node288_4_0 -p 566 -st none -pt topic288_4_0 -u 0.0054883504719479 > ./result_6chains/node288_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node288_5_0 -p 820 -st none -pt topic288_5_0 -u 0.04439425495975757 > ./result_6chains/node288_5_0.txt &
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
    "./result_6chains/node288_0_0.txt 90"
    "./result_6chains/node288_0_2.txt 90"
    "./result_6chains/node288_1_0.txt 89"
    "./result_6chains/node288_1_2.txt 89"
    "./result_6chains/node288_2_0.txt 88"
    "./result_6chains/node288_2_2.txt 88"
    "./result_6chains/node288_3_0.txt 87"
    "./result_6chains/node288_3_2.txt 87"
    "./result_6chains/node288_4_0.txt 86"
    "./result_6chains/node288_4_2.txt 86"
    "./result_6chains/node288_5_0.txt 85"
    "./result_6chains/node288_5_2.txt 85"
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
