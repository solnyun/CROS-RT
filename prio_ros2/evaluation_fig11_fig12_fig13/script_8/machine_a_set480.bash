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
ros2 run evaluation_3_randomdag uunifast_node -n node480_0_2 -p 112 -st topic480_0_1 -pt None -u 0.005066635937850339 > ./result_8chains/node480_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node480_1_2 -p 114 -st topic480_1_1 -pt None -u 0.018536542630568975 > ./result_8chains/node480_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node480_2_2 -p 135 -st topic480_2_1 -pt None -u 0.008480590575739633 > ./result_8chains/node480_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node480_3_2 -p 280 -st topic480_3_1 -pt None -u 0.0038454642893612223 > ./result_8chains/node480_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node480_4_2 -p 305 -st topic480_4_1 -pt None -u 0.0018960269269665542 > ./result_8chains/node480_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node480_5_2 -p 320 -st topic480_5_1 -pt None -u 0.01428387980749693 > ./result_8chains/node480_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node480_6_2 -p 865 -st topic480_6_1 -pt None -u 0.035443671309475566 > ./result_8chains/node480_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node480_7_2 -p 888 -st topic480_7_1 -pt None -u 9.658828487146758e-05 > ./result_8chains/node480_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node480_0_0 -p 112 -st none -pt topic480_0_0 -u 0.033561370626187415 > ./result_8chains/node480_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node480_1_0 -p 114 -st none -pt topic480_1_0 -u 0.04763522984201224 > ./result_8chains/node480_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node480_2_0 -p 135 -st none -pt topic480_2_0 -u 0.0347468623480921 > ./result_8chains/node480_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node480_3_0 -p 280 -st none -pt topic480_3_0 -u 0.0075973469562976015 > ./result_8chains/node480_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node480_4_0 -p 305 -st none -pt topic480_4_0 -u 0.005185460076099491 > ./result_8chains/node480_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node480_5_0 -p 320 -st none -pt topic480_5_0 -u 0.008944795009987405 > ./result_8chains/node480_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node480_6_0 -p 865 -st none -pt topic480_6_0 -u 0.00014630432400189464 > ./result_8chains/node480_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node480_7_0 -p 888 -st none -pt topic480_7_0 -u 0.10399764128836324 > ./result_8chains/node480_7_0.txt &
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
    "./result_8chains/node480_0_0.txt 90"
    "./result_8chains/node480_0_2.txt 90"
    "./result_8chains/node480_1_0.txt 89"
    "./result_8chains/node480_1_2.txt 89"
    "./result_8chains/node480_2_0.txt 88"
    "./result_8chains/node480_2_2.txt 88"
    "./result_8chains/node480_3_0.txt 87"
    "./result_8chains/node480_3_2.txt 87"
    "./result_8chains/node480_4_0.txt 86"
    "./result_8chains/node480_4_2.txt 86"
    "./result_8chains/node480_5_0.txt 85"
    "./result_8chains/node480_5_2.txt 85"
    "./result_8chains/node480_6_0.txt 84"
    "./result_8chains/node480_6_2.txt 84"
    "./result_8chains/node480_7_0.txt 83"
    "./result_8chains/node480_7_2.txt 83"
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
