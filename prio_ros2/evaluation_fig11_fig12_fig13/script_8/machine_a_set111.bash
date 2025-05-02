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
ros2 run evaluation_3_randomdag uunifast_node -n node111_0_2 -p 286 -st topic111_0_1 -pt None -u 0.0023013510705323093 > ./result_8chains/node111_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node111_1_2 -p 365 -st topic111_1_1 -pt None -u 0.002363167697293861 > ./result_8chains/node111_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node111_2_2 -p 418 -st topic111_2_1 -pt None -u 0.010602823979767695 > ./result_8chains/node111_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node111_3_2 -p 582 -st topic111_3_1 -pt None -u 0.0006227830621752806 > ./result_8chains/node111_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node111_4_2 -p 711 -st topic111_4_1 -pt None -u 0.03068999388223015 > ./result_8chains/node111_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node111_5_2 -p 774 -st topic111_5_1 -pt None -u 0.006798948898072796 > ./result_8chains/node111_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node111_6_2 -p 810 -st topic111_6_1 -pt None -u 0.008936536866398524 > ./result_8chains/node111_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node111_7_2 -p 966 -st topic111_7_1 -pt None -u 0.020428587468267992 > ./result_8chains/node111_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node111_0_0 -p 286 -st none -pt topic111_0_0 -u 0.04200371609322184 > ./result_8chains/node111_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node111_1_0 -p 365 -st none -pt topic111_1_0 -u 0.02653595510210771 > ./result_8chains/node111_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node111_2_0 -p 418 -st none -pt topic111_2_0 -u 0.016160228631851847 > ./result_8chains/node111_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node111_3_0 -p 582 -st none -pt topic111_3_0 -u 0.005307778663880214 > ./result_8chains/node111_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node111_4_0 -p 711 -st none -pt topic111_4_0 -u 0.002328776138266847 > ./result_8chains/node111_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node111_5_0 -p 774 -st none -pt topic111_5_0 -u 0.018323847346845515 > ./result_8chains/node111_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node111_6_0 -p 810 -st none -pt topic111_6_0 -u 0.027449617545109217 > ./result_8chains/node111_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node111_7_0 -p 966 -st none -pt topic111_7_0 -u 0.017154714074417227 > ./result_8chains/node111_7_0.txt &
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
    "./result_8chains/node111_0_0.txt 90"
    "./result_8chains/node111_0_2.txt 90"
    "./result_8chains/node111_1_0.txt 89"
    "./result_8chains/node111_1_2.txt 89"
    "./result_8chains/node111_2_0.txt 88"
    "./result_8chains/node111_2_2.txt 88"
    "./result_8chains/node111_3_0.txt 87"
    "./result_8chains/node111_3_2.txt 87"
    "./result_8chains/node111_4_0.txt 86"
    "./result_8chains/node111_4_2.txt 86"
    "./result_8chains/node111_5_0.txt 85"
    "./result_8chains/node111_5_2.txt 85"
    "./result_8chains/node111_6_0.txt 84"
    "./result_8chains/node111_6_2.txt 84"
    "./result_8chains/node111_7_0.txt 83"
    "./result_8chains/node111_7_2.txt 83"
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
