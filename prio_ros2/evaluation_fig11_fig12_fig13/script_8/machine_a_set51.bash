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
ros2 run evaluation_3_randomdag uunifast_node -n node51_0_2 -p 188 -st topic51_0_1 -pt None -u 0.0009409984672271721 > ./result_8chains/node51_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node51_1_2 -p 196 -st topic51_1_1 -pt None -u 0.011260200871514081 > ./result_8chains/node51_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node51_2_2 -p 259 -st topic51_2_1 -pt None -u 0.017321337899630418 > ./result_8chains/node51_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node51_3_2 -p 271 -st topic51_3_1 -pt None -u 0.024406131094962313 > ./result_8chains/node51_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node51_4_2 -p 498 -st topic51_4_1 -pt None -u 0.07125765173369741 > ./result_8chains/node51_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node51_5_2 -p 647 -st topic51_5_1 -pt None -u 0.08892874510911059 > ./result_8chains/node51_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node51_6_2 -p 806 -st topic51_6_1 -pt None -u 0.0038098943796153056 > ./result_8chains/node51_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node51_7_2 -p 867 -st topic51_7_1 -pt None -u 0.008779792619900445 > ./result_8chains/node51_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node51_0_0 -p 188 -st none -pt topic51_0_0 -u 0.005518789040994787 > ./result_8chains/node51_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node51_1_0 -p 196 -st none -pt topic51_1_0 -u 0.0029947038063588005 > ./result_8chains/node51_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node51_2_0 -p 259 -st none -pt topic51_2_0 -u 0.006820700464944152 > ./result_8chains/node51_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node51_3_0 -p 271 -st none -pt topic51_3_0 -u 0.04960925044601949 > ./result_8chains/node51_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node51_4_0 -p 498 -st none -pt topic51_4_0 -u 0.037450398325783674 > ./result_8chains/node51_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node51_5_0 -p 647 -st none -pt topic51_5_0 -u 0.012877032422064338 > ./result_8chains/node51_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node51_6_0 -p 806 -st none -pt topic51_6_0 -u 0.000674806205105849 > ./result_8chains/node51_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node51_7_0 -p 867 -st none -pt topic51_7_0 -u 0.02238156214022151 > ./result_8chains/node51_7_0.txt &
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
    "./result_8chains/node51_0_0.txt 90"
    "./result_8chains/node51_0_2.txt 90"
    "./result_8chains/node51_1_0.txt 89"
    "./result_8chains/node51_1_2.txt 89"
    "./result_8chains/node51_2_0.txt 88"
    "./result_8chains/node51_2_2.txt 88"
    "./result_8chains/node51_3_0.txt 87"
    "./result_8chains/node51_3_2.txt 87"
    "./result_8chains/node51_4_0.txt 86"
    "./result_8chains/node51_4_2.txt 86"
    "./result_8chains/node51_5_0.txt 85"
    "./result_8chains/node51_5_2.txt 85"
    "./result_8chains/node51_6_0.txt 84"
    "./result_8chains/node51_6_2.txt 84"
    "./result_8chains/node51_7_0.txt 83"
    "./result_8chains/node51_7_2.txt 83"
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
