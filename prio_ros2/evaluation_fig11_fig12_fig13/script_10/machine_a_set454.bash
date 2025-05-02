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
ros2 run evaluation_3_randomdag uunifast_node -n node454_0_2 -p 64 -st topic454_0_1 -pt None -u 0.03322773731179052 > ./result_10chains/node454_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node454_1_2 -p 343 -st topic454_1_1 -pt None -u 0.0039507196245237575 > ./result_10chains/node454_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node454_2_2 -p 397 -st topic454_2_1 -pt None -u 0.018342717922367968 > ./result_10chains/node454_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node454_3_2 -p 478 -st topic454_3_1 -pt None -u 0.02667233199267499 > ./result_10chains/node454_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node454_4_2 -p 666 -st topic454_4_1 -pt None -u 0.0010762920791057562 > ./result_10chains/node454_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node454_5_2 -p 744 -st topic454_5_1 -pt None -u 0.0017006712647915645 > ./result_10chains/node454_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node454_6_2 -p 849 -st topic454_6_1 -pt None -u 0.003985331913529899 > ./result_10chains/node454_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node454_7_2 -p 936 -st topic454_7_1 -pt None -u 0.001088509327427517 > ./result_10chains/node454_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node454_8_2 -p 956 -st topic454_8_1 -pt None -u 0.04739218242936385 > ./result_10chains/node454_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node454_9_2 -p 991 -st topic454_9_1 -pt None -u 0.009013958475685823 > ./result_10chains/node454_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node454_0_0 -p 64 -st none -pt topic454_0_0 -u 0.026161609921730722 > ./result_10chains/node454_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node454_1_0 -p 343 -st none -pt topic454_1_0 -u 0.009379010710500402 > ./result_10chains/node454_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node454_2_0 -p 397 -st none -pt topic454_2_0 -u 0.004945027523100998 > ./result_10chains/node454_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node454_3_0 -p 478 -st none -pt topic454_3_0 -u 0.00020307803257796353 > ./result_10chains/node454_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node454_4_0 -p 666 -st none -pt topic454_4_0 -u 0.011257166996587742 > ./result_10chains/node454_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node454_5_0 -p 744 -st none -pt topic454_5_0 -u 0.06742817941859264 > ./result_10chains/node454_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node454_6_0 -p 849 -st none -pt topic454_6_0 -u 0.051485126021401456 > ./result_10chains/node454_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node454_7_0 -p 936 -st none -pt topic454_7_0 -u 0.0038790016470786615 > ./result_10chains/node454_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node454_8_0 -p 956 -st none -pt topic454_8_0 -u 0.03449185930282703 > ./result_10chains/node454_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node454_9_0 -p 991 -st none -pt topic454_9_0 -u 0.018372069643080066 > ./result_10chains/node454_9_0.txt &
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
    "./result_10chains/node454_0_0.txt 90"
    "./result_10chains/node454_0_2.txt 90"
    "./result_10chains/node454_1_0.txt 89"
    "./result_10chains/node454_1_2.txt 89"
    "./result_10chains/node454_2_0.txt 88"
    "./result_10chains/node454_2_2.txt 88"
    "./result_10chains/node454_3_0.txt 87"
    "./result_10chains/node454_3_2.txt 87"
    "./result_10chains/node454_4_0.txt 86"
    "./result_10chains/node454_4_2.txt 86"
    "./result_10chains/node454_5_0.txt 85"
    "./result_10chains/node454_5_2.txt 85"
    "./result_10chains/node454_6_0.txt 84"
    "./result_10chains/node454_6_2.txt 84"
    "./result_10chains/node454_7_0.txt 83"
    "./result_10chains/node454_7_2.txt 83"
    "./result_10chains/node454_8_0.txt 82"
    "./result_10chains/node454_8_2.txt 82"
    "./result_10chains/node454_9_0.txt 81"
    "./result_10chains/node454_9_2.txt 81"
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
