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
ros2 run evaluation_3_randomdag uunifast_node -n node227_0_2 -p 57 -st topic227_0_1 -pt None -u 0.017924953080801276 > ./result_10chains/node227_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node227_1_2 -p 216 -st topic227_1_1 -pt None -u 0.0012654673869170185 > ./result_10chains/node227_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node227_2_2 -p 544 -st topic227_2_1 -pt None -u 0.005890115327538636 > ./result_10chains/node227_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node227_3_2 -p 596 -st topic227_3_1 -pt None -u 0.003433565381475545 > ./result_10chains/node227_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node227_4_2 -p 613 -st topic227_4_1 -pt None -u 0.0016024691717213546 > ./result_10chains/node227_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node227_5_2 -p 753 -st topic227_5_1 -pt None -u 0.021932683603515135 > ./result_10chains/node227_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node227_6_2 -p 783 -st topic227_6_1 -pt None -u 0.0264214016927104 > ./result_10chains/node227_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node227_7_2 -p 870 -st topic227_7_1 -pt None -u 0.04241168384980132 > ./result_10chains/node227_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node227_8_2 -p 910 -st topic227_8_1 -pt None -u 0.004050558539248156 > ./result_10chains/node227_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node227_9_2 -p 974 -st topic227_9_1 -pt None -u 0.10933623602335908 > ./result_10chains/node227_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node227_0_0 -p 57 -st none -pt topic227_0_0 -u 0.0005827426887916043 > ./result_10chains/node227_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node227_1_0 -p 216 -st none -pt topic227_1_0 -u 0.01791989029931007 > ./result_10chains/node227_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node227_2_0 -p 544 -st none -pt topic227_2_0 -u 0.06848391807511928 > ./result_10chains/node227_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node227_3_0 -p 596 -st none -pt topic227_3_0 -u 0.008637773756692446 > ./result_10chains/node227_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node227_4_0 -p 613 -st none -pt topic227_4_0 -u 0.017397472308692874 > ./result_10chains/node227_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node227_5_0 -p 753 -st none -pt topic227_5_0 -u 0.026893580633486402 > ./result_10chains/node227_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node227_6_0 -p 783 -st none -pt topic227_6_0 -u 0.00787936826739119 > ./result_10chains/node227_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node227_7_0 -p 870 -st none -pt topic227_7_0 -u 0.013207443972532928 > ./result_10chains/node227_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node227_8_0 -p 910 -st none -pt topic227_8_0 -u 0.012327564882015585 > ./result_10chains/node227_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node227_9_0 -p 974 -st none -pt topic227_9_0 -u 0.001785160526985935 > ./result_10chains/node227_9_0.txt &
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
    "./result_10chains/node227_0_0.txt 90"
    "./result_10chains/node227_0_2.txt 90"
    "./result_10chains/node227_1_0.txt 89"
    "./result_10chains/node227_1_2.txt 89"
    "./result_10chains/node227_2_0.txt 88"
    "./result_10chains/node227_2_2.txt 88"
    "./result_10chains/node227_3_0.txt 87"
    "./result_10chains/node227_3_2.txt 87"
    "./result_10chains/node227_4_0.txt 86"
    "./result_10chains/node227_4_2.txt 86"
    "./result_10chains/node227_5_0.txt 85"
    "./result_10chains/node227_5_2.txt 85"
    "./result_10chains/node227_6_0.txt 84"
    "./result_10chains/node227_6_2.txt 84"
    "./result_10chains/node227_7_0.txt 83"
    "./result_10chains/node227_7_2.txt 83"
    "./result_10chains/node227_8_0.txt 82"
    "./result_10chains/node227_8_2.txt 82"
    "./result_10chains/node227_9_0.txt 81"
    "./result_10chains/node227_9_2.txt 81"
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
