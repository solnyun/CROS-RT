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
ros2 run evaluation_3_randomdag uunifast_node -n node96_0_2 -p 241 -st topic96_0_1 -pt None -u 0.022017809099348806 > ./result_8chains/node96_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node96_1_2 -p 361 -st topic96_1_1 -pt None -u 0.03543724881462401 > ./result_8chains/node96_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node96_2_2 -p 463 -st topic96_2_1 -pt None -u 0.01340884321597241 > ./result_8chains/node96_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node96_3_2 -p 491 -st topic96_3_1 -pt None -u 0.03197633078499332 > ./result_8chains/node96_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node96_4_2 -p 632 -st topic96_4_1 -pt None -u 0.0046682302666223585 > ./result_8chains/node96_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node96_5_2 -p 830 -st topic96_5_1 -pt None -u 0.021108801435246488 > ./result_8chains/node96_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node96_6_2 -p 955 -st topic96_6_1 -pt None -u 0.06270471753303448 > ./result_8chains/node96_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node96_7_2 -p 983 -st topic96_7_1 -pt None -u 0.018577538528450576 > ./result_8chains/node96_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node96_0_0 -p 241 -st none -pt topic96_0_0 -u 0.05068242640608134 > ./result_8chains/node96_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node96_1_0 -p 361 -st none -pt topic96_1_0 -u 0.021925790537244028 > ./result_8chains/node96_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node96_2_0 -p 463 -st none -pt topic96_2_0 -u 0.029892422226839244 > ./result_8chains/node96_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node96_3_0 -p 491 -st none -pt topic96_3_0 -u 0.0016822169076118887 > ./result_8chains/node96_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node96_4_0 -p 632 -st none -pt topic96_4_0 -u 0.006540136646374928 > ./result_8chains/node96_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node96_5_0 -p 830 -st none -pt topic96_5_0 -u 0.03975894792840215 > ./result_8chains/node96_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node96_6_0 -p 955 -st none -pt topic96_6_0 -u 0.01073650715607069 > ./result_8chains/node96_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node96_7_0 -p 983 -st none -pt topic96_7_0 -u 0.0039023124497504502 > ./result_8chains/node96_7_0.txt &
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
    "./result_8chains/node96_0_0.txt 90"
    "./result_8chains/node96_0_2.txt 90"
    "./result_8chains/node96_1_0.txt 89"
    "./result_8chains/node96_1_2.txt 89"
    "./result_8chains/node96_2_0.txt 88"
    "./result_8chains/node96_2_2.txt 88"
    "./result_8chains/node96_3_0.txt 87"
    "./result_8chains/node96_3_2.txt 87"
    "./result_8chains/node96_4_0.txt 86"
    "./result_8chains/node96_4_2.txt 86"
    "./result_8chains/node96_5_0.txt 85"
    "./result_8chains/node96_5_2.txt 85"
    "./result_8chains/node96_6_0.txt 84"
    "./result_8chains/node96_6_2.txt 84"
    "./result_8chains/node96_7_0.txt 83"
    "./result_8chains/node96_7_2.txt 83"
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
