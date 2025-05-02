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
ros2 run evaluation_3_randomdag uunifast_node -n node461_0_2 -p 169 -st topic461_0_1 -pt None -u 0.00991558395567993 > ./result_8chains/node461_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node461_1_2 -p 277 -st topic461_1_1 -pt None -u 0.0023999328178762602 > ./result_8chains/node461_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node461_2_2 -p 452 -st topic461_2_1 -pt None -u 0.0015232314294127969 > ./result_8chains/node461_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node461_3_2 -p 517 -st topic461_3_1 -pt None -u 0.013040202681468993 > ./result_8chains/node461_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node461_4_2 -p 548 -st topic461_4_1 -pt None -u 0.08057784721047567 > ./result_8chains/node461_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node461_5_2 -p 580 -st topic461_5_1 -pt None -u 0.015177276886984295 > ./result_8chains/node461_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node461_6_2 -p 759 -st topic461_6_1 -pt None -u 0.025437672914438957 > ./result_8chains/node461_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node461_7_2 -p 786 -st topic461_7_1 -pt None -u 0.011470720250541619 > ./result_8chains/node461_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node461_0_0 -p 169 -st none -pt topic461_0_0 -u 0.02213474408289512 > ./result_8chains/node461_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node461_1_0 -p 277 -st none -pt topic461_1_0 -u 0.010700369218068329 > ./result_8chains/node461_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node461_2_0 -p 452 -st none -pt topic461_2_0 -u 0.007485016120082566 > ./result_8chains/node461_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node461_3_0 -p 517 -st none -pt topic461_3_0 -u 0.026604349902957347 > ./result_8chains/node461_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node461_4_0 -p 548 -st none -pt topic461_4_0 -u 0.017944712177085098 > ./result_8chains/node461_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node461_5_0 -p 580 -st none -pt topic461_5_0 -u 0.00911801543462093 > ./result_8chains/node461_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node461_6_0 -p 759 -st none -pt topic461_6_0 -u 0.00977519724391547 > ./result_8chains/node461_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node461_7_0 -p 786 -st none -pt topic461_7_0 -u 0.001551860087573298 > ./result_8chains/node461_7_0.txt &
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
    "./result_8chains/node461_0_0.txt 90"
    "./result_8chains/node461_0_2.txt 90"
    "./result_8chains/node461_1_0.txt 89"
    "./result_8chains/node461_1_2.txt 89"
    "./result_8chains/node461_2_0.txt 88"
    "./result_8chains/node461_2_2.txt 88"
    "./result_8chains/node461_3_0.txt 87"
    "./result_8chains/node461_3_2.txt 87"
    "./result_8chains/node461_4_0.txt 86"
    "./result_8chains/node461_4_2.txt 86"
    "./result_8chains/node461_5_0.txt 85"
    "./result_8chains/node461_5_2.txt 85"
    "./result_8chains/node461_6_0.txt 84"
    "./result_8chains/node461_6_2.txt 84"
    "./result_8chains/node461_7_0.txt 83"
    "./result_8chains/node461_7_2.txt 83"
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
