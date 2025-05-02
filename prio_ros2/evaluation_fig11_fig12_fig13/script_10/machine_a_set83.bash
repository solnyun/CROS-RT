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
ros2 run evaluation_3_randomdag uunifast_node -n node83_0_2 -p 63 -st topic83_0_1 -pt None -u 0.03178746466077914 > ./result_10chains/node83_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node83_1_2 -p 70 -st topic83_1_1 -pt None -u 0.013032371654183361 > ./result_10chains/node83_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node83_2_2 -p 136 -st topic83_2_1 -pt None -u 0.005910225747196962 > ./result_10chains/node83_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node83_3_2 -p 288 -st topic83_3_1 -pt None -u 0.0045267718021573256 > ./result_10chains/node83_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node83_4_2 -p 321 -st topic83_4_1 -pt None -u 0.010460632594337882 > ./result_10chains/node83_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node83_5_2 -p 373 -st topic83_5_1 -pt None -u 0.017390789475482032 > ./result_10chains/node83_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node83_6_2 -p 485 -st topic83_6_1 -pt None -u 0.004115376342724103 > ./result_10chains/node83_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node83_7_2 -p 764 -st topic83_7_1 -pt None -u 0.008875696509247188 > ./result_10chains/node83_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node83_8_2 -p 952 -st topic83_8_1 -pt None -u 0.031589122057299954 > ./result_10chains/node83_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node83_9_2 -p 988 -st topic83_9_1 -pt None -u 0.032812207416199425 > ./result_10chains/node83_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node83_0_0 -p 63 -st none -pt topic83_0_0 -u 0.0025091458932410826 > ./result_10chains/node83_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node83_1_0 -p 70 -st none -pt topic83_1_0 -u 0.001002841978095692 > ./result_10chains/node83_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node83_2_0 -p 136 -st none -pt topic83_2_0 -u 0.0006168333255645031 > ./result_10chains/node83_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node83_3_0 -p 288 -st none -pt topic83_3_0 -u 0.017758767455535007 > ./result_10chains/node83_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node83_4_0 -p 321 -st none -pt topic83_4_0 -u 0.02604694202199065 > ./result_10chains/node83_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node83_5_0 -p 373 -st none -pt topic83_5_0 -u 0.05620152146195678 > ./result_10chains/node83_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node83_6_0 -p 485 -st none -pt topic83_6_0 -u 0.005449796342492097 > ./result_10chains/node83_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node83_7_0 -p 764 -st none -pt topic83_7_0 -u 0.013404062297731528 > ./result_10chains/node83_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node83_8_0 -p 952 -st none -pt topic83_8_0 -u 0.03337510933639802 > ./result_10chains/node83_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node83_9_0 -p 988 -st none -pt topic83_9_0 -u 0.0027946015127288115 > ./result_10chains/node83_9_0.txt &
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
    "./result_10chains/node83_0_0.txt 90"
    "./result_10chains/node83_0_2.txt 90"
    "./result_10chains/node83_1_0.txt 89"
    "./result_10chains/node83_1_2.txt 89"
    "./result_10chains/node83_2_0.txt 88"
    "./result_10chains/node83_2_2.txt 88"
    "./result_10chains/node83_3_0.txt 87"
    "./result_10chains/node83_3_2.txt 87"
    "./result_10chains/node83_4_0.txt 86"
    "./result_10chains/node83_4_2.txt 86"
    "./result_10chains/node83_5_0.txt 85"
    "./result_10chains/node83_5_2.txt 85"
    "./result_10chains/node83_6_0.txt 84"
    "./result_10chains/node83_6_2.txt 84"
    "./result_10chains/node83_7_0.txt 83"
    "./result_10chains/node83_7_2.txt 83"
    "./result_10chains/node83_8_0.txt 82"
    "./result_10chains/node83_8_2.txt 82"
    "./result_10chains/node83_9_0.txt 81"
    "./result_10chains/node83_9_2.txt 81"
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
