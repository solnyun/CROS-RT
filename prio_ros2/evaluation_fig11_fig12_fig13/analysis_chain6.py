import os

input_num = 6
input_dir = f"./result_{input_num}chains"
output_file = f"{input_num}chains.txt"

# 각 체인별 누적합과 카운트를 저장할 딕셔너리
chain_sum = {i: 0.0 for i in range(6)}
chain_count = {i: 0 for i in range(6)}

# 결과를 행 단위로 저장할 리스트 (각 행은 한 set에 해당)
rows = []

def get_diff(filepath):
    with open(filepath, 'r') as f:
        values = [float(line.split()[1]) for line in f.readlines()]
        return max(values) - min(values)

# 0 ~ 30번 set 파일에 대해 각 chain(0~5)의 diff값 구하기
for num in range(0, 51):
    row = []  # 해당 set의 chain 결과를 저장할 리스트
    for chain_idx in range(6):
        filepath = os.path.join(input_dir, f"set{num}_chain{chain_idx}.txt")
        if os.path.exists(filepath):
            diff_val = get_diff(filepath)
            row.append(str(diff_val))
            chain_sum[chain_idx] += diff_val
            chain_count[chain_idx] += 1
        else:
            row.append("")  # 파일이 없으면 빈 문자열로 남김
    rows.append(row)

# 결과 파일에 각 set별 chain 결과를 컬럼 단위로 기록 (탭으로 구분)
with open(output_file, 'w') as f:
    for row in rows:
        f.write("\t".join(row) + "\n")

# 각 chain별 평균 diff 값 계산 후 출력
for chain_idx in range(6):
    avg = chain_sum[chain_idx] / chain_count[chain_idx] if chain_count[chain_idx] > 0 else 0.0
    print(f"Chain {chain_idx} average max-min diff: {avg}")

print(f"결과 파일이 생성되었습니다: {output_file}")
