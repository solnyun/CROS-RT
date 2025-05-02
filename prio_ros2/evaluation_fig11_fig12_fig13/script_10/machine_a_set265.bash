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
ros2 run evaluation_3_randomdag uunifast_node -n node265_0_2 -p 140 -st topic265_0_1 -pt None -u 0.018470705540938492 > ./result_10chains/node265_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node265_1_2 -p 158 -st topic265_1_1 -pt None -u 0.018676571316414592 > ./result_10chains/node265_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node265_2_2 -p 171 -st topic265_2_1 -pt None -u 0.017055935000981515 > ./result_10chains/node265_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node265_3_2 -p 483 -st topic265_3_1 -pt None -u 0.021971125831789784 > ./result_10chains/node265_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node265_4_2 -p 484 -st topic265_4_1 -pt None -u 0.0031108125795929475 > ./result_10chains/node265_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node265_5_2 -p 610 -st topic265_5_1 -pt None -u 0.0012235217135157517 > ./result_10chains/node265_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node265_6_2 -p 642 -st topic265_6_1 -pt None -u 0.0023406226774029815 > ./result_10chains/node265_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node265_7_2 -p 767 -st topic265_7_1 -pt None -u 0.008782880801087009 > ./result_10chains/node265_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node265_8_2 -p 867 -st topic265_8_1 -pt None -u 0.00027340364510915205 > ./result_10chains/node265_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node265_9_2 -p 983 -st topic265_9_1 -pt None -u 0.016722799469910496 > ./result_10chains/node265_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node265_0_0 -p 140 -st none -pt topic265_0_0 -u 0.014613441332603394 > ./result_10chains/node265_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node265_1_0 -p 158 -st none -pt topic265_1_0 -u 0.0006400249190199325 > ./result_10chains/node265_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node265_2_0 -p 171 -st none -pt topic265_2_0 -u 0.017672644094799572 > ./result_10chains/node265_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node265_3_0 -p 483 -st none -pt topic265_3_0 -u 0.006519059085168921 > ./result_10chains/node265_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node265_4_0 -p 484 -st none -pt topic265_4_0 -u 0.004711337466222931 > ./result_10chains/node265_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node265_5_0 -p 610 -st none -pt topic265_5_0 -u 0.023280029414863734 > ./result_10chains/node265_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node265_6_0 -p 642 -st none -pt topic265_6_0 -u 0.0018860335733830724 > ./result_10chains/node265_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node265_7_0 -p 767 -st none -pt topic265_7_0 -u 0.0856239013119783 > ./result_10chains/node265_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node265_8_0 -p 867 -st none -pt topic265_8_0 -u 0.008244582045935978 > ./result_10chains/node265_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node265_9_0 -p 983 -st none -pt topic265_9_0 -u 0.041306848881825856 > ./result_10chains/node265_9_0.txt &
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
    "./result_10chains/node265_0_0.txt 90"
    "./result_10chains/node265_0_2.txt 90"
    "./result_10chains/node265_1_0.txt 89"
    "./result_10chains/node265_1_2.txt 89"
    "./result_10chains/node265_2_0.txt 88"
    "./result_10chains/node265_2_2.txt 88"
    "./result_10chains/node265_3_0.txt 87"
    "./result_10chains/node265_3_2.txt 87"
    "./result_10chains/node265_4_0.txt 86"
    "./result_10chains/node265_4_2.txt 86"
    "./result_10chains/node265_5_0.txt 85"
    "./result_10chains/node265_5_2.txt 85"
    "./result_10chains/node265_6_0.txt 84"
    "./result_10chains/node265_6_2.txt 84"
    "./result_10chains/node265_7_0.txt 83"
    "./result_10chains/node265_7_2.txt 83"
    "./result_10chains/node265_8_0.txt 82"
    "./result_10chains/node265_8_2.txt 82"
    "./result_10chains/node265_9_0.txt 81"
    "./result_10chains/node265_9_2.txt 81"
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
