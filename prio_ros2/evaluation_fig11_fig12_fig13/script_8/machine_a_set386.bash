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
ros2 run evaluation_3_randomdag uunifast_node -n node386_0_2 -p 32 -st topic386_0_1 -pt None -u 0.03408110649078322 > ./result_8chains/node386_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node386_1_2 -p 115 -st topic386_1_1 -pt None -u 0.0032433521061155934 > ./result_8chains/node386_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node386_2_2 -p 213 -st topic386_2_1 -pt None -u 0.027113908624262717 > ./result_8chains/node386_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node386_3_2 -p 235 -st topic386_3_1 -pt None -u 0.027699681404659227 > ./result_8chains/node386_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node386_4_2 -p 626 -st topic386_4_1 -pt None -u 0.023063675494643388 > ./result_8chains/node386_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node386_5_2 -p 699 -st topic386_5_1 -pt None -u 0.011250522679649516 > ./result_8chains/node386_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node386_6_2 -p 806 -st topic386_6_1 -pt None -u 0.10733393656446755 > ./result_8chains/node386_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node386_7_2 -p 933 -st topic386_7_1 -pt None -u 0.022932903619094662 > ./result_8chains/node386_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node386_0_0 -p 32 -st none -pt topic386_0_0 -u 0.007035705132415193 > ./result_8chains/node386_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node386_1_0 -p 115 -st none -pt topic386_1_0 -u 0.005826546887175321 > ./result_8chains/node386_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node386_2_0 -p 213 -st none -pt topic386_2_0 -u 0.0003562209557915752 > ./result_8chains/node386_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node386_3_0 -p 235 -st none -pt topic386_3_0 -u 0.010182361221557412 > ./result_8chains/node386_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node386_4_0 -p 626 -st none -pt topic386_4_0 -u 0.006793057479190734 > ./result_8chains/node386_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node386_5_0 -p 699 -st none -pt topic386_5_0 -u 0.02399620083929599 > ./result_8chains/node386_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node386_6_0 -p 806 -st none -pt topic386_6_0 -u 0.0038244127159425267 > ./result_8chains/node386_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node386_7_0 -p 933 -st none -pt topic386_7_0 -u 0.04196091805602989 > ./result_8chains/node386_7_0.txt &
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
    "./result_8chains/node386_0_0.txt 90"
    "./result_8chains/node386_0_2.txt 90"
    "./result_8chains/node386_1_0.txt 89"
    "./result_8chains/node386_1_2.txt 89"
    "./result_8chains/node386_2_0.txt 88"
    "./result_8chains/node386_2_2.txt 88"
    "./result_8chains/node386_3_0.txt 87"
    "./result_8chains/node386_3_2.txt 87"
    "./result_8chains/node386_4_0.txt 86"
    "./result_8chains/node386_4_2.txt 86"
    "./result_8chains/node386_5_0.txt 85"
    "./result_8chains/node386_5_2.txt 85"
    "./result_8chains/node386_6_0.txt 84"
    "./result_8chains/node386_6_2.txt 84"
    "./result_8chains/node386_7_0.txt 83"
    "./result_8chains/node386_7_2.txt 83"
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
sleep 180s
sudo pkill -USR1 uunifast_node
echo "Set timer signal!"
sleep 200s
echo "End Running"
sudo pkill uunifast_node
finalize_framework
/home/orin5/prio_ros2/evaluation_2_fig10/send_signal 127.0.0.1 9999
