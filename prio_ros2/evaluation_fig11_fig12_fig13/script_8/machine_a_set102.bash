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
ros2 run evaluation_3_randomdag uunifast_node -n node102_0_2 -p 136 -st topic102_0_1 -pt None -u 0.004738673744052402 > ./result_8chains/node102_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node102_1_2 -p 227 -st topic102_1_1 -pt None -u 0.03160799422994509 > ./result_8chains/node102_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node102_2_2 -p 299 -st topic102_2_1 -pt None -u 0.00500152234680068 > ./result_8chains/node102_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node102_3_2 -p 505 -st topic102_3_1 -pt None -u 0.04831693668887255 > ./result_8chains/node102_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node102_4_2 -p 552 -st topic102_4_1 -pt None -u 0.006710136241044912 > ./result_8chains/node102_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node102_5_2 -p 748 -st topic102_5_1 -pt None -u 0.05842448212196563 > ./result_8chains/node102_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node102_6_2 -p 754 -st topic102_6_1 -pt None -u 0.006389826415397724 > ./result_8chains/node102_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node102_7_2 -p 760 -st topic102_7_1 -pt None -u 0.04615459230687959 > ./result_8chains/node102_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node102_0_0 -p 136 -st none -pt topic102_0_0 -u 0.004076830859270852 > ./result_8chains/node102_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node102_1_0 -p 227 -st none -pt topic102_1_0 -u 0.003616449434412139 > ./result_8chains/node102_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node102_2_0 -p 299 -st none -pt topic102_2_0 -u 0.006073948158938247 > ./result_8chains/node102_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node102_3_0 -p 505 -st none -pt topic102_3_0 -u 0.021780188453519034 > ./result_8chains/node102_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node102_4_0 -p 552 -st none -pt topic102_4_0 -u 0.018158659026630164 > ./result_8chains/node102_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node102_5_0 -p 748 -st none -pt topic102_5_0 -u 0.013350843505932686 > ./result_8chains/node102_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node102_6_0 -p 754 -st none -pt topic102_6_0 -u 0.04390127017465266 > ./result_8chains/node102_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node102_7_0 -p 760 -st none -pt topic102_7_0 -u 0.006044958939688053 > ./result_8chains/node102_7_0.txt &
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
    "./result_8chains/node102_0_0.txt 90"
    "./result_8chains/node102_0_2.txt 90"
    "./result_8chains/node102_1_0.txt 89"
    "./result_8chains/node102_1_2.txt 89"
    "./result_8chains/node102_2_0.txt 88"
    "./result_8chains/node102_2_2.txt 88"
    "./result_8chains/node102_3_0.txt 87"
    "./result_8chains/node102_3_2.txt 87"
    "./result_8chains/node102_4_0.txt 86"
    "./result_8chains/node102_4_2.txt 86"
    "./result_8chains/node102_5_0.txt 85"
    "./result_8chains/node102_5_2.txt 85"
    "./result_8chains/node102_6_0.txt 84"
    "./result_8chains/node102_6_2.txt 84"
    "./result_8chains/node102_7_0.txt 83"
    "./result_8chains/node102_7_2.txt 83"
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
