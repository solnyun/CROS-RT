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
ros2 run evaluation_3_randomdag uunifast_node -n node122_0_2 -p 483 -st topic122_0_1 -pt None -u 0.012908986390494093 > ./result_6chains/node122_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node122_1_2 -p 493 -st topic122_1_1 -pt None -u 0.026112393057740324 > ./result_6chains/node122_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node122_2_2 -p 660 -st topic122_2_1 -pt None -u 0.005148029316468461 > ./result_6chains/node122_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node122_3_2 -p 711 -st topic122_3_1 -pt None -u 0.10681029361496971 > ./result_6chains/node122_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node122_4_2 -p 798 -st topic122_4_1 -pt None -u 0.06586459381674567 > ./result_6chains/node122_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node122_5_2 -p 842 -st topic122_5_1 -pt None -u 0.016291869793890638 > ./result_6chains/node122_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node122_0_0 -p 483 -st none -pt topic122_0_0 -u 0.018214897352229642 > ./result_6chains/node122_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node122_1_0 -p 493 -st none -pt topic122_1_0 -u 0.006994149999857757 > ./result_6chains/node122_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node122_2_0 -p 660 -st none -pt topic122_2_0 -u 0.021976077133739225 > ./result_6chains/node122_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node122_3_0 -p 711 -st none -pt topic122_3_0 -u 0.010820456508456644 > ./result_6chains/node122_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node122_4_0 -p 798 -st none -pt topic122_4_0 -u 0.011688187837907815 > ./result_6chains/node122_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node122_5_0 -p 842 -st none -pt topic122_5_0 -u 0.02657536420396785 > ./result_6chains/node122_5_0.txt &
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
    "./result_6chains/node122_0_0.txt 90"
    "./result_6chains/node122_0_2.txt 90"
    "./result_6chains/node122_1_0.txt 89"
    "./result_6chains/node122_1_2.txt 89"
    "./result_6chains/node122_2_0.txt 88"
    "./result_6chains/node122_2_2.txt 88"
    "./result_6chains/node122_3_0.txt 87"
    "./result_6chains/node122_3_2.txt 87"
    "./result_6chains/node122_4_0.txt 86"
    "./result_6chains/node122_4_2.txt 86"
    "./result_6chains/node122_5_0.txt 85"
    "./result_6chains/node122_5_2.txt 85"
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
