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
ros2 run evaluation_3_randomdag uunifast_node -n node355_0_2 -p 243 -st topic355_0_1 -pt None -u 0.0019452573330591139 > ./result_6chains/node355_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node355_1_2 -p 607 -st topic355_1_1 -pt None -u 0.006525280266143851 > ./result_6chains/node355_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node355_2_2 -p 871 -st topic355_2_1 -pt None -u 0.005772398432684178 > ./result_6chains/node355_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node355_3_2 -p 930 -st topic355_3_1 -pt None -u 0.013332991928865612 > ./result_6chains/node355_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node355_4_2 -p 954 -st topic355_4_1 -pt None -u 0.012078801813833015 > ./result_6chains/node355_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node355_5_2 -p 977 -st topic355_5_1 -pt None -u 0.04218989172027966 > ./result_6chains/node355_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node355_0_0 -p 243 -st none -pt topic355_0_0 -u 0.02111380370679178 > ./result_6chains/node355_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node355_1_0 -p 607 -st none -pt topic355_1_0 -u 0.010881508602568535 > ./result_6chains/node355_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node355_2_0 -p 871 -st none -pt topic355_2_0 -u 0.10291668991535596 > ./result_6chains/node355_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node355_3_0 -p 930 -st none -pt topic355_3_0 -u 0.01814673041502271 > ./result_6chains/node355_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node355_4_0 -p 954 -st none -pt topic355_4_0 -u 0.008513329439251871 > ./result_6chains/node355_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node355_5_0 -p 977 -st none -pt topic355_5_0 -u 0.014443579252879521 > ./result_6chains/node355_5_0.txt &
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
    "./result_6chains/node355_0_0.txt 90"
    "./result_6chains/node355_0_2.txt 90"
    "./result_6chains/node355_1_0.txt 89"
    "./result_6chains/node355_1_2.txt 89"
    "./result_6chains/node355_2_0.txt 88"
    "./result_6chains/node355_2_2.txt 88"
    "./result_6chains/node355_3_0.txt 87"
    "./result_6chains/node355_3_2.txt 87"
    "./result_6chains/node355_4_0.txt 86"
    "./result_6chains/node355_4_2.txt 86"
    "./result_6chains/node355_5_0.txt 85"
    "./result_6chains/node355_5_2.txt 85"
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
sleep 130s
sudo pkill -USR1 uunifast_node
echo "Set timer signal!"
sleep 200s
echo "End Running"
sudo pkill uunifast_node
finalize_framework
/home/orin5/prio_ros2/evaluation_2_fig10/send_signal 127.0.0.1 9999
