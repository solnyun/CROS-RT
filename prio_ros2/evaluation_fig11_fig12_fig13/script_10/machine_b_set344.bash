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
ros2 run evaluation_3_randomdag uunifast_node -n node344_0_1 -p 20 -st topic344_0_0 -pt topic344_0_1 -u 0.0032035138294567167 > ./result_10chains/node344_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node344_1_1 -p 61 -st topic344_1_0 -pt topic344_1_1 -u 0.0035879420545380514 > ./result_10chains/node344_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node344_2_1 -p 117 -st topic344_2_0 -pt topic344_2_1 -u 6.405787669599983e-05 > ./result_10chains/node344_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node344_3_1 -p 179 -st topic344_3_0 -pt topic344_3_1 -u 0.013443184038375855 > ./result_10chains/node344_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node344_4_1 -p 323 -st topic344_4_0 -pt topic344_4_1 -u 0.028781622034670162 > ./result_10chains/node344_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node344_5_1 -p 835 -st topic344_5_0 -pt topic344_5_1 -u 0.010193376838334323 > ./result_10chains/node344_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node344_6_1 -p 901 -st topic344_6_0 -pt topic344_6_1 -u 0.0007632586339873515 > ./result_10chains/node344_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node344_7_1 -p 914 -st topic344_7_0 -pt topic344_7_1 -u 0.048922015037485084 > ./result_10chains/node344_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node344_8_1 -p 949 -st topic344_8_0 -pt topic344_8_1 -u 0.0029106077544682266 > ./result_10chains/node344_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node344_9_1 -p 970 -st topic344_9_0 -pt topic344_9_1 -u 0.012967078935998234 > ./result_10chains/node344_9_1.txt &
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
    "./result_10chains/node344_0_1.txt 90"
    "./result_10chains/node344_1_1.txt 89"
    "./result_10chains/node344_2_1.txt 88"
    "./result_10chains/node344_3_1.txt 87"
    "./result_10chains/node344_4_1.txt 86"
    "./result_10chains/node344_5_1.txt 85"
    "./result_10chains/node344_6_1.txt 84"
    "./result_10chains/node344_7_1.txt 83"
    "./result_10chains/node344_8_1.txt 82"
    "./result_10chains/node344_9_1.txt 81"
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
/home/orin2/prio_ros2/evaluation_2_fig10/wait_signal 192.168.0.21 9797
echo "End Running"
sudo pkill uunifast_node
finalize_framework
