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
ros2 run evaluation_3_randomdag uunifast_node -n node269_0_2 -p 73 -st topic269_0_1 -pt None -u 0.001310008848645683 > ./result_8chains/node269_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node269_1_2 -p 139 -st topic269_1_1 -pt None -u 0.014245886848991252 > ./result_8chains/node269_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node269_2_2 -p 274 -st topic269_2_1 -pt None -u 0.010547195741113402 > ./result_8chains/node269_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node269_3_2 -p 317 -st topic269_3_1 -pt None -u 0.007969302313037552 > ./result_8chains/node269_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node269_4_2 -p 575 -st topic269_4_1 -pt None -u 0.036534894276533614 > ./result_8chains/node269_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node269_5_2 -p 737 -st topic269_5_1 -pt None -u 0.005260669743447868 > ./result_8chains/node269_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node269_6_2 -p 875 -st topic269_6_1 -pt None -u 0.004246181068156114 > ./result_8chains/node269_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node269_7_2 -p 909 -st topic269_7_1 -pt None -u 4.63394309497573e-05 > ./result_8chains/node269_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node269_0_0 -p 73 -st none -pt topic269_0_0 -u 0.025403471076737016 > ./result_8chains/node269_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node269_1_0 -p 139 -st none -pt topic269_1_0 -u 0.0017059352338281153 > ./result_8chains/node269_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node269_2_0 -p 274 -st none -pt topic269_2_0 -u 0.011979453812090812 > ./result_8chains/node269_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node269_3_0 -p 317 -st none -pt topic269_3_0 -u 0.0007038413071462912 > ./result_8chains/node269_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node269_4_0 -p 575 -st none -pt topic269_4_0 -u 0.08917863985736274 > ./result_8chains/node269_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node269_5_0 -p 737 -st none -pt topic269_5_0 -u 0.07684427108767067 > ./result_8chains/node269_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node269_6_0 -p 875 -st none -pt topic269_6_0 -u 0.003631037335939502 > ./result_8chains/node269_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node269_7_0 -p 909 -st none -pt topic269_7_0 -u 0.02537750133752638 > ./result_8chains/node269_7_0.txt &
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
    "./result_8chains/node269_0_0.txt 90"
    "./result_8chains/node269_0_2.txt 90"
    "./result_8chains/node269_1_0.txt 89"
    "./result_8chains/node269_1_2.txt 89"
    "./result_8chains/node269_2_0.txt 88"
    "./result_8chains/node269_2_2.txt 88"
    "./result_8chains/node269_3_0.txt 87"
    "./result_8chains/node269_3_2.txt 87"
    "./result_8chains/node269_4_0.txt 86"
    "./result_8chains/node269_4_2.txt 86"
    "./result_8chains/node269_5_0.txt 85"
    "./result_8chains/node269_5_2.txt 85"
    "./result_8chains/node269_6_0.txt 84"
    "./result_8chains/node269_6_2.txt 84"
    "./result_8chains/node269_7_0.txt 83"
    "./result_8chains/node269_7_2.txt 83"
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
