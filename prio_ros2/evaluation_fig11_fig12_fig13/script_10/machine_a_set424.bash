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
ros2 run evaluation_3_randomdag uunifast_node -n node424_0_2 -p 108 -st topic424_0_1 -pt None -u 0.0030108090907350893 > ./result_10chains/node424_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node424_1_2 -p 116 -st topic424_1_1 -pt None -u 0.014222681761166256 > ./result_10chains/node424_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node424_2_2 -p 218 -st topic424_2_1 -pt None -u 0.00041202956051167305 > ./result_10chains/node424_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node424_3_2 -p 352 -st topic424_3_1 -pt None -u 0.03608617614938198 > ./result_10chains/node424_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node424_4_2 -p 371 -st topic424_4_1 -pt None -u 0.010615269540817651 > ./result_10chains/node424_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node424_5_2 -p 461 -st topic424_5_1 -pt None -u 0.06822514543598804 > ./result_10chains/node424_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node424_6_2 -p 660 -st topic424_6_1 -pt None -u 0.016086095688363028 > ./result_10chains/node424_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node424_7_2 -p 801 -st topic424_7_1 -pt None -u 0.014450503225703307 > ./result_10chains/node424_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node424_8_2 -p 828 -st topic424_8_1 -pt None -u 0.012668907905374817 > ./result_10chains/node424_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node424_9_2 -p 934 -st topic424_9_1 -pt None -u 0.0023592715449443536 > ./result_10chains/node424_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node424_0_0 -p 108 -st none -pt topic424_0_0 -u 0.009068255986397988 > ./result_10chains/node424_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node424_1_0 -p 116 -st none -pt topic424_1_0 -u 0.003327875064711938 > ./result_10chains/node424_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node424_2_0 -p 218 -st none -pt topic424_2_0 -u 0.009557866432763462 > ./result_10chains/node424_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node424_3_0 -p 352 -st none -pt topic424_3_0 -u 0.0041093786368899266 > ./result_10chains/node424_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node424_4_0 -p 371 -st none -pt topic424_4_0 -u 0.0058683915277040755 > ./result_10chains/node424_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node424_5_0 -p 461 -st none -pt topic424_5_0 -u 0.02021015867603071 > ./result_10chains/node424_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node424_6_0 -p 660 -st none -pt topic424_6_0 -u 0.03523332061682341 > ./result_10chains/node424_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node424_7_0 -p 801 -st none -pt topic424_7_0 -u 0.0022897883110309936 > ./result_10chains/node424_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node424_8_0 -p 828 -st none -pt topic424_8_0 -u 0.010919217311812321 > ./result_10chains/node424_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node424_9_0 -p 934 -st none -pt topic424_9_0 -u 0.04110524931498636 > ./result_10chains/node424_9_0.txt &
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
    "./result_10chains/node424_0_0.txt 90"
    "./result_10chains/node424_0_2.txt 90"
    "./result_10chains/node424_1_0.txt 89"
    "./result_10chains/node424_1_2.txt 89"
    "./result_10chains/node424_2_0.txt 88"
    "./result_10chains/node424_2_2.txt 88"
    "./result_10chains/node424_3_0.txt 87"
    "./result_10chains/node424_3_2.txt 87"
    "./result_10chains/node424_4_0.txt 86"
    "./result_10chains/node424_4_2.txt 86"
    "./result_10chains/node424_5_0.txt 85"
    "./result_10chains/node424_5_2.txt 85"
    "./result_10chains/node424_6_0.txt 84"
    "./result_10chains/node424_6_2.txt 84"
    "./result_10chains/node424_7_0.txt 83"
    "./result_10chains/node424_7_2.txt 83"
    "./result_10chains/node424_8_0.txt 82"
    "./result_10chains/node424_8_2.txt 82"
    "./result_10chains/node424_9_0.txt 81"
    "./result_10chains/node424_9_2.txt 81"
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
