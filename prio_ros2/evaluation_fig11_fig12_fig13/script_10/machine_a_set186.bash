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
ros2 run evaluation_3_randomdag uunifast_node -n node186_0_2 -p 12 -st topic186_0_1 -pt None -u 0.012685258268207322 > ./result_10chains/node186_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node186_1_2 -p 165 -st topic186_1_1 -pt None -u 0.008340284721531532 > ./result_10chains/node186_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node186_2_2 -p 181 -st topic186_2_1 -pt None -u 0.0282559158017317 > ./result_10chains/node186_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node186_3_2 -p 213 -st topic186_3_1 -pt None -u 0.0035214986108502155 > ./result_10chains/node186_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node186_4_2 -p 350 -st topic186_4_1 -pt None -u 0.006851956777767176 > ./result_10chains/node186_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node186_5_2 -p 413 -st topic186_5_1 -pt None -u 0.006207248658012143 > ./result_10chains/node186_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node186_6_2 -p 596 -st topic186_6_1 -pt None -u 0.009602461492705106 > ./result_10chains/node186_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node186_7_2 -p 610 -st topic186_7_1 -pt None -u 0.056854128373510227 > ./result_10chains/node186_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node186_8_2 -p 628 -st topic186_8_1 -pt None -u 0.03873795482666641 > ./result_10chains/node186_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node186_9_2 -p 723 -st topic186_9_1 -pt None -u 0.002198553488748196 > ./result_10chains/node186_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node186_0_0 -p 12 -st none -pt topic186_0_0 -u 0.005923598765916582 > ./result_10chains/node186_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node186_1_0 -p 165 -st none -pt topic186_1_0 -u 0.003569499692358924 > ./result_10chains/node186_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node186_2_0 -p 181 -st none -pt topic186_2_0 -u 0.0024285795464062954 > ./result_10chains/node186_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node186_3_0 -p 213 -st none -pt topic186_3_0 -u 0.0017542798527183656 > ./result_10chains/node186_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node186_4_0 -p 350 -st none -pt topic186_4_0 -u 0.0023185822740174333 > ./result_10chains/node186_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node186_5_0 -p 413 -st none -pt topic186_5_0 -u 0.03432501275278915 > ./result_10chains/node186_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node186_6_0 -p 596 -st none -pt topic186_6_0 -u 0.020550093819566184 > ./result_10chains/node186_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node186_7_0 -p 610 -st none -pt topic186_7_0 -u 0.020744242474258212 > ./result_10chains/node186_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node186_8_0 -p 628 -st none -pt topic186_8_0 -u 0.03567318253929028 > ./result_10chains/node186_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node186_9_0 -p 723 -st none -pt topic186_9_0 -u 0.002486687085751893 > ./result_10chains/node186_9_0.txt &
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
    "./result_10chains/node186_0_0.txt 90"
    "./result_10chains/node186_0_2.txt 90"
    "./result_10chains/node186_1_0.txt 89"
    "./result_10chains/node186_1_2.txt 89"
    "./result_10chains/node186_2_0.txt 88"
    "./result_10chains/node186_2_2.txt 88"
    "./result_10chains/node186_3_0.txt 87"
    "./result_10chains/node186_3_2.txt 87"
    "./result_10chains/node186_4_0.txt 86"
    "./result_10chains/node186_4_2.txt 86"
    "./result_10chains/node186_5_0.txt 85"
    "./result_10chains/node186_5_2.txt 85"
    "./result_10chains/node186_6_0.txt 84"
    "./result_10chains/node186_6_2.txt 84"
    "./result_10chains/node186_7_0.txt 83"
    "./result_10chains/node186_7_2.txt 83"
    "./result_10chains/node186_8_0.txt 82"
    "./result_10chains/node186_8_2.txt 82"
    "./result_10chains/node186_9_0.txt 81"
    "./result_10chains/node186_9_2.txt 81"
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
sleep 190s
sudo pkill -USR1 uunifast_node
echo "Set timer signal!"
sleep 200s
echo "End Running"
sudo pkill uunifast_node
finalize_framework
/home/orin5/prio_ros2/evaluation_2_fig10/send_signal 127.0.0.1 9999
