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
ros2 run evaluation_3_randomdag uunifast_node -n node477_0_2 -p 52 -st topic477_0_1 -pt None -u 0.01197212254294372 > ./result_10chains/node477_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node477_1_2 -p 92 -st topic477_1_1 -pt None -u 0.011397120103790626 > ./result_10chains/node477_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node477_2_2 -p 110 -st topic477_2_1 -pt None -u 0.05979076511792075 > ./result_10chains/node477_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node477_3_2 -p 305 -st topic477_3_1 -pt None -u 0.017999220317383685 > ./result_10chains/node477_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node477_4_2 -p 465 -st topic477_4_1 -pt None -u 0.044745477862611654 > ./result_10chains/node477_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node477_5_2 -p 514 -st topic477_5_1 -pt None -u 0.004295442119585768 > ./result_10chains/node477_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node477_6_2 -p 711 -st topic477_6_1 -pt None -u 0.012468480051075315 > ./result_10chains/node477_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node477_7_2 -p 789 -st topic477_7_1 -pt None -u 0.002396878405082528 > ./result_10chains/node477_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node477_8_2 -p 825 -st topic477_8_1 -pt None -u 0.006793275973572058 > ./result_10chains/node477_8_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node477_9_2 -p 834 -st topic477_9_1 -pt None -u 0.025201549006266945 > ./result_10chains/node477_9_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node477_0_0 -p 52 -st none -pt topic477_0_0 -u 0.01332730947538413 > ./result_10chains/node477_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node477_1_0 -p 92 -st none -pt topic477_1_0 -u 0.0013432973928203529 > ./result_10chains/node477_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node477_2_0 -p 110 -st none -pt topic477_2_0 -u 0.0212511412315603 > ./result_10chains/node477_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node477_3_0 -p 305 -st none -pt topic477_3_0 -u 0.11490137952337545 > ./result_10chains/node477_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node477_4_0 -p 465 -st none -pt topic477_4_0 -u 0.0006120431891105949 > ./result_10chains/node477_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node477_5_0 -p 514 -st none -pt topic477_5_0 -u 0.000273538509326543 > ./result_10chains/node477_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node477_6_0 -p 711 -st none -pt topic477_6_0 -u 0.009444511215029289 > ./result_10chains/node477_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node477_7_0 -p 789 -st none -pt topic477_7_0 -u 0.0028929795100799682 > ./result_10chains/node477_7_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node477_8_0 -p 825 -st none -pt topic477_8_0 -u 0.006297034839012186 > ./result_10chains/node477_8_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node477_9_0 -p 834 -st none -pt topic477_9_0 -u 0.04152731541773552 > ./result_10chains/node477_9_0.txt &
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
    "./result_10chains/node477_0_0.txt 90"
    "./result_10chains/node477_0_2.txt 90"
    "./result_10chains/node477_1_0.txt 89"
    "./result_10chains/node477_1_2.txt 89"
    "./result_10chains/node477_2_0.txt 88"
    "./result_10chains/node477_2_2.txt 88"
    "./result_10chains/node477_3_0.txt 87"
    "./result_10chains/node477_3_2.txt 87"
    "./result_10chains/node477_4_0.txt 86"
    "./result_10chains/node477_4_2.txt 86"
    "./result_10chains/node477_5_0.txt 85"
    "./result_10chains/node477_5_2.txt 85"
    "./result_10chains/node477_6_0.txt 84"
    "./result_10chains/node477_6_2.txt 84"
    "./result_10chains/node477_7_0.txt 83"
    "./result_10chains/node477_7_2.txt 83"
    "./result_10chains/node477_8_0.txt 82"
    "./result_10chains/node477_8_2.txt 82"
    "./result_10chains/node477_9_0.txt 81"
    "./result_10chains/node477_9_2.txt 81"
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
