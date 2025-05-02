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
ros2 run evaluation_3_randomdag uunifast_node -n node381_0_2 -p 59 -st topic381_0_1 -pt None -u 0.02128531972854464 > ./result_8chains/node381_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node381_1_2 -p 64 -st topic381_1_1 -pt None -u 0.046295543706284414 > ./result_8chains/node381_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node381_2_2 -p 92 -st topic381_2_1 -pt None -u 0.014372458636009555 > ./result_8chains/node381_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node381_3_2 -p 225 -st topic381_3_1 -pt None -u 0.004620791862268464 > ./result_8chains/node381_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node381_4_2 -p 549 -st topic381_4_1 -pt None -u 0.005332102124799676 > ./result_8chains/node381_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node381_5_2 -p 696 -st topic381_5_1 -pt None -u 0.01450454526316075 > ./result_8chains/node381_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node381_6_2 -p 865 -st topic381_6_1 -pt None -u 0.008539920233716317 > ./result_8chains/node381_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node381_7_2 -p 880 -st topic381_7_1 -pt None -u 0.06472446351330982 > ./result_8chains/node381_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node381_0_0 -p 59 -st none -pt topic381_0_0 -u 0.006804152833409682 > ./result_8chains/node381_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node381_1_0 -p 64 -st none -pt topic381_1_0 -u 0.011532893214673878 > ./result_8chains/node381_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node381_2_0 -p 92 -st none -pt topic381_2_0 -u 0.022775657158899953 > ./result_8chains/node381_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node381_3_0 -p 225 -st none -pt topic381_3_0 -u 0.07461211934994944 > ./result_8chains/node381_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node381_4_0 -p 549 -st none -pt topic381_4_0 -u 0.012648624808613229 > ./result_8chains/node381_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node381_5_0 -p 696 -st none -pt topic381_5_0 -u 0.024884477819877487 > ./result_8chains/node381_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node381_6_0 -p 865 -st none -pt topic381_6_0 -u 0.02068153874979664 > ./result_8chains/node381_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node381_7_0 -p 880 -st none -pt topic381_7_0 -u 0.004903208286586663 > ./result_8chains/node381_7_0.txt &
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
    "./result_8chains/node381_0_0.txt 90"
    "./result_8chains/node381_0_2.txt 90"
    "./result_8chains/node381_1_0.txt 89"
    "./result_8chains/node381_1_2.txt 89"
    "./result_8chains/node381_2_0.txt 88"
    "./result_8chains/node381_2_2.txt 88"
    "./result_8chains/node381_3_0.txt 87"
    "./result_8chains/node381_3_2.txt 87"
    "./result_8chains/node381_4_0.txt 86"
    "./result_8chains/node381_4_2.txt 86"
    "./result_8chains/node381_5_0.txt 85"
    "./result_8chains/node381_5_2.txt 85"
    "./result_8chains/node381_6_0.txt 84"
    "./result_8chains/node381_6_2.txt 84"
    "./result_8chains/node381_7_0.txt 83"
    "./result_8chains/node381_7_2.txt 83"
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
