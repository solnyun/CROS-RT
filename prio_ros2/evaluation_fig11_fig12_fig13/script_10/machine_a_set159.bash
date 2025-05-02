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
ros2 run evaluation_3_randomdag uunifast_node -n node159_0_2 -p 445 -st topic159_0_1 -pt None -u 0.004438090550581586 > ./result_10chains/node159_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node159_1_2 -p 458 -st topic159_1_1 -pt None -u 0.013952314137501587 > ./result_10chains/node159_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node159_2_2 -p 583 -st topic159_2_1 -pt None -u 0.010051368955879936 > ./result_10chains/node159_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node159_3_2 -p 634 -st topic159_3_1 -pt None -u 0.010274585704310668 > ./result_10chains/node159_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node159_4_2 -p 649 -st topic159_4_1 -pt None -u 0.01906442545652881 > ./result_10chains/node159_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node159_5_2 -p 661 -st topic159_5_1 -pt None -u 0.0023432229500731094 > ./result_10chains/node159_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node159_6_2 -p 733 -st topic159_6_1 -pt None -u 0.0128623807141518 > ./result_10chains/node159_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node159_7_2 -p 756 -st topic159_7_1 -pt None -u 0.022179982601789605 > ./result_10chains/node159_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node159_8_2 -p 808 -st topic159_8_1 -pt None -u 0.0029012690507083175 > ./result_10chains/node159_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node159_9_2 -p 866 -st topic159_9_1 -pt None -u 0.010273466583771302 > ./result_10chains/node159_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node159_0_0 -p 445 -st none -pt topic159_0_0 -u 0.02322763739959849 > ./result_10chains/node159_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node159_1_0 -p 458 -st none -pt topic159_1_0 -u 0.01540456012079583 > ./result_10chains/node159_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node159_2_0 -p 583 -st none -pt topic159_2_0 -u 0.012485865060067602 > ./result_10chains/node159_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node159_3_0 -p 634 -st none -pt topic159_3_0 -u 0.008640950892076782 > ./result_10chains/node159_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node159_4_0 -p 649 -st none -pt topic159_4_0 -u 0.006506262647499095 > ./result_10chains/node159_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node159_5_0 -p 661 -st none -pt topic159_5_0 -u 0.05688683252083532 > ./result_10chains/node159_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node159_6_0 -p 733 -st none -pt topic159_6_0 -u 0.010101668553912313 > ./result_10chains/node159_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node159_7_0 -p 756 -st none -pt topic159_7_0 -u 0.006739210220801428 > ./result_10chains/node159_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node159_8_0 -p 808 -st none -pt topic159_8_0 -u 0.0039734463361483785 > ./result_10chains/node159_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node159_9_0 -p 866 -st none -pt topic159_9_0 -u 0.016784864177217907 > ./result_10chains/node159_9_0.txt &
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
    "./result_10chains/node159_0_0.txt 90"
    "./result_10chains/node159_0_2.txt 90"
    "./result_10chains/node159_1_0.txt 89"
    "./result_10chains/node159_1_2.txt 89"
    "./result_10chains/node159_2_0.txt 88"
    "./result_10chains/node159_2_2.txt 88"
    "./result_10chains/node159_3_0.txt 87"
    "./result_10chains/node159_3_2.txt 87"
    "./result_10chains/node159_4_0.txt 86"
    "./result_10chains/node159_4_2.txt 86"
    "./result_10chains/node159_5_0.txt 85"
    "./result_10chains/node159_5_2.txt 85"
    "./result_10chains/node159_6_0.txt 84"
    "./result_10chains/node159_6_2.txt 84"
    "./result_10chains/node159_7_0.txt 83"
    "./result_10chains/node159_7_2.txt 83"
    "./result_10chains/node159_8_0.txt 82"
    "./result_10chains/node159_8_2.txt 82"
    "./result_10chains/node159_9_0.txt 81"
    "./result_10chains/node159_9_2.txt 81"
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
