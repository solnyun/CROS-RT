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
ros2 run evaluation_3_randomdag uunifast_node -n node260_0_2 -p 159 -st topic260_0_1 -pt None -u 0.0029103059430264366 > ./result_10chains/node260_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node260_1_2 -p 230 -st topic260_1_1 -pt None -u 0.042715990369244006 > ./result_10chains/node260_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node260_2_2 -p 262 -st topic260_2_1 -pt None -u 0.008749332075122629 > ./result_10chains/node260_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node260_3_2 -p 272 -st topic260_3_1 -pt None -u 0.011373745597309026 > ./result_10chains/node260_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node260_4_2 -p 533 -st topic260_4_1 -pt None -u 0.025558435663117163 > ./result_10chains/node260_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node260_5_2 -p 544 -st topic260_5_1 -pt None -u 0.004616725889633466 > ./result_10chains/node260_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node260_6_2 -p 600 -st topic260_6_1 -pt None -u 0.017490460923924395 > ./result_10chains/node260_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node260_7_2 -p 772 -st topic260_7_1 -pt None -u 0.005231944828043955 > ./result_10chains/node260_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node260_8_2 -p 906 -st topic260_8_1 -pt None -u 0.07811864514733469 > ./result_10chains/node260_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node260_9_2 -p 951 -st topic260_9_1 -pt None -u 0.0022157071592975456 > ./result_10chains/node260_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node260_0_0 -p 159 -st none -pt topic260_0_0 -u 0.019439940332340755 > ./result_10chains/node260_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node260_1_0 -p 230 -st none -pt topic260_1_0 -u 0.009783405805873446 > ./result_10chains/node260_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node260_2_0 -p 262 -st none -pt topic260_2_0 -u 0.01620595591509244 > ./result_10chains/node260_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node260_3_0 -p 272 -st none -pt topic260_3_0 -u 0.0038801359356829823 > ./result_10chains/node260_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node260_4_0 -p 533 -st none -pt topic260_4_0 -u 0.000335353747320577 > ./result_10chains/node260_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node260_5_0 -p 544 -st none -pt topic260_5_0 -u 0.029385236186172115 > ./result_10chains/node260_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node260_6_0 -p 600 -st none -pt topic260_6_0 -u 0.015694771980326483 > ./result_10chains/node260_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node260_7_0 -p 772 -st none -pt topic260_7_0 -u 0.010194395872234224 > ./result_10chains/node260_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node260_8_0 -p 906 -st none -pt topic260_8_0 -u 0.03870819695822392 > ./result_10chains/node260_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node260_9_0 -p 951 -st none -pt topic260_9_0 -u 0.03312430071657462 > ./result_10chains/node260_9_0.txt &
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
    "./result_10chains/node260_0_0.txt 90"
    "./result_10chains/node260_0_2.txt 90"
    "./result_10chains/node260_1_0.txt 89"
    "./result_10chains/node260_1_2.txt 89"
    "./result_10chains/node260_2_0.txt 88"
    "./result_10chains/node260_2_2.txt 88"
    "./result_10chains/node260_3_0.txt 87"
    "./result_10chains/node260_3_2.txt 87"
    "./result_10chains/node260_4_0.txt 86"
    "./result_10chains/node260_4_2.txt 86"
    "./result_10chains/node260_5_0.txt 85"
    "./result_10chains/node260_5_2.txt 85"
    "./result_10chains/node260_6_0.txt 84"
    "./result_10chains/node260_6_2.txt 84"
    "./result_10chains/node260_7_0.txt 83"
    "./result_10chains/node260_7_2.txt 83"
    "./result_10chains/node260_8_0.txt 82"
    "./result_10chains/node260_8_2.txt 82"
    "./result_10chains/node260_9_0.txt 81"
    "./result_10chains/node260_9_2.txt 81"
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
