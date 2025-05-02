import os

# 0부터 30까지의 파일 이름에 대해 반복
for i in range(0, 51):
    filename = f"script_10/machine_a_set{i}.bash"

    # 파일이 존재하는지 확인
    if os.path.exists(filename):
        with open(filename, "r") as file:
            content = file.read()

        # sleep 20을 sleep 10으로 치환
        new_content = content.replace("sleep 100s", "sleep 80s")
        #new_content = content.replace("sleep 350", "sleep 200")

        # 변경된 내용을 파일에 다시 쓰기
        with open(filename, "w") as file:
            file.write(new_content)

        print(f"{filename} 파일이 업데이트되었습니다.")
    else:
        print(f"{filename} 파일이 존재하지 않습니다.")
