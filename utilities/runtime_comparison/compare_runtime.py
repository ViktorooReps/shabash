import os
import sys
import timeit

from subprocess import call

path = "/home/viktor/Documents/utilities/output_files"

runs = int(sys.argv[1])
res_file = open(os.path.join(path, "runtime_comparison_results.txt"), "w")

for file_name in sys.argv[2:]:
	total_runtime = 0
	max_runtime = -1
	min_runtime = 100000000

	for i in range(runs):
		start = timeit.default_timer()
		call(["./" + file_name])
		stop = timeit.default_timer()

		runtime = stop - start
		total_runtime += runtime
		max_runtime = max(max_runtime, runtime)
		min_runtime = min(min_runtime, runtime)

	print("average runtime for", file_name + ":", total_runtime / runs)
	res_file.write("-" * 20 + file_name + "-" * 20 + "\n"
				   + "average runtime: " + str(total_runtime / runs) + "\n"
				   + "maximum runtime: " + str(max_runtime) + "\n"
				   + "minimum runtime: " + str(min_runtime) + "\n" * 2)

res_file.close()