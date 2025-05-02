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
ros2 run evaluation_3_randomdag uunifast_node -n node154_0_2 -p 53 -st topic154_0_1 -pt None -u 0.013786452242875225 > ./result_10chains/node154_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node154_1_2 -p 74 -st topic154_1_1 -pt None -u 0.0155578795265221 > ./result_10chains/node154_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node154_2_2 -p 117 -st topic154_2_1 -pt None -u 0.010924144844150052 > ./result_10chains/node154_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node154_3_2 -p 208 -st topic154_3_1 -pt None -u 6.219952899177983e-05 > ./result_10chains/node154_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node154_4_2 -p 286 -st topic154_4_1 -pt None -u 0.00245859687614175 > ./result_10chains/node154_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node154_5_2 -p 310 -st topic154_5_1 -pt None -u 0.05839633315826975 > ./result_10chains/node154_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node154_6_2 -p 374 -st topic154_6_1 -pt None -u 0.015472061866243947 > ./result_10chains/node154_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node154_7_2 -p 463 -st topic154_7_1 -pt None -u 0.001414148490179637 > ./result_10chains/node154_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node154_8_2 -p 869 -st topic154_8_1 -pt None -u 0.004100337370844899 > ./result_10chains/node154_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node154_9_2 -p 874 -st topic154_9_1 -pt None -u 0.02549238319352467 > ./result_10chains/node154_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node154_0_0 -p 53 -st none -pt topic154_0_0 -u 0.020658028638043946 > ./result_10chains/node154_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node154_1_0 -p 74 -st none -pt topic154_1_0 -u 0.051700256091095076 > ./result_10chains/node154_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node154_2_0 -p 117 -st none -pt topic154_2_0 -u 0.010571178114047008 > ./result_10chains/node154_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node154_3_0 -p 208 -st none -pt topic154_3_0 -u 0.05136943295501173 > ./result_10chains/node154_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node154_4_0 -p 286 -st none -pt topic154_4_0 -u 0.004245251161750896 > ./result_10chains/node154_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node154_5_0 -p 310 -st none -pt topic154_5_0 -u 0.013797480398669404 > ./result_10chains/node154_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node154_6_0 -p 374 -st none -pt topic154_6_0 -u 0.04984539191765927 > ./result_10chains/node154_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node154_7_0 -p 463 -st none -pt topic154_7_0 -u 0.01491550504501249 > ./result_10chains/node154_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node154_8_0 -p 869 -st none -pt topic154_8_0 -u 0.011821510503514883 > ./result_10chains/node154_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node154_9_0 -p 874 -st none -pt topic154_9_0 -u 0.020925608071258157 > ./result_10chains/node154_9_0.txt &
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
    "./result_10chains/node154_0_0.txt 90"
    "./result_10chains/node154_0_2.txt 90"
    "./result_10chains/node154_1_0.txt 89"
    "./result_10chains/node154_1_2.txt 89"
    "./result_10chains/node154_2_0.txt 88"
    "./result_10chains/node154_2_2.txt 88"
    "./result_10chains/node154_3_0.txt 87"
    "./result_10chains/node154_3_2.txt 87"
    "./result_10chains/node154_4_0.txt 86"
    "./result_10chains/node154_4_2.txt 86"
    "./result_10chains/node154_5_0.txt 85"
    "./result_10chains/node154_5_2.txt 85"
    "./result_10chains/node154_6_0.txt 84"
    "./result_10chains/node154_6_2.txt 84"
    "./result_10chains/node154_7_0.txt 83"
    "./result_10chains/node154_7_2.txt 83"
    "./result_10chains/node154_8_0.txt 82"
    "./result_10chains/node154_8_2.txt 82"
    "./result_10chains/node154_9_0.txt 81"
    "./result_10chains/node154_9_2.txt 81"
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
