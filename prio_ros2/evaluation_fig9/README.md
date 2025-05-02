## Callback Execution Time Profiling Code
```bash
# Compilation
g++ -o benchmark_test benchmark_test.cpp

# Returns the load corresponding to each callback's execution time.
./benchmark <execution_time>

# Returns the load of all callbacks at once.
bash benchmark_all.bash
```

## Experiment Execution Code
```bash
#type - vanilla or framework
bash evaluation_1_picas.bash <type>
```

## Experiment Results Analysis Code
```bash
# type - vanilla or framework
# Calculates the end-to-end latency of each chain.
bash analysis_e2e.bash <type>

# Compiles all chains' end-to-end latency into a single excel file.
python3 make_excel.py

# Generates CDF and box graphs.
python3 analysis_graph_cdf.py
python3 analysis_graph_box.py
```

