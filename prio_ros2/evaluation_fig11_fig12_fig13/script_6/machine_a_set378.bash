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
ros2 run evaluation_3_randomdag uunifast_node -n node378_0_2 -p 421 -st topic378_0_1 -pt None -u 0.011009850663618037 > ./result_6chains/node378_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node378_1_2 -p 632 -st topic378_1_1 -pt None -u 0.008492546391250688 > ./result_6chains/node378_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node378_2_2 -p 672 -st topic378_2_1 -pt None -u 0.015267779869109044 > ./result_6chains/node378_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node378_3_2 -p 704 -st topic378_3_1 -pt None -u 0.011616631548619027 > ./result_6chains/node378_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node378_4_2 -p 792 -st topic378_4_1 -pt None -u 0.07385899231083186 > ./result_6chains/node378_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node378_5_2 -p 813 -st topic378_5_1 -pt None -u 0.0675117201589043 > ./result_6chains/node378_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node378_0_0 -p 421 -st none -pt topic378_0_0 -u 0.005999735487041136 > ./result_6chains/node378_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node378_1_0 -p 632 -st none -pt topic378_1_0 -u 0.005906957872844787 > ./result_6chains/node378_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node378_2_0 -p 672 -st none -pt topic378_2_0 -u 0.016533227974501852 > ./result_6chains/node378_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node378_3_0 -p 704 -st none -pt topic378_3_0 -u 0.010015611472907249 > ./result_6chains/node378_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node378_4_0 -p 792 -st none -pt topic378_4_0 -u 0.01718130330049633 > ./result_6chains/node378_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node378_5_0 -p 813 -st none -pt topic378_5_0 -u 0.012679600380116007 > ./result_6chains/node378_5_0.txt &
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
    "./result_6chains/node378_0_0.txt 90"
    "./result_6chains/node378_0_2.txt 90"
    "./result_6chains/node378_1_0.txt 89"
    "./result_6chains/node378_1_2.txt 89"
    "./result_6chains/node378_2_0.txt 88"
    "./result_6chains/node378_2_2.txt 88"
    "./result_6chains/node378_3_0.txt 87"
    "./result_6chains/node378_3_2.txt 87"
    "./result_6chains/node378_4_0.txt 86"
    "./result_6chains/node378_4_2.txt 86"
    "./result_6chains/node378_5_0.txt 85"
    "./result_6chains/node378_5_2.txt 85"
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
