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
ros2 run evaluation_3_randomdag uunifast_node -n node274_0_2 -p 35 -st topic274_0_1 -pt None -u 0.0256747946905439 > ./result_10chains/node274_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node274_1_2 -p 71 -st topic274_1_1 -pt None -u 0.004139821266859134 > ./result_10chains/node274_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node274_2_2 -p 222 -st topic274_2_1 -pt None -u 0.01988537268375784 > ./result_10chains/node274_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node274_3_2 -p 230 -st topic274_3_1 -pt None -u 0.008623983119741108 > ./result_10chains/node274_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node274_4_2 -p 257 -st topic274_4_1 -pt None -u 0.021248987007866788 > ./result_10chains/node274_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node274_5_2 -p 417 -st topic274_5_1 -pt None -u 0.023450770223693268 > ./result_10chains/node274_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node274_6_2 -p 454 -st topic274_6_1 -pt None -u 0.008528697101230276 > ./result_10chains/node274_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node274_7_2 -p 634 -st topic274_7_1 -pt None -u 0.0034627437933903715 > ./result_10chains/node274_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node274_8_2 -p 658 -st topic274_8_1 -pt None -u 0.004100220288404007 > ./result_10chains/node274_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node274_9_2 -p 738 -st topic274_9_1 -pt None -u 0.010682346162734965 > ./result_10chains/node274_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node274_0_0 -p 35 -st none -pt topic274_0_0 -u 0.000958826961067305 > ./result_10chains/node274_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node274_1_0 -p 71 -st none -pt topic274_1_0 -u 0.00820377353315288 > ./result_10chains/node274_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node274_2_0 -p 222 -st none -pt topic274_2_0 -u 0.02252761738893877 > ./result_10chains/node274_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node274_3_0 -p 230 -st none -pt topic274_3_0 -u 0.0710878527243019 > ./result_10chains/node274_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node274_4_0 -p 257 -st none -pt topic274_4_0 -u 0.0485353441395322 > ./result_10chains/node274_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node274_5_0 -p 417 -st none -pt topic274_5_0 -u 0.008934632305025225 > ./result_10chains/node274_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node274_6_0 -p 454 -st none -pt topic274_6_0 -u 0.03317648472770984 > ./result_10chains/node274_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node274_7_0 -p 634 -st none -pt topic274_7_0 -u 0.013363078219658708 > ./result_10chains/node274_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node274_8_0 -p 658 -st none -pt topic274_8_0 -u 0.01749584477360796 > ./result_10chains/node274_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node274_9_0 -p 738 -st none -pt topic274_9_0 -u 0.0019377584687407974 > ./result_10chains/node274_9_0.txt &
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
    "./result_10chains/node274_0_0.txt 90"
    "./result_10chains/node274_0_2.txt 90"
    "./result_10chains/node274_1_0.txt 89"
    "./result_10chains/node274_1_2.txt 89"
    "./result_10chains/node274_2_0.txt 88"
    "./result_10chains/node274_2_2.txt 88"
    "./result_10chains/node274_3_0.txt 87"
    "./result_10chains/node274_3_2.txt 87"
    "./result_10chains/node274_4_0.txt 86"
    "./result_10chains/node274_4_2.txt 86"
    "./result_10chains/node274_5_0.txt 85"
    "./result_10chains/node274_5_2.txt 85"
    "./result_10chains/node274_6_0.txt 84"
    "./result_10chains/node274_6_2.txt 84"
    "./result_10chains/node274_7_0.txt 83"
    "./result_10chains/node274_7_2.txt 83"
    "./result_10chains/node274_8_0.txt 82"
    "./result_10chains/node274_8_2.txt 82"
    "./result_10chains/node274_9_0.txt 81"
    "./result_10chains/node274_9_2.txt 81"
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
