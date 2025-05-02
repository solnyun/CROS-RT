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
ros2 run evaluation_3_randomdag uunifast_node -n node120_0_2 -p 23 -st topic120_0_1 -pt None -u 0.006857942349744739 > ./result_10chains/node120_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node120_1_2 -p 27 -st topic120_1_1 -pt None -u 0.040195526171249496 > ./result_10chains/node120_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node120_2_2 -p 241 -st topic120_2_1 -pt None -u 0.01673653040901113 > ./result_10chains/node120_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node120_3_2 -p 282 -st topic120_3_1 -pt None -u 0.07274789278939961 > ./result_10chains/node120_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node120_4_2 -p 375 -st topic120_4_1 -pt None -u 0.0356829711608925 > ./result_10chains/node120_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node120_5_2 -p 549 -st topic120_5_1 -pt None -u 0.018489580606728756 > ./result_10chains/node120_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node120_6_2 -p 553 -st topic120_6_1 -pt None -u 0.0040729765312968735 > ./result_10chains/node120_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node120_7_2 -p 558 -st topic120_7_1 -pt None -u 0.04048666251366141 > ./result_10chains/node120_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node120_8_2 -p 699 -st topic120_8_1 -pt None -u 0.00990758535891386 > ./result_10chains/node120_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node120_9_2 -p 797 -st topic120_9_1 -pt None -u 0.012457519922586867 > ./result_10chains/node120_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node120_0_0 -p 23 -st none -pt topic120_0_0 -u 0.005522904377234905 > ./result_10chains/node120_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node120_1_0 -p 27 -st none -pt topic120_1_0 -u 0.0003961313208685202 > ./result_10chains/node120_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node120_2_0 -p 241 -st none -pt topic120_2_0 -u 0.0005887479254886308 > ./result_10chains/node120_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node120_3_0 -p 282 -st none -pt topic120_3_0 -u 0.008896504282590256 > ./result_10chains/node120_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node120_4_0 -p 375 -st none -pt topic120_4_0 -u 0.00798961313742727 > ./result_10chains/node120_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node120_5_0 -p 549 -st none -pt topic120_5_0 -u 0.008481787005062857 > ./result_10chains/node120_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node120_6_0 -p 553 -st none -pt topic120_6_0 -u 0.005158323892638983 > ./result_10chains/node120_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node120_7_0 -p 558 -st none -pt topic120_7_0 -u 0.0003925530127954491 > ./result_10chains/node120_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node120_8_0 -p 699 -st none -pt topic120_8_0 -u 0.0021962127589142677 > ./result_10chains/node120_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node120_9_0 -p 797 -st none -pt topic120_9_0 -u 0.010440976664218327 > ./result_10chains/node120_9_0.txt &
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
    "./result_10chains/node120_0_0.txt 90"
    "./result_10chains/node120_0_2.txt 90"
    "./result_10chains/node120_1_0.txt 89"
    "./result_10chains/node120_1_2.txt 89"
    "./result_10chains/node120_2_0.txt 88"
    "./result_10chains/node120_2_2.txt 88"
    "./result_10chains/node120_3_0.txt 87"
    "./result_10chains/node120_3_2.txt 87"
    "./result_10chains/node120_4_0.txt 86"
    "./result_10chains/node120_4_2.txt 86"
    "./result_10chains/node120_5_0.txt 85"
    "./result_10chains/node120_5_2.txt 85"
    "./result_10chains/node120_6_0.txt 84"
    "./result_10chains/node120_6_2.txt 84"
    "./result_10chains/node120_7_0.txt 83"
    "./result_10chains/node120_7_2.txt 83"
    "./result_10chains/node120_8_0.txt 82"
    "./result_10chains/node120_8_2.txt 82"
    "./result_10chains/node120_9_0.txt 81"
    "./result_10chains/node120_9_2.txt 81"
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
