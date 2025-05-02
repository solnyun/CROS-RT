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
ros2 run evaluation_3_randomdag uunifast_node -n node446_0_2 -p 101 -st topic446_0_1 -pt None -u 0.001784887809078206 > ./result_10chains/node446_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node446_1_2 -p 212 -st topic446_1_1 -pt None -u 0.01356484940015723 > ./result_10chains/node446_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node446_2_2 -p 254 -st topic446_2_1 -pt None -u 0.001355129057503457 > ./result_10chains/node446_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node446_3_2 -p 287 -st topic446_3_1 -pt None -u 0.008023704597167114 > ./result_10chains/node446_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node446_4_2 -p 367 -st topic446_4_1 -pt None -u 0.022086847921340247 > ./result_10chains/node446_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node446_5_2 -p 406 -st topic446_5_1 -pt None -u 0.026462026054713872 > ./result_10chains/node446_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node446_6_2 -p 466 -st topic446_6_1 -pt None -u 0.017526948921302105 > ./result_10chains/node446_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node446_7_2 -p 469 -st topic446_7_1 -pt None -u 0.018483019802533807 > ./result_10chains/node446_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node446_8_2 -p 541 -st topic446_8_1 -pt None -u 0.04238361582803767 > ./result_10chains/node446_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node446_9_2 -p 708 -st topic446_9_1 -pt None -u 0.0017138610624253911 > ./result_10chains/node446_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node446_0_0 -p 101 -st none -pt topic446_0_0 -u 0.02331547790269295 > ./result_10chains/node446_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node446_1_0 -p 212 -st none -pt topic446_1_0 -u 0.01433976923632474 > ./result_10chains/node446_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node446_2_0 -p 254 -st none -pt topic446_2_0 -u 0.0039740226505488585 > ./result_10chains/node446_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node446_3_0 -p 287 -st none -pt topic446_3_0 -u 0.007888802183131816 > ./result_10chains/node446_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node446_4_0 -p 367 -st none -pt topic446_4_0 -u 0.0004383544101533854 > ./result_10chains/node446_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node446_5_0 -p 406 -st none -pt topic446_5_0 -u 0.004578640798121647 > ./result_10chains/node446_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node446_6_0 -p 466 -st none -pt topic446_6_0 -u 0.027504548079175378 > ./result_10chains/node446_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node446_7_0 -p 469 -st none -pt topic446_7_0 -u 0.00409008506718922 > ./result_10chains/node446_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node446_8_0 -p 541 -st none -pt topic446_8_0 -u 0.00507708681284999 > ./result_10chains/node446_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node446_9_0 -p 708 -st none -pt topic446_9_0 -u 0.010964089251534526 > ./result_10chains/node446_9_0.txt &
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
    "./result_10chains/node446_0_0.txt 90"
    "./result_10chains/node446_0_2.txt 90"
    "./result_10chains/node446_1_0.txt 89"
    "./result_10chains/node446_1_2.txt 89"
    "./result_10chains/node446_2_0.txt 88"
    "./result_10chains/node446_2_2.txt 88"
    "./result_10chains/node446_3_0.txt 87"
    "./result_10chains/node446_3_2.txt 87"
    "./result_10chains/node446_4_0.txt 86"
    "./result_10chains/node446_4_2.txt 86"
    "./result_10chains/node446_5_0.txt 85"
    "./result_10chains/node446_5_2.txt 85"
    "./result_10chains/node446_6_0.txt 84"
    "./result_10chains/node446_6_2.txt 84"
    "./result_10chains/node446_7_0.txt 83"
    "./result_10chains/node446_7_2.txt 83"
    "./result_10chains/node446_8_0.txt 82"
    "./result_10chains/node446_8_2.txt 82"
    "./result_10chains/node446_9_0.txt 81"
    "./result_10chains/node446_9_2.txt 81"
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
