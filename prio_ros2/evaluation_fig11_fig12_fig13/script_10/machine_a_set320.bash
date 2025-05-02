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
ros2 run evaluation_3_randomdag uunifast_node -n node320_0_2 -p 67 -st topic320_0_1 -pt None -u 0.005394981014246625 > ./result_10chains/node320_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node320_1_2 -p 289 -st topic320_1_1 -pt None -u 0.013768002318342076 > ./result_10chains/node320_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node320_2_2 -p 303 -st topic320_2_1 -pt None -u 0.024720694094345075 > ./result_10chains/node320_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node320_3_2 -p 362 -st topic320_3_1 -pt None -u 0.02005732620076839 > ./result_10chains/node320_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node320_4_2 -p 640 -st topic320_4_1 -pt None -u 0.0071931975747654975 > ./result_10chains/node320_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node320_5_2 -p 721 -st topic320_5_1 -pt None -u 0.010356916537910432 > ./result_10chains/node320_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node320_6_2 -p 737 -st topic320_6_1 -pt None -u 0.03866865449942464 > ./result_10chains/node320_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node320_7_2 -p 923 -st topic320_7_1 -pt None -u 0.028249192521766324 > ./result_10chains/node320_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node320_8_2 -p 943 -st topic320_8_1 -pt None -u 0.006982657264256786 > ./result_10chains/node320_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node320_9_2 -p 960 -st topic320_9_1 -pt None -u 0.01091007850543621 > ./result_10chains/node320_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node320_0_0 -p 67 -st none -pt topic320_0_0 -u 0.002990861452889293 > ./result_10chains/node320_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node320_1_0 -p 289 -st none -pt topic320_1_0 -u 0.0007592224733604103 > ./result_10chains/node320_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node320_2_0 -p 303 -st none -pt topic320_2_0 -u 0.01925751985561769 > ./result_10chains/node320_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node320_3_0 -p 362 -st none -pt topic320_3_0 -u 0.026787178225075814 > ./result_10chains/node320_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node320_4_0 -p 640 -st none -pt topic320_4_0 -u 0.006605356925942885 > ./result_10chains/node320_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node320_5_0 -p 721 -st none -pt topic320_5_0 -u 0.028406904338585004 > ./result_10chains/node320_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node320_6_0 -p 737 -st none -pt topic320_6_0 -u 0.0071125271368787935 > ./result_10chains/node320_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node320_7_0 -p 923 -st none -pt topic320_7_0 -u 0.03880461096907188 > ./result_10chains/node320_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node320_8_0 -p 943 -st none -pt topic320_8_0 -u 0.0007904830894567144 > ./result_10chains/node320_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node320_9_0 -p 960 -st none -pt topic320_9_0 -u 0.026075458965034992 > ./result_10chains/node320_9_0.txt &
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
    "./result_10chains/node320_0_0.txt 90"
    "./result_10chains/node320_0_2.txt 90"
    "./result_10chains/node320_1_0.txt 89"
    "./result_10chains/node320_1_2.txt 89"
    "./result_10chains/node320_2_0.txt 88"
    "./result_10chains/node320_2_2.txt 88"
    "./result_10chains/node320_3_0.txt 87"
    "./result_10chains/node320_3_2.txt 87"
    "./result_10chains/node320_4_0.txt 86"
    "./result_10chains/node320_4_2.txt 86"
    "./result_10chains/node320_5_0.txt 85"
    "./result_10chains/node320_5_2.txt 85"
    "./result_10chains/node320_6_0.txt 84"
    "./result_10chains/node320_6_2.txt 84"
    "./result_10chains/node320_7_0.txt 83"
    "./result_10chains/node320_7_2.txt 83"
    "./result_10chains/node320_8_0.txt 82"
    "./result_10chains/node320_8_2.txt 82"
    "./result_10chains/node320_9_0.txt 81"
    "./result_10chains/node320_9_2.txt 81"
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
