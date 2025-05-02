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
ros2 run evaluation_3_randomdag uunifast_node -n node192_0_2 -p 218 -st topic192_0_1 -pt None -u 0.04109915874730535 > ./result_8chains/node192_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node192_1_2 -p 301 -st topic192_1_1 -pt None -u 0.01489902168577506 > ./result_8chains/node192_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node192_2_2 -p 663 -st topic192_2_1 -pt None -u 0.005661799793872935 > ./result_8chains/node192_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node192_3_2 -p 780 -st topic192_3_1 -pt None -u 0.012588322790697437 > ./result_8chains/node192_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node192_4_2 -p 782 -st topic192_4_1 -pt None -u 0.013280407634879768 > ./result_8chains/node192_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node192_5_2 -p 798 -st topic192_5_1 -pt None -u 0.004385803799346222 > ./result_8chains/node192_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node192_6_2 -p 917 -st topic192_6_1 -pt None -u 4.8356757105225134e-05 > ./result_8chains/node192_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node192_7_2 -p 962 -st topic192_7_1 -pt None -u 0.02894040495328527 > ./result_8chains/node192_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node192_0_0 -p 218 -st none -pt topic192_0_0 -u 0.05488873122963822 > ./result_8chains/node192_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node192_1_0 -p 301 -st none -pt topic192_1_0 -u 0.009508001938787425 > ./result_8chains/node192_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node192_2_0 -p 663 -st none -pt topic192_2_0 -u 0.0033668980113495395 > ./result_8chains/node192_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node192_3_0 -p 780 -st none -pt topic192_3_0 -u 0.05059195178981657 > ./result_8chains/node192_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node192_4_0 -p 782 -st none -pt topic192_4_0 -u 0.0025545252107662675 > ./result_8chains/node192_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node192_5_0 -p 798 -st none -pt topic192_5_0 -u 0.014278056423868063 > ./result_8chains/node192_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node192_6_0 -p 917 -st none -pt topic192_6_0 -u 0.004315287668095261 > ./result_8chains/node192_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node192_7_0 -p 962 -st none -pt topic192_7_0 -u 0.03160340910407744 > ./result_8chains/node192_7_0.txt &
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
    "./result_8chains/node192_0_0.txt 90"
    "./result_8chains/node192_0_2.txt 90"
    "./result_8chains/node192_1_0.txt 89"
    "./result_8chains/node192_1_2.txt 89"
    "./result_8chains/node192_2_0.txt 88"
    "./result_8chains/node192_2_2.txt 88"
    "./result_8chains/node192_3_0.txt 87"
    "./result_8chains/node192_3_2.txt 87"
    "./result_8chains/node192_4_0.txt 86"
    "./result_8chains/node192_4_2.txt 86"
    "./result_8chains/node192_5_0.txt 85"
    "./result_8chains/node192_5_2.txt 85"
    "./result_8chains/node192_6_0.txt 84"
    "./result_8chains/node192_6_2.txt 84"
    "./result_8chains/node192_7_0.txt 83"
    "./result_8chains/node192_7_2.txt 83"
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
