import os
import re

input_num = 10
input_dir = f"./result_{input_num}chains"
output_file = f"{input_num}chains.txt"

# 결과 저장용 리스트
results = []
diff_values = []

# 파일 번호 추출 함수
def extract_number(filename):
    match = re.search(r"set(\d+)_chain", filename)
    return int(match.group(1)) if match else None

# result_2chains 디렉토리 내 파일 리스트 확인
files = os.listdir(input_dir)

# 0~30번까지 제한
numbers = [i for i in range(0, 51)]

for num in numbers:
    chain0_path = os.path.join(input_dir, f"set{num}_chain0.txt")

    def get_diff(filepath):
        with open(filepath, 'r') as f:
            values = [float(line.split()[1]) for line in f.readlines()]
            return max(values) - min(values)

    if os.path.exists(chain0_path):
        diff0 = get_diff(chain0_path)
        results.append(f"{diff0}")
        diff_values.append(diff0)

# 평균값 계산
if diff_values:
    avg_diff = sum(diff_values) / len(diff_values)
else:
    avg_diff = 0.0

# 결과 파일로 저장
with open(output_file, 'w') as f:
    f.write("\n".join(results))

print(f"결과 파일이 생성되었습니다: {output_file}")
print(f"평균 max-min 차이: {avg_diff}")
