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
ros2 run evaluation_3_randomdag uunifast_node -n node489_0_2 -p 60 -st topic489_0_1 -pt None -u 0.011651218838830024 > ./result_10chains/node489_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node489_1_2 -p 172 -st topic489_1_1 -pt None -u 0.02429683523667725 > ./result_10chains/node489_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node489_2_2 -p 180 -st topic489_2_1 -pt None -u 0.00785275335861313 > ./result_10chains/node489_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node489_3_2 -p 364 -st topic489_3_1 -pt None -u 0.02640275209825893 > ./result_10chains/node489_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node489_4_2 -p 386 -st topic489_4_1 -pt None -u 0.02930876364804169 > ./result_10chains/node489_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node489_5_2 -p 607 -st topic489_5_1 -pt None -u 0.01714366376096782 > ./result_10chains/node489_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node489_6_2 -p 633 -st topic489_6_1 -pt None -u 0.016122128719391768 > ./result_10chains/node489_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node489_7_2 -p 695 -st topic489_7_1 -pt None -u 0.006759001173426718 > ./result_10chains/node489_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node489_8_2 -p 706 -st topic489_8_1 -pt None -u 0.0061548391493135984 > ./result_10chains/node489_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node489_9_2 -p 965 -st topic489_9_1 -pt None -u 0.0012839477240439452 > ./result_10chains/node489_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node489_0_0 -p 60 -st none -pt topic489_0_0 -u 0.011159043738782348 > ./result_10chains/node489_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node489_1_0 -p 172 -st none -pt topic489_1_0 -u 0.0664587440241074 > ./result_10chains/node489_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node489_2_0 -p 180 -st none -pt topic489_2_0 -u 0.006027932874689557 > ./result_10chains/node489_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node489_3_0 -p 364 -st none -pt topic489_3_0 -u 0.015455468441544884 > ./result_10chains/node489_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node489_4_0 -p 386 -st none -pt topic489_4_0 -u 0.016926016720952786 > ./result_10chains/node489_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node489_5_0 -p 607 -st none -pt topic489_5_0 -u 0.02790004848075131 > ./result_10chains/node489_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node489_6_0 -p 633 -st none -pt topic489_6_0 -u 0.012704819734350947 > ./result_10chains/node489_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node489_7_0 -p 695 -st none -pt topic489_7_0 -u 0.0036518898655554244 > ./result_10chains/node489_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node489_8_0 -p 706 -st none -pt topic489_8_0 -u 0.0014376951578267683 > ./result_10chains/node489_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node489_9_0 -p 965 -st none -pt topic489_9_0 -u 0.040498109431467706 > ./result_10chains/node489_9_0.txt &
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
    "./result_10chains/node489_0_0.txt 90"
    "./result_10chains/node489_0_2.txt 90"
    "./result_10chains/node489_1_0.txt 89"
    "./result_10chains/node489_1_2.txt 89"
    "./result_10chains/node489_2_0.txt 88"
    "./result_10chains/node489_2_2.txt 88"
    "./result_10chains/node489_3_0.txt 87"
    "./result_10chains/node489_3_2.txt 87"
    "./result_10chains/node489_4_0.txt 86"
    "./result_10chains/node489_4_2.txt 86"
    "./result_10chains/node489_5_0.txt 85"
    "./result_10chains/node489_5_2.txt 85"
    "./result_10chains/node489_6_0.txt 84"
    "./result_10chains/node489_6_2.txt 84"
    "./result_10chains/node489_7_0.txt 83"
    "./result_10chains/node489_7_2.txt 83"
    "./result_10chains/node489_8_0.txt 82"
    "./result_10chains/node489_8_2.txt 82"
    "./result_10chains/node489_9_0.txt 81"
    "./result_10chains/node489_9_2.txt 81"
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
