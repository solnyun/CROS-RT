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
ros2 run evaluation_3_randomdag uunifast_node -n node278_0_2 -p 12 -st topic278_0_1 -pt None -u 0.027769392906685286 > ./result_10chains/node278_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node278_1_2 -p 44 -st topic278_1_1 -pt None -u 0.001288811516633015 > ./result_10chains/node278_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node278_2_2 -p 199 -st topic278_2_1 -pt None -u 0.00145498406210387 > ./result_10chains/node278_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node278_3_2 -p 329 -st topic278_3_1 -pt None -u 0.021931766022909693 > ./result_10chains/node278_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node278_4_2 -p 546 -st topic278_4_1 -pt None -u 0.0028172521926973504 > ./result_10chains/node278_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node278_5_2 -p 555 -st topic278_5_1 -pt None -u 0.03294925507400373 > ./result_10chains/node278_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node278_6_2 -p 568 -st topic278_6_1 -pt None -u 0.031456592588453264 > ./result_10chains/node278_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node278_7_2 -p 582 -st topic278_7_1 -pt None -u 0.002804951514687598 > ./result_10chains/node278_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node278_8_2 -p 915 -st topic278_8_1 -pt None -u 0.02115050910818335 > ./result_10chains/node278_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node278_9_2 -p 996 -st topic278_9_1 -pt None -u 0.031098533724566134 > ./result_10chains/node278_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node278_0_0 -p 12 -st none -pt topic278_0_0 -u 0.004895066298591655 > ./result_10chains/node278_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node278_1_0 -p 44 -st none -pt topic278_1_0 -u 0.012309212007138526 > ./result_10chains/node278_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node278_2_0 -p 199 -st none -pt topic278_2_0 -u 0.023694272043001285 > ./result_10chains/node278_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node278_3_0 -p 329 -st none -pt topic278_3_0 -u 0.0029514739050262584 > ./result_10chains/node278_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node278_4_0 -p 546 -st none -pt topic278_4_0 -u 0.00833888074430622 > ./result_10chains/node278_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node278_5_0 -p 555 -st none -pt topic278_5_0 -u 0.0016649200802382191 > ./result_10chains/node278_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node278_6_0 -p 568 -st none -pt topic278_6_0 -u 0.0036543416357531777 > ./result_10chains/node278_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node278_7_0 -p 582 -st none -pt topic278_7_0 -u 0.014847618140345936 > ./result_10chains/node278_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node278_8_0 -p 915 -st none -pt topic278_8_0 -u 0.008290607212433493 > ./result_10chains/node278_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node278_9_0 -p 996 -st none -pt topic278_9_0 -u 0.013946674850071172 > ./result_10chains/node278_9_0.txt &
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
    "./result_10chains/node278_0_0.txt 90"
    "./result_10chains/node278_0_2.txt 90"
    "./result_10chains/node278_1_0.txt 89"
    "./result_10chains/node278_1_2.txt 89"
    "./result_10chains/node278_2_0.txt 88"
    "./result_10chains/node278_2_2.txt 88"
    "./result_10chains/node278_3_0.txt 87"
    "./result_10chains/node278_3_2.txt 87"
    "./result_10chains/node278_4_0.txt 86"
    "./result_10chains/node278_4_2.txt 86"
    "./result_10chains/node278_5_0.txt 85"
    "./result_10chains/node278_5_2.txt 85"
    "./result_10chains/node278_6_0.txt 84"
    "./result_10chains/node278_6_2.txt 84"
    "./result_10chains/node278_7_0.txt 83"
    "./result_10chains/node278_7_2.txt 83"
    "./result_10chains/node278_8_0.txt 82"
    "./result_10chains/node278_8_2.txt 82"
    "./result_10chains/node278_9_0.txt 81"
    "./result_10chains/node278_9_2.txt 81"
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
