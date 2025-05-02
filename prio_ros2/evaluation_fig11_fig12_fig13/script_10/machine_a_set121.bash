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
ros2 run evaluation_3_randomdag uunifast_node -n node121_0_2 -p 114 -st topic121_0_1 -pt None -u 0.0017295513999812107 > ./result_10chains/node121_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node121_1_2 -p 222 -st topic121_1_1 -pt None -u 0.014602682052122506 > ./result_10chains/node121_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node121_2_2 -p 337 -st topic121_2_1 -pt None -u 0.01795236146392376 > ./result_10chains/node121_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node121_3_2 -p 352 -st topic121_3_1 -pt None -u 0.025464213065121616 > ./result_10chains/node121_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node121_4_2 -p 453 -st topic121_4_1 -pt None -u 0.019530691864896116 > ./result_10chains/node121_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node121_5_2 -p 704 -st topic121_5_1 -pt None -u 0.0040413772531868175 > ./result_10chains/node121_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node121_6_2 -p 840 -st topic121_6_1 -pt None -u 0.010647086473466183 > ./result_10chains/node121_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node121_7_2 -p 915 -st topic121_7_1 -pt None -u 0.023305325492880904 > ./result_10chains/node121_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node121_8_2 -p 926 -st topic121_8_1 -pt None -u 0.06272158997135081 > ./result_10chains/node121_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node121_9_2 -p 995 -st topic121_9_1 -pt None -u 0.014295665267197524 > ./result_10chains/node121_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node121_0_0 -p 114 -st none -pt topic121_0_0 -u 0.02113634111009416 > ./result_10chains/node121_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node121_1_0 -p 222 -st none -pt topic121_1_0 -u 0.004094309623252357 > ./result_10chains/node121_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node121_2_0 -p 337 -st none -pt topic121_2_0 -u 0.044010191810758326 > ./result_10chains/node121_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node121_3_0 -p 352 -st none -pt topic121_3_0 -u 0.03561298222685644 > ./result_10chains/node121_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node121_4_0 -p 453 -st none -pt topic121_4_0 -u 0.002605622886250769 > ./result_10chains/node121_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node121_5_0 -p 704 -st none -pt topic121_5_0 -u 0.002183401690129483 > ./result_10chains/node121_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node121_6_0 -p 840 -st none -pt topic121_6_0 -u 0.03075701228795008 > ./result_10chains/node121_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node121_7_0 -p 915 -st none -pt topic121_7_0 -u 0.008324419705332792 > ./result_10chains/node121_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node121_8_0 -p 926 -st none -pt topic121_8_0 -u 0.0012315278633275306 > ./result_10chains/node121_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node121_9_0 -p 995 -st none -pt topic121_9_0 -u 0.009900770496988558 > ./result_10chains/node121_9_0.txt &
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
    "./result_10chains/node121_0_0.txt 90"
    "./result_10chains/node121_0_2.txt 90"
    "./result_10chains/node121_1_0.txt 89"
    "./result_10chains/node121_1_2.txt 89"
    "./result_10chains/node121_2_0.txt 88"
    "./result_10chains/node121_2_2.txt 88"
    "./result_10chains/node121_3_0.txt 87"
    "./result_10chains/node121_3_2.txt 87"
    "./result_10chains/node121_4_0.txt 86"
    "./result_10chains/node121_4_2.txt 86"
    "./result_10chains/node121_5_0.txt 85"
    "./result_10chains/node121_5_2.txt 85"
    "./result_10chains/node121_6_0.txt 84"
    "./result_10chains/node121_6_2.txt 84"
    "./result_10chains/node121_7_0.txt 83"
    "./result_10chains/node121_7_2.txt 83"
    "./result_10chains/node121_8_0.txt 82"
    "./result_10chains/node121_8_2.txt 82"
    "./result_10chains/node121_9_0.txt 81"
    "./result_10chains/node121_9_2.txt 81"
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
