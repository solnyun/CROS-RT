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
ros2 run evaluation_3_randomdag uunifast_node -n node382_0_2 -p 23 -st topic382_0_1 -pt None -u 0.07073408959622723 > ./result_8chains/node382_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node382_1_2 -p 64 -st topic382_1_1 -pt None -u 0.008844942611292983 > ./result_8chains/node382_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node382_2_2 -p 83 -st topic382_2_1 -pt None -u 0.02291092984157811 > ./result_8chains/node382_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node382_3_2 -p 169 -st topic382_3_1 -pt None -u 0.02395091056195997 > ./result_8chains/node382_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node382_4_2 -p 225 -st topic382_4_1 -pt None -u 0.020724745530846883 > ./result_8chains/node382_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node382_5_2 -p 275 -st topic382_5_1 -pt None -u 0.019125264778621393 > ./result_8chains/node382_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node382_6_2 -p 572 -st topic382_6_1 -pt None -u 0.010686915148977141 > ./result_8chains/node382_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node382_7_2 -p 826 -st topic382_7_1 -pt None -u 0.015449884519466031 > ./result_8chains/node382_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node382_0_0 -p 23 -st none -pt topic382_0_0 -u 0.005541491590602687 > ./result_8chains/node382_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node382_1_0 -p 64 -st none -pt topic382_1_0 -u 0.013894614112405168 > ./result_8chains/node382_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node382_2_0 -p 83 -st none -pt topic382_2_0 -u 0.02109346256929262 > ./result_8chains/node382_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node382_3_0 -p 169 -st none -pt topic382_3_0 -u 0.012554005962248593 > ./result_8chains/node382_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node382_4_0 -p 225 -st none -pt topic382_4_0 -u 0.03731553986517974 > ./result_8chains/node382_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node382_5_0 -p 275 -st none -pt topic382_5_0 -u 0.00613092715386046 > ./result_8chains/node382_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node382_6_0 -p 572 -st none -pt topic382_6_0 -u 0.0021360368844756117 > ./result_8chains/node382_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node382_7_0 -p 826 -st none -pt topic382_7_0 -u 0.016437624281220288 > ./result_8chains/node382_7_0.txt &
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
    "./result_8chains/node382_0_0.txt 90"
    "./result_8chains/node382_0_2.txt 90"
    "./result_8chains/node382_1_0.txt 89"
    "./result_8chains/node382_1_2.txt 89"
    "./result_8chains/node382_2_0.txt 88"
    "./result_8chains/node382_2_2.txt 88"
    "./result_8chains/node382_3_0.txt 87"
    "./result_8chains/node382_3_2.txt 87"
    "./result_8chains/node382_4_0.txt 86"
    "./result_8chains/node382_4_2.txt 86"
    "./result_8chains/node382_5_0.txt 85"
    "./result_8chains/node382_5_2.txt 85"
    "./result_8chains/node382_6_0.txt 84"
    "./result_8chains/node382_6_2.txt 84"
    "./result_8chains/node382_7_0.txt 83"
    "./result_8chains/node382_7_2.txt 83"
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
