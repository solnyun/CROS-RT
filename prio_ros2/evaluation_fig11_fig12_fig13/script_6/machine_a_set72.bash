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
ros2 run evaluation_3_randomdag uunifast_node -n node72_0_2 -p 96 -st topic72_0_1 -pt None -u 0.056961753308218954 > ./result_6chains/node72_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node72_1_2 -p 396 -st topic72_1_1 -pt None -u 0.0062620591692927885 > ./result_6chains/node72_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node72_2_2 -p 488 -st topic72_2_1 -pt None -u 0.04902427287221603 > ./result_6chains/node72_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node72_3_2 -p 632 -st topic72_3_1 -pt None -u 0.015567379393020095 > ./result_6chains/node72_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node72_4_2 -p 649 -st topic72_4_1 -pt None -u 0.02840250881725502 > ./result_6chains/node72_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node72_5_2 -p 709 -st topic72_5_1 -pt None -u 0.0024415178697479866 > ./result_6chains/node72_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node72_0_0 -p 96 -st none -pt topic72_0_0 -u 0.0038594342366061185 > ./result_6chains/node72_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node72_1_0 -p 396 -st none -pt topic72_1_0 -u 0.09352754911234296 > ./result_6chains/node72_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node72_2_0 -p 488 -st none -pt topic72_2_0 -u 0.03245102383016907 > ./result_6chains/node72_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node72_3_0 -p 632 -st none -pt topic72_3_0 -u 0.010899872402207023 > ./result_6chains/node72_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node72_4_0 -p 649 -st none -pt topic72_4_0 -u 0.011470547631355368 > ./result_6chains/node72_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node72_5_0 -p 709 -st none -pt topic72_5_0 -u 0.014596445830162876 > ./result_6chains/node72_5_0.txt &
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
    "./result_6chains/node72_0_0.txt 90"
    "./result_6chains/node72_0_2.txt 90"
    "./result_6chains/node72_1_0.txt 89"
    "./result_6chains/node72_1_2.txt 89"
    "./result_6chains/node72_2_0.txt 88"
    "./result_6chains/node72_2_2.txt 88"
    "./result_6chains/node72_3_0.txt 87"
    "./result_6chains/node72_3_2.txt 87"
    "./result_6chains/node72_4_0.txt 86"
    "./result_6chains/node72_4_2.txt 86"
    "./result_6chains/node72_5_0.txt 85"
    "./result_6chains/node72_5_2.txt 85"
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
