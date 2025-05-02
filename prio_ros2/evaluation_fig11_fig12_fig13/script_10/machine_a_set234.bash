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
ros2 run evaluation_3_randomdag uunifast_node -n node234_0_2 -p 108 -st topic234_0_1 -pt None -u 0.011829343422496308 > ./result_10chains/node234_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node234_1_2 -p 296 -st topic234_1_1 -pt None -u 0.00966117814653622 > ./result_10chains/node234_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node234_2_2 -p 345 -st topic234_2_1 -pt None -u 0.00038612206188587406 > ./result_10chains/node234_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node234_3_2 -p 372 -st topic234_3_1 -pt None -u 0.0014997625310489981 > ./result_10chains/node234_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node234_4_2 -p 418 -st topic234_4_1 -pt None -u 0.044390644685532055 > ./result_10chains/node234_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node234_5_2 -p 531 -st topic234_5_1 -pt None -u 0.0082667200336895 > ./result_10chains/node234_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node234_6_2 -p 578 -st topic234_6_1 -pt None -u 0.0074082692249639315 > ./result_10chains/node234_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node234_7_2 -p 692 -st topic234_7_1 -pt None -u 0.01077759426383891 > ./result_10chains/node234_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node234_8_2 -p 731 -st topic234_8_1 -pt None -u 0.0439210108386534 > ./result_10chains/node234_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node234_9_2 -p 787 -st topic234_9_1 -pt None -u 0.002030028510224144 > ./result_10chains/node234_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node234_0_0 -p 108 -st none -pt topic234_0_0 -u 0.007235701498975788 > ./result_10chains/node234_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node234_1_0 -p 296 -st none -pt topic234_1_0 -u 0.01494478052925835 > ./result_10chains/node234_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node234_2_0 -p 345 -st none -pt topic234_2_0 -u 2.7366919590265937e-05 > ./result_10chains/node234_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node234_3_0 -p 372 -st none -pt topic234_3_0 -u 0.033861755358199686 > ./result_10chains/node234_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node234_4_0 -p 418 -st none -pt topic234_4_0 -u 0.003617841908302055 > ./result_10chains/node234_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node234_5_0 -p 531 -st none -pt topic234_5_0 -u 0.007826448563084898 > ./result_10chains/node234_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node234_6_0 -p 578 -st none -pt topic234_6_0 -u 0.007781870290452686 > ./result_10chains/node234_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node234_7_0 -p 692 -st none -pt topic234_7_0 -u 0.03158948901840014 > ./result_10chains/node234_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node234_8_0 -p 731 -st none -pt topic234_8_0 -u 0.017491293541875078 > ./result_10chains/node234_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node234_9_0 -p 787 -st none -pt topic234_9_0 -u 0.046000678935571714 > ./result_10chains/node234_9_0.txt &
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
    "./result_10chains/node234_0_0.txt 90"
    "./result_10chains/node234_0_2.txt 90"
    "./result_10chains/node234_1_0.txt 89"
    "./result_10chains/node234_1_2.txt 89"
    "./result_10chains/node234_2_0.txt 88"
    "./result_10chains/node234_2_2.txt 88"
    "./result_10chains/node234_3_0.txt 87"
    "./result_10chains/node234_3_2.txt 87"
    "./result_10chains/node234_4_0.txt 86"
    "./result_10chains/node234_4_2.txt 86"
    "./result_10chains/node234_5_0.txt 85"
    "./result_10chains/node234_5_2.txt 85"
    "./result_10chains/node234_6_0.txt 84"
    "./result_10chains/node234_6_2.txt 84"
    "./result_10chains/node234_7_0.txt 83"
    "./result_10chains/node234_7_2.txt 83"
    "./result_10chains/node234_8_0.txt 82"
    "./result_10chains/node234_8_2.txt 82"
    "./result_10chains/node234_9_0.txt 81"
    "./result_10chains/node234_9_2.txt 81"
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
