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
ros2 run evaluation_3_randomdag uunifast_node -n node355_0_2 -p 54 -st topic355_0_1 -pt None -u 0.06601295322354855 > ./result_8chains/node355_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node355_1_2 -p 170 -st topic355_1_1 -pt None -u 0.01526593113719199 > ./result_8chains/node355_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node355_2_2 -p 463 -st topic355_2_1 -pt None -u 0.0076117004120435094 > ./result_8chains/node355_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node355_3_2 -p 476 -st topic355_3_1 -pt None -u 0.007858555137732537 > ./result_8chains/node355_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node355_4_2 -p 699 -st topic355_4_1 -pt None -u 0.003010984454092258 > ./result_8chains/node355_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node355_5_2 -p 715 -st topic355_5_1 -pt None -u 0.020801011058750943 > ./result_8chains/node355_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node355_6_2 -p 716 -st topic355_6_1 -pt None -u 0.04150553371959899 > ./result_8chains/node355_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node355_7_2 -p 725 -st topic355_7_1 -pt None -u 0.0009762819550716891 > ./result_8chains/node355_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node355_0_0 -p 54 -st none -pt topic355_0_0 -u 0.036757683763747606 > ./result_8chains/node355_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node355_1_0 -p 170 -st none -pt topic355_1_0 -u 0.0328787769338007 > ./result_8chains/node355_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node355_2_0 -p 463 -st none -pt topic355_2_0 -u 0.016662744360374515 > ./result_8chains/node355_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node355_3_0 -p 476 -st none -pt topic355_3_0 -u 0.012464023842513605 > ./result_8chains/node355_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node355_4_0 -p 699 -st none -pt topic355_4_0 -u 0.026442931807498626 > ./result_8chains/node355_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node355_5_0 -p 715 -st none -pt topic355_5_0 -u 0.002575823566494162 > ./result_8chains/node355_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node355_6_0 -p 716 -st none -pt topic355_6_0 -u 0.022138005849920483 > ./result_8chains/node355_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node355_7_0 -p 725 -st none -pt topic355_7_0 -u 0.0030784205041549297 > ./result_8chains/node355_7_0.txt &
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
    "./result_8chains/node355_0_0.txt 90"
    "./result_8chains/node355_0_2.txt 90"
    "./result_8chains/node355_1_0.txt 89"
    "./result_8chains/node355_1_2.txt 89"
    "./result_8chains/node355_2_0.txt 88"
    "./result_8chains/node355_2_2.txt 88"
    "./result_8chains/node355_3_0.txt 87"
    "./result_8chains/node355_3_2.txt 87"
    "./result_8chains/node355_4_0.txt 86"
    "./result_8chains/node355_4_2.txt 86"
    "./result_8chains/node355_5_0.txt 85"
    "./result_8chains/node355_5_2.txt 85"
    "./result_8chains/node355_6_0.txt 84"
    "./result_8chains/node355_6_2.txt 84"
    "./result_8chains/node355_7_0.txt 83"
    "./result_8chains/node355_7_2.txt 83"
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
