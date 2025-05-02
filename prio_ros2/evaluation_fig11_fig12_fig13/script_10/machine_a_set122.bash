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
ros2 run evaluation_3_randomdag uunifast_node -n node122_0_2 -p 62 -st topic122_0_1 -pt None -u 0.02521793278733786 > ./result_10chains/node122_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node122_1_2 -p 142 -st topic122_1_1 -pt None -u 0.009344385645297215 > ./result_10chains/node122_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node122_2_2 -p 177 -st topic122_2_1 -pt None -u 0.0031829554087894896 > ./result_10chains/node122_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node122_3_2 -p 214 -st topic122_3_1 -pt None -u 0.005687486624113447 > ./result_10chains/node122_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node122_4_2 -p 298 -st topic122_4_1 -pt None -u 0.009409390550540353 > ./result_10chains/node122_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node122_5_2 -p 506 -st topic122_5_1 -pt None -u 0.010829146575723647 > ./result_10chains/node122_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node122_6_2 -p 690 -st topic122_6_1 -pt None -u 0.0004582088355055136 > ./result_10chains/node122_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node122_7_2 -p 727 -st topic122_7_1 -pt None -u 0.007586244812650744 > ./result_10chains/node122_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node122_8_2 -p 887 -st topic122_8_1 -pt None -u 0.01153494999006792 > ./result_10chains/node122_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node122_9_2 -p 950 -st topic122_9_1 -pt None -u 0.016445687462369282 > ./result_10chains/node122_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node122_0_0 -p 62 -st none -pt topic122_0_0 -u 0.009935789102012371 > ./result_10chains/node122_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node122_1_0 -p 142 -st none -pt topic122_1_0 -u 0.016229890830025073 > ./result_10chains/node122_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node122_2_0 -p 177 -st none -pt topic122_2_0 -u 0.00233781779603337 > ./result_10chains/node122_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node122_3_0 -p 214 -st none -pt topic122_3_0 -u 0.02848808222009619 > ./result_10chains/node122_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node122_4_0 -p 298 -st none -pt topic122_4_0 -u 0.004417969699929969 > ./result_10chains/node122_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node122_5_0 -p 506 -st none -pt topic122_5_0 -u 0.007755907131173023 > ./result_10chains/node122_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node122_6_0 -p 690 -st none -pt topic122_6_0 -u 0.03403546502567087 > ./result_10chains/node122_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node122_7_0 -p 727 -st none -pt topic122_7_0 -u 0.0002187333772223632 > ./result_10chains/node122_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node122_8_0 -p 887 -st none -pt topic122_8_0 -u 0.0099140976788894 > ./result_10chains/node122_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node122_9_0 -p 950 -st none -pt topic122_9_0 -u 0.01779967340156964 > ./result_10chains/node122_9_0.txt &
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
    "./result_10chains/node122_0_0.txt 90"
    "./result_10chains/node122_0_2.txt 90"
    "./result_10chains/node122_1_0.txt 89"
    "./result_10chains/node122_1_2.txt 89"
    "./result_10chains/node122_2_0.txt 88"
    "./result_10chains/node122_2_2.txt 88"
    "./result_10chains/node122_3_0.txt 87"
    "./result_10chains/node122_3_2.txt 87"
    "./result_10chains/node122_4_0.txt 86"
    "./result_10chains/node122_4_2.txt 86"
    "./result_10chains/node122_5_0.txt 85"
    "./result_10chains/node122_5_2.txt 85"
    "./result_10chains/node122_6_0.txt 84"
    "./result_10chains/node122_6_2.txt 84"
    "./result_10chains/node122_7_0.txt 83"
    "./result_10chains/node122_7_2.txt 83"
    "./result_10chains/node122_8_0.txt 82"
    "./result_10chains/node122_8_2.txt 82"
    "./result_10chains/node122_9_0.txt 81"
    "./result_10chains/node122_9_2.txt 81"
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
