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
ros2 run evaluation_3_randomdag uunifast_node -n node194_0_2 -p 43 -st topic194_0_1 -pt None -u 0.03527731586532146 > ./result_8chains/node194_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node194_1_2 -p 145 -st topic194_1_1 -pt None -u 0.030237932448828997 > ./result_8chains/node194_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node194_2_2 -p 147 -st topic194_2_1 -pt None -u 0.0022419925590097256 > ./result_8chains/node194_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node194_3_2 -p 399 -st topic194_3_1 -pt None -u 0.01134624368296655 > ./result_8chains/node194_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node194_4_2 -p 631 -st topic194_4_1 -pt None -u 0.009041692819683117 > ./result_8chains/node194_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node194_5_2 -p 663 -st topic194_5_1 -pt None -u 0.010609334392934572 > ./result_8chains/node194_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node194_6_2 -p 677 -st topic194_6_1 -pt None -u 0.004661554044508423 > ./result_8chains/node194_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node194_7_2 -p 812 -st topic194_7_1 -pt None -u 0.020523556342794926 > ./result_8chains/node194_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node194_0_0 -p 43 -st none -pt topic194_0_0 -u 0.04572982160483324 > ./result_8chains/node194_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node194_1_0 -p 145 -st none -pt topic194_1_0 -u 0.02691830375010379 > ./result_8chains/node194_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node194_2_0 -p 147 -st none -pt topic194_2_0 -u 0.08102478512838296 > ./result_8chains/node194_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node194_3_0 -p 399 -st none -pt topic194_3_0 -u 0.024348310163662817 > ./result_8chains/node194_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node194_4_0 -p 631 -st none -pt topic194_4_0 -u 0.0013849302342389957 > ./result_8chains/node194_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node194_5_0 -p 663 -st none -pt topic194_5_0 -u 0.01906083890600027 > ./result_8chains/node194_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node194_6_0 -p 677 -st none -pt topic194_6_0 -u 0.055715633109802126 > ./result_8chains/node194_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node194_7_0 -p 812 -st none -pt topic194_7_0 -u 0.010849262165615471 > ./result_8chains/node194_7_0.txt &
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
    "./result_8chains/node194_0_0.txt 90"
    "./result_8chains/node194_0_2.txt 90"
    "./result_8chains/node194_1_0.txt 89"
    "./result_8chains/node194_1_2.txt 89"
    "./result_8chains/node194_2_0.txt 88"
    "./result_8chains/node194_2_2.txt 88"
    "./result_8chains/node194_3_0.txt 87"
    "./result_8chains/node194_3_2.txt 87"
    "./result_8chains/node194_4_0.txt 86"
    "./result_8chains/node194_4_2.txt 86"
    "./result_8chains/node194_5_0.txt 85"
    "./result_8chains/node194_5_2.txt 85"
    "./result_8chains/node194_6_0.txt 84"
    "./result_8chains/node194_6_2.txt 84"
    "./result_8chains/node194_7_0.txt 83"
    "./result_8chains/node194_7_2.txt 83"
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
