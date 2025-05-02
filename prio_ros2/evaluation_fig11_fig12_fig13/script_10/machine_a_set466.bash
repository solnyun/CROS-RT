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
ros2 run evaluation_3_randomdag uunifast_node -n node466_0_2 -p 32 -st topic466_0_1 -pt None -u 0.026478407867209397 > ./result_10chains/node466_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node466_1_2 -p 80 -st topic466_1_1 -pt None -u 0.010584936763646191 > ./result_10chains/node466_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node466_2_2 -p 168 -st topic466_2_1 -pt None -u 0.0021068093815309052 > ./result_10chains/node466_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node466_3_2 -p 384 -st topic466_3_1 -pt None -u 0.0031208356061167564 > ./result_10chains/node466_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node466_4_2 -p 567 -st topic466_4_1 -pt None -u 0.0009230691400523572 > ./result_10chains/node466_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node466_5_2 -p 747 -st topic466_5_1 -pt None -u 0.011667414929118547 > ./result_10chains/node466_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node466_6_2 -p 820 -st topic466_6_1 -pt None -u 0.0193541138989701 > ./result_10chains/node466_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node466_7_2 -p 895 -st topic466_7_1 -pt None -u 0.005838730123113617 > ./result_10chains/node466_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node466_8_2 -p 929 -st topic466_8_1 -pt None -u 0.03096806366111804 > ./result_10chains/node466_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node466_9_2 -p 970 -st topic466_9_1 -pt None -u 0.025530252192605477 > ./result_10chains/node466_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node466_0_0 -p 32 -st none -pt topic466_0_0 -u 0.027299994120770887 > ./result_10chains/node466_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node466_1_0 -p 80 -st none -pt topic466_1_0 -u 0.013909934229895393 > ./result_10chains/node466_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node466_2_0 -p 168 -st none -pt topic466_2_0 -u 0.017287108600682444 > ./result_10chains/node466_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node466_3_0 -p 384 -st none -pt topic466_3_0 -u 0.0040334141436018656 > ./result_10chains/node466_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node466_4_0 -p 567 -st none -pt topic466_4_0 -u 0.008156755351766909 > ./result_10chains/node466_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node466_5_0 -p 747 -st none -pt topic466_5_0 -u 0.004982691309108944 > ./result_10chains/node466_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node466_6_0 -p 820 -st none -pt topic466_6_0 -u 0.012122789272683454 > ./result_10chains/node466_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node466_7_0 -p 895 -st none -pt topic466_7_0 -u 0.012631998076227308 > ./result_10chains/node466_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node466_8_0 -p 929 -st none -pt topic466_8_0 -u 0.060921800585224284 > ./result_10chains/node466_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node466_9_0 -p 970 -st none -pt topic466_9_0 -u 0.0036749216291036 > ./result_10chains/node466_9_0.txt &
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
    "./result_10chains/node466_0_0.txt 90"
    "./result_10chains/node466_0_2.txt 90"
    "./result_10chains/node466_1_0.txt 89"
    "./result_10chains/node466_1_2.txt 89"
    "./result_10chains/node466_2_0.txt 88"
    "./result_10chains/node466_2_2.txt 88"
    "./result_10chains/node466_3_0.txt 87"
    "./result_10chains/node466_3_2.txt 87"
    "./result_10chains/node466_4_0.txt 86"
    "./result_10chains/node466_4_2.txt 86"
    "./result_10chains/node466_5_0.txt 85"
    "./result_10chains/node466_5_2.txt 85"
    "./result_10chains/node466_6_0.txt 84"
    "./result_10chains/node466_6_2.txt 84"
    "./result_10chains/node466_7_0.txt 83"
    "./result_10chains/node466_7_2.txt 83"
    "./result_10chains/node466_8_0.txt 82"
    "./result_10chains/node466_8_2.txt 82"
    "./result_10chains/node466_9_0.txt 81"
    "./result_10chains/node466_9_2.txt 81"
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
