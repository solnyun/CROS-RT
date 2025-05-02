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
ros2 run evaluation_3_randomdag uunifast_node -n node381_0_2 -p 67 -st topic381_0_1 -pt None -u 0.06401773157686208 > ./result_4chains/node381_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node381_1_2 -p 380 -st topic381_1_1 -pt None -u 0.018781115769291146 > ./result_4chains/node381_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node381_2_2 -p 866 -st topic381_2_1 -pt None -u 0.05841521644602771 > ./result_4chains/node381_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node381_3_2 -p 875 -st topic381_3_1 -pt None -u 0.08399165913763793 > ./result_4chains/node381_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node381_0_0 -p 67 -st none -pt topic381_0_0 -u 0.035340319483945004 > ./result_4chains/node381_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node381_1_0 -p 380 -st none -pt topic381_1_0 -u 0.0046714998729729396 > ./result_4chains/node381_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node381_2_0 -p 866 -st none -pt topic381_2_0 -u 0.0060399062181579755 > ./result_4chains/node381_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node381_3_0 -p 875 -st none -pt topic381_3_0 -u 0.10334023612108348 > ./result_4chains/node381_3_0.txt &
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
    "./result_4chains/node381_0_0.txt 90"
    "./result_4chains/node381_0_2.txt 90"
    "./result_4chains/node381_1_0.txt 89"
    "./result_4chains/node381_1_2.txt 89"
    "./result_4chains/node381_2_0.txt 88"
    "./result_4chains/node381_2_2.txt 88"
    "./result_4chains/node381_3_0.txt 87"
    "./result_4chains/node381_3_2.txt 87"
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
sleep 60s
sudo pkill -USR1 uunifast_node
echo "Set timer signal!"
sleep 200s
echo "End Running"
sudo pkill uunifast_node
finalize_framework
/home/orin5/prio_ros2/evaluation_2_fig10/send_signal 127.0.0.1 9999
