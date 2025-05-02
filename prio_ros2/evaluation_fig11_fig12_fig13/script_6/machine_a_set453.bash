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
ros2 run evaluation_3_randomdag uunifast_node -n node453_0_2 -p 459 -st topic453_0_1 -pt None -u 0.011494627463644658 > ./result_6chains/node453_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node453_1_2 -p 652 -st topic453_1_1 -pt None -u 0.020864339466760556 > ./result_6chains/node453_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node453_2_2 -p 682 -st topic453_2_1 -pt None -u 0.018430908098220428 > ./result_6chains/node453_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node453_3_2 -p 733 -st topic453_3_1 -pt None -u 0.01143242295487984 > ./result_6chains/node453_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node453_4_2 -p 961 -st topic453_4_1 -pt None -u 0.017068025386491797 > ./result_6chains/node453_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node453_5_2 -p 984 -st topic453_5_1 -pt None -u 0.001845791986998255 > ./result_6chains/node453_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node453_0_0 -p 459 -st none -pt topic453_0_0 -u 0.08084069571800712 > ./result_6chains/node453_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node453_1_0 -p 652 -st none -pt topic453_1_0 -u 0.09298442822398995 > ./result_6chains/node453_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node453_2_0 -p 682 -st none -pt topic453_2_0 -u 0.017396630627091986 > ./result_6chains/node453_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node453_3_0 -p 733 -st none -pt topic453_3_0 -u 0.02049209041475475 > ./result_6chains/node453_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node453_4_0 -p 961 -st none -pt topic453_4_0 -u 0.018120522303674752 > ./result_6chains/node453_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node453_5_0 -p 984 -st none -pt topic453_5_0 -u 0.06235252842240037 > ./result_6chains/node453_5_0.txt &
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
    "./result_6chains/node453_0_0.txt 90"
    "./result_6chains/node453_0_2.txt 90"
    "./result_6chains/node453_1_0.txt 89"
    "./result_6chains/node453_1_2.txt 89"
    "./result_6chains/node453_2_0.txt 88"
    "./result_6chains/node453_2_2.txt 88"
    "./result_6chains/node453_3_0.txt 87"
    "./result_6chains/node453_3_2.txt 87"
    "./result_6chains/node453_4_0.txt 86"
    "./result_6chains/node453_4_2.txt 86"
    "./result_6chains/node453_5_0.txt 85"
    "./result_6chains/node453_5_2.txt 85"
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
sleep 130s
sudo pkill -USR1 uunifast_node
echo "Set timer signal!"
sleep 200s
echo "End Running"
sudo pkill uunifast_node
finalize_framework
/home/orin5/prio_ros2/evaluation_2_fig10/send_signal 127.0.0.1 9999
