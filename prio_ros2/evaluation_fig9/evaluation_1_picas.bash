#!/bin/bash

if [ "$#" -ne 3 ]; then
    echo "Usage: $0 <vanilla|framework> <num_nonRT_chain> <only_RT|with_nonRT>"
    exit 1
fi

type=$1
num_chain=$2
model=$3

CreateDIR=divide1_prio
if [ ! -d "$CreateDIR" ]; then
        mkdir "$CreateDIR"
fi

#Write "<node_name> <topic_name> <priority> <executable_name>"
declare -a elems=(
        "global_costmap topic_lidar 90 Global"
        "pose topic_lidar 80 Local"
        "local_costmap topic_pos 80 Local"
        "local_plan topic_local_costmap 80 Local"
#        "processing topic_camera1 70 camera1_path"
#        "detection topic_processing 70 camera1_path"
#        "tracking topic_detection 70 camera1_path"
#        "estimation topic_camera2 60 camera2_path"
#        "prediction topic_estimation 60 camera2_path"
        "joint topic_TF 50 TF_path"
        "URDF topic_joint 50 TF_path"
        "state topic_URDF 50 TF_path"
        "global_plan topic_goal 40 goal_path"
#        "lidar topic_lidar 90 Lidar"
#        "camera1 topic_camera1 70 Lidar"
#        "camera2 topic_camera2 60 Lidar"
#        "TF topic_TF 50 Lidar"
#        "goal topic_goal 40 Lidar"
)

for elem in "${elems[@]}"
do
        read -a strarr <<< "$elem"
        node="${strarr[0]}"
        topic="${strarr[1]}"
        package="${strarr[3]}"

        echo "${node}" "node start"
        file_name="${CreateDIR}/${type}_${node}.txt"

        ros2 run evaluation_1_nav2 "${package}" -r __node:="${node}" -t "${topic}" > "${file_name}" &
        sleep 15s
done
#sleep 30s

for elem in "${elems[@]}"
do
        read -a strarr <<< "$elem"
        node="${strarr[0]}"
        priority="${strarr[2]}"

        echo "${node}" "node start"
        file_name="${CreateDIR}/${type}_${node}.txt"

        if [ "${type}" == "vanilla" ]; then
            python3 pri_assign.py "${file_name}" "${priority}" 
        elif [ "${type}" == "framework" ]; then
            python3 pri_identifier.py "${file_name}" "${priority}" 
        fi
done

if [ "${model}" == "with_nonRT" ]; then
	declare -a nodes=("90" "80" "70" "60" "50" "40" "30" "20" "10" "1")
	declare -a periods=("100" "200" "300" "400" "500" "600" "700" "800" "900" "1000")
	util=0.05
	for (( i=0; i<$num_chain; i++ )); do	
		node=${nodes[$i]}
    		period=${periods[$i]}
		
		echo "NonRT sub_$node start"
        	ros2 run motivation listener -r __node:=sub_"$node" -t sub_"$node" -u "$util" -p "$period" > "$CreateDIR/sub_$node.txt" &
		sleep 10s
		if [ "${type}" == "framework" ]; then	
			python3 pri_identifier.py "$CreateDIR/sub_$node.txt" 100
		fi
	done
fi


sleep 500s

echo "End!!"
sudo pkill Lidar
sudo pkill Local
sudo pkill Global
sudo pkill TF_path
sudo pkill goal_path
sudo pkill camera1_path
sudo pkill camera2_path
sudo pkill listener

echo "remove prio"
for elem in "${elems[@]}"
do
        read -a strarr <<< "$elem"
        node="${strarr[0]}"
        priority="${strarr[2]}"

        echo "${node}" "node start"
        file_name="${CreateDIR}/${type}_${node}.txt"

        if [ "${type}" == "framework" ]; then
            python3 pri_remove.py "${file_name}" "${priority}"
        fi
done
