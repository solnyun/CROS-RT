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
ros2 run evaluation_3_randomdag uunifast_node -n node446_0_1 -p 101 -st topic446_0_0 -pt topic446_0_1 -u 0.028729422752318767 > ./result_10chains/node446_0_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node446_1_1 -p 212 -st topic446_1_0 -pt topic446_1_1 -u 0.023536796846954422 > ./result_10chains/node446_1_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node446_2_1 -p 254 -st topic446_2_0 -pt topic446_2_1 -u 0.005876983298616301 > ./result_10chains/node446_2_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node446_3_1 -p 287 -st topic446_3_0 -pt topic446_3_1 -u 0.012285918460399614 > ./result_10chains/node446_3_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node446_4_1 -p 367 -st topic446_4_0 -pt topic446_4_1 -u 0.010986398425296973 > ./result_10chains/node446_4_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node446_5_1 -p 406 -st topic446_5_0 -pt topic446_5_1 -u 0.05943237748684277 > ./result_10chains/node446_5_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node446_6_1 -p 466 -st topic446_6_0 -pt topic446_6_1 -u 0.02584980849353552 > ./result_10chains/node446_6_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node446_7_1 -p 469 -st topic446_7_0 -pt topic446_7_1 -u 0.05475738598486146 > ./result_10chains/node446_7_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node446_8_1 -p 541 -st topic446_8_0 -pt topic446_8_1 -u 0.0003142379027407938 > ./result_10chains/node446_8_1.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node446_9_1 -p 708 -st topic446_9_0 -pt topic446_9_1 -u 0.022674903502451767 > ./result_10chains/node446_9_1.txt &
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
    "./result_10chains/node446_0_1.txt 90"
    "./result_10chains/node446_1_1.txt 89"
    "./result_10chains/node446_2_1.txt 88"
    "./result_10chains/node446_3_1.txt 87"
    "./result_10chains/node446_4_1.txt 86"
    "./result_10chains/node446_5_1.txt 85"
    "./result_10chains/node446_6_1.txt 84"
    "./result_10chains/node446_7_1.txt 83"
    "./result_10chains/node446_8_1.txt 82"
    "./result_10chains/node446_9_1.txt 81"
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
