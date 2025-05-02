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
ros2 run evaluation_3_randomdag uunifast_node -n node64_0_2 -p 120 -st topic64_0_1 -pt None -u 0.020938977251116986 > ./result_8chains/node64_0_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node64_1_2 -p 162 -st topic64_1_1 -pt None -u 0.00525310375630883 > ./result_8chains/node64_1_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node64_2_2 -p 175 -st topic64_2_1 -pt None -u 0.007409044894768013 > ./result_8chains/node64_2_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node64_3_2 -p 243 -st topic64_3_1 -pt None -u 0.010625500472970895 > ./result_8chains/node64_3_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node64_4_2 -p 302 -st topic64_4_1 -pt None -u 0.011023855521362147 > ./result_8chains/node64_4_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node64_5_2 -p 318 -st topic64_5_1 -pt None -u 0.009692358640605303 > ./result_8chains/node64_5_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node64_6_2 -p 487 -st topic64_6_1 -pt None -u 0.03744783317257383 > ./result_8chains/node64_6_2.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node64_7_2 -p 671 -st topic64_7_1 -pt None -u 0.0011452187268806624 > ./result_8chains/node64_7_2.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node64_0_0 -p 120 -st none -pt topic64_0_0 -u 0.056651852376983114 > ./result_8chains/node64_0_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node64_1_0 -p 162 -st none -pt topic64_1_0 -u 0.00039512781107448047 > ./result_8chains/node64_1_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node64_2_0 -p 175 -st none -pt topic64_2_0 -u 0.01613524363857749 > ./result_8chains/node64_2_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node64_3_0 -p 243 -st none -pt topic64_3_0 -u 0.03859108665393779 > ./result_8chains/node64_3_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node64_4_0 -p 302 -st none -pt topic64_4_0 -u 0.012646779196584801 > ./result_8chains/node64_4_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node64_5_0 -p 318 -st none -pt topic64_5_0 -u 0.017817435629040285 > ./result_8chains/node64_5_0.txt &
sleep 20
ros2 run evaluation_3_randomdag uunifast_node -n node64_6_0 -p 487 -st none -pt topic64_6_0 -u 0.03849426171612064 > ./result_8chains/node64_6_0.txt &
ros2 run evaluation_3_randomdag uunifast_node -n node64_7_0 -p 671 -st none -pt topic64_7_0 -u 0.05962248006748401 > ./result_8chains/node64_7_0.txt &
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
    "./result_8chains/node64_0_0.txt 90"
    "./result_8chains/node64_0_2.txt 90"
    "./result_8chains/node64_1_0.txt 89"
    "./result_8chains/node64_1_2.txt 89"
    "./result_8chains/node64_2_0.txt 88"
    "./result_8chains/node64_2_2.txt 88"
    "./result_8chains/node64_3_0.txt 87"
    "./result_8chains/node64_3_2.txt 87"
    "./result_8chains/node64_4_0.txt 86"
    "./result_8chains/node64_4_2.txt 86"
    "./result_8chains/node64_5_0.txt 85"
    "./result_8chains/node64_5_2.txt 85"
    "./result_8chains/node64_6_0.txt 84"
    "./result_8chains/node64_6_2.txt 84"
    "./result_8chains/node64_7_0.txt 83"
    "./result_8chains/node64_7_2.txt 83"
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
