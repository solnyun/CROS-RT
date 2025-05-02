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
ros2 run evaluation_3_randomdag uunifast_node -n node351_0_2 -p 53 -st topic351_0_1 -pt None -u 0.005054844629660493 > ./result_8chains/node351_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node351_1_2 -p 165 -st topic351_1_1 -pt None -u 0.030676189107914975 > ./result_8chains/node351_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node351_2_2 -p 196 -st topic351_2_1 -pt None -u 0.004893751595820062 > ./result_8chains/node351_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node351_3_2 -p 211 -st topic351_3_1 -pt None -u 0.0239019960575646 > ./result_8chains/node351_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node351_4_2 -p 282 -st topic351_4_1 -pt None -u 0.07117564616244071 > ./result_8chains/node351_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node351_5_2 -p 312 -st topic351_5_1 -pt None -u 0.01770688161708031 > ./result_8chains/node351_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node351_6_2 -p 656 -st topic351_6_1 -pt None -u 0.01851136173683421 > ./result_8chains/node351_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node351_7_2 -p 906 -st topic351_7_1 -pt None -u 0.03907029670875847 > ./result_8chains/node351_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node351_0_0 -p 53 -st none -pt topic351_0_0 -u 0.022706158976798063 > ./result_8chains/node351_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node351_1_0 -p 165 -st none -pt topic351_1_0 -u 0.027988547807455078 > ./result_8chains/node351_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node351_2_0 -p 196 -st none -pt topic351_2_0 -u 0.02081395409368758 > ./result_8chains/node351_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node351_3_0 -p 211 -st none -pt topic351_3_0 -u 0.01765728298749336 > ./result_8chains/node351_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node351_4_0 -p 282 -st none -pt topic351_4_0 -u 0.017647150475000206 > ./result_8chains/node351_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node351_5_0 -p 312 -st none -pt topic351_5_0 -u 0.006152204584876114 > ./result_8chains/node351_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node351_6_0 -p 656 -st none -pt topic351_6_0 -u 0.01107638179847742 > ./result_8chains/node351_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node351_7_0 -p 906 -st none -pt topic351_7_0 -u 0.03751456939467908 > ./result_8chains/node351_7_0.txt &
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
    "./result_8chains/node351_0_0.txt 90"
    "./result_8chains/node351_0_2.txt 90"
    "./result_8chains/node351_1_0.txt 89"
    "./result_8chains/node351_1_2.txt 89"
    "./result_8chains/node351_2_0.txt 88"
    "./result_8chains/node351_2_2.txt 88"
    "./result_8chains/node351_3_0.txt 87"
    "./result_8chains/node351_3_2.txt 87"
    "./result_8chains/node351_4_0.txt 86"
    "./result_8chains/node351_4_2.txt 86"
    "./result_8chains/node351_5_0.txt 85"
    "./result_8chains/node351_5_2.txt 85"
    "./result_8chains/node351_6_0.txt 84"
    "./result_8chains/node351_6_2.txt 84"
    "./result_8chains/node351_7_0.txt 83"
    "./result_8chains/node351_7_2.txt 83"
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
