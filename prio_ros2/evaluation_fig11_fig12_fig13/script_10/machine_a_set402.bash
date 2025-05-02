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
ros2 run evaluation_3_randomdag uunifast_node -n node402_0_2 -p 158 -st topic402_0_1 -pt None -u 0.002585678433981997 > ./result_10chains/node402_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node402_1_2 -p 196 -st topic402_1_1 -pt None -u 0.028709002717490217 > ./result_10chains/node402_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node402_2_2 -p 208 -st topic402_2_1 -pt None -u 0.00890533975631913 > ./result_10chains/node402_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node402_3_2 -p 224 -st topic402_3_1 -pt None -u 0.0012751367202675779 > ./result_10chains/node402_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node402_4_2 -p 406 -st topic402_4_1 -pt None -u 0.0005764232893573917 > ./result_10chains/node402_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node402_5_2 -p 407 -st topic402_5_1 -pt None -u 0.004949933970019027 > ./result_10chains/node402_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node402_6_2 -p 479 -st topic402_6_1 -pt None -u 0.0008864417224662691 > ./result_10chains/node402_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node402_7_2 -p 634 -st topic402_7_1 -pt None -u 0.010579877026765022 > ./result_10chains/node402_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node402_8_2 -p 668 -st topic402_8_1 -pt None -u 0.004252667143787026 > ./result_10chains/node402_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node402_9_2 -p 679 -st topic402_9_1 -pt None -u 0.043679043276345565 > ./result_10chains/node402_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node402_0_0 -p 158 -st none -pt topic402_0_0 -u 0.043614936701986184 > ./result_10chains/node402_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node402_1_0 -p 196 -st none -pt topic402_1_0 -u 0.04290052150237589 > ./result_10chains/node402_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node402_2_0 -p 208 -st none -pt topic402_2_0 -u 0.02163432939977633 > ./result_10chains/node402_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node402_3_0 -p 224 -st none -pt topic402_3_0 -u 0.002814545343640895 > ./result_10chains/node402_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node402_4_0 -p 406 -st none -pt topic402_4_0 -u 0.004019063046976634 > ./result_10chains/node402_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node402_5_0 -p 407 -st none -pt topic402_5_0 -u 0.027429304127736837 > ./result_10chains/node402_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node402_6_0 -p 479 -st none -pt topic402_6_0 -u 0.006150075907366159 > ./result_10chains/node402_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node402_7_0 -p 634 -st none -pt topic402_7_0 -u 0.0038138280370215716 > ./result_10chains/node402_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node402_8_0 -p 668 -st none -pt topic402_8_0 -u 0.020764059317567557 > ./result_10chains/node402_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node402_9_0 -p 679 -st none -pt topic402_9_0 -u 0.037711100879140175 > ./result_10chains/node402_9_0.txt &
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
    "./result_10chains/node402_0_0.txt 90"
    "./result_10chains/node402_0_2.txt 90"
    "./result_10chains/node402_1_0.txt 89"
    "./result_10chains/node402_1_2.txt 89"
    "./result_10chains/node402_2_0.txt 88"
    "./result_10chains/node402_2_2.txt 88"
    "./result_10chains/node402_3_0.txt 87"
    "./result_10chains/node402_3_2.txt 87"
    "./result_10chains/node402_4_0.txt 86"
    "./result_10chains/node402_4_2.txt 86"
    "./result_10chains/node402_5_0.txt 85"
    "./result_10chains/node402_5_2.txt 85"
    "./result_10chains/node402_6_0.txt 84"
    "./result_10chains/node402_6_2.txt 84"
    "./result_10chains/node402_7_0.txt 83"
    "./result_10chains/node402_7_2.txt 83"
    "./result_10chains/node402_8_0.txt 82"
    "./result_10chains/node402_8_2.txt 82"
    "./result_10chains/node402_9_0.txt 81"
    "./result_10chains/node402_9_2.txt 81"
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
