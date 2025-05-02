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
ros2 run evaluation_3_randomdag uunifast_node -n node377_0_2 -p 136 -st topic377_0_1 -pt None -u 0.010866197095452057 > ./result_10chains/node377_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node377_1_2 -p 175 -st topic377_1_1 -pt None -u 0.00286201827049265 > ./result_10chains/node377_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node377_2_2 -p 283 -st topic377_2_1 -pt None -u 0.011709158560865518 > ./result_10chains/node377_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node377_3_2 -p 448 -st topic377_3_1 -pt None -u 0.0017790175287689114 > ./result_10chains/node377_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node377_4_2 -p 555 -st topic377_4_1 -pt None -u 0.03734537439988317 > ./result_10chains/node377_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node377_5_2 -p 710 -st topic377_5_1 -pt None -u 0.0013437541049372559 > ./result_10chains/node377_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node377_6_2 -p 743 -st topic377_6_1 -pt None -u 0.005311164829072734 > ./result_10chains/node377_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node377_7_2 -p 858 -st topic377_7_1 -pt None -u 0.009060563556247 > ./result_10chains/node377_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node377_8_2 -p 869 -st topic377_8_1 -pt None -u 0.02764918483206294 > ./result_10chains/node377_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node377_9_2 -p 931 -st topic377_9_1 -pt None -u 0.003383907743599374 > ./result_10chains/node377_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node377_0_0 -p 136 -st none -pt topic377_0_0 -u 0.006417781361799435 > ./result_10chains/node377_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node377_1_0 -p 175 -st none -pt topic377_1_0 -u 0.0037803443101290246 > ./result_10chains/node377_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node377_2_0 -p 283 -st none -pt topic377_2_0 -u 0.015705494545925958 > ./result_10chains/node377_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node377_3_0 -p 448 -st none -pt topic377_3_0 -u 0.024287686887417448 > ./result_10chains/node377_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node377_4_0 -p 555 -st none -pt topic377_4_0 -u 0.029941212157596875 > ./result_10chains/node377_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node377_5_0 -p 710 -st none -pt topic377_5_0 -u 0.0311106171522208 > ./result_10chains/node377_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node377_6_0 -p 743 -st none -pt topic377_6_0 -u 0.0264532215886166 > ./result_10chains/node377_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node377_7_0 -p 858 -st none -pt topic377_7_0 -u 0.011886651805600529 > ./result_10chains/node377_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node377_8_0 -p 869 -st none -pt topic377_8_0 -u 0.020552806707535537 > ./result_10chains/node377_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node377_9_0 -p 931 -st none -pt topic377_9_0 -u 0.015419356612582834 > ./result_10chains/node377_9_0.txt &
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
    "./result_10chains/node377_0_0.txt 90"
    "./result_10chains/node377_0_2.txt 90"
    "./result_10chains/node377_1_0.txt 89"
    "./result_10chains/node377_1_2.txt 89"
    "./result_10chains/node377_2_0.txt 88"
    "./result_10chains/node377_2_2.txt 88"
    "./result_10chains/node377_3_0.txt 87"
    "./result_10chains/node377_3_2.txt 87"
    "./result_10chains/node377_4_0.txt 86"
    "./result_10chains/node377_4_2.txt 86"
    "./result_10chains/node377_5_0.txt 85"
    "./result_10chains/node377_5_2.txt 85"
    "./result_10chains/node377_6_0.txt 84"
    "./result_10chains/node377_6_2.txt 84"
    "./result_10chains/node377_7_0.txt 83"
    "./result_10chains/node377_7_2.txt 83"
    "./result_10chains/node377_8_0.txt 82"
    "./result_10chains/node377_8_2.txt 82"
    "./result_10chains/node377_9_0.txt 81"
    "./result_10chains/node377_9_2.txt 81"
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
