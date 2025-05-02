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
ros2 run evaluation_3_randomdag uunifast_node -n node390_0_2 -p 115 -st topic390_0_1 -pt None -u 0.011189586345668079 > ./result_6chains/node390_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node390_1_2 -p 181 -st topic390_1_1 -pt None -u 0.06784650067810244 > ./result_6chains/node390_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node390_2_2 -p 374 -st topic390_2_1 -pt None -u 0.014914375413233039 > ./result_6chains/node390_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node390_3_2 -p 510 -st topic390_3_1 -pt None -u 0.0004935506969998005 > ./result_6chains/node390_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node390_4_2 -p 779 -st topic390_4_1 -pt None -u 0.04087650714983457 > ./result_6chains/node390_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node390_5_2 -p 832 -st topic390_5_1 -pt None -u 0.05650121452478275 > ./result_6chains/node390_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node390_0_0 -p 115 -st none -pt topic390_0_0 -u 0.0428419420434718 > ./result_6chains/node390_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node390_1_0 -p 181 -st none -pt topic390_1_0 -u 0.018381534744052186 > ./result_6chains/node390_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node390_2_0 -p 374 -st none -pt topic390_2_0 -u 0.0679393359517419 > ./result_6chains/node390_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node390_3_0 -p 510 -st none -pt topic390_3_0 -u 0.00893830003356147 > ./result_6chains/node390_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node390_4_0 -p 779 -st none -pt topic390_4_0 -u 0.012100954573145667 > ./result_6chains/node390_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node390_5_0 -p 832 -st none -pt topic390_5_0 -u 0.016168015176548894 > ./result_6chains/node390_5_0.txt &
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
    "./result_6chains/node390_0_0.txt 90"
    "./result_6chains/node390_0_2.txt 90"
    "./result_6chains/node390_1_0.txt 89"
    "./result_6chains/node390_1_2.txt 89"
    "./result_6chains/node390_2_0.txt 88"
    "./result_6chains/node390_2_2.txt 88"
    "./result_6chains/node390_3_0.txt 87"
    "./result_6chains/node390_3_2.txt 87"
    "./result_6chains/node390_4_0.txt 86"
    "./result_6chains/node390_4_2.txt 86"
    "./result_6chains/node390_5_0.txt 85"
    "./result_6chains/node390_5_2.txt 85"
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
