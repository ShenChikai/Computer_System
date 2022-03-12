import re
import sys
import random
import numpy as np
import matplotlib.pyplot as plt
import matplotlib.ticker as mticker

target_file = sys.argv[1]
output_file = sys.argv[2]
title = sys.argv[3]

procs_raw = []
procs = []
proc_num = 0;



class Proc:
	def __init__(self, text):
		global proc_num
		self.start_tick = []
		self.duration = []
		self.priority = []
		self.name = ""
		self.color = ""

		# Get proc name from header data
		name_regex = re.compile('name\ =\ (.*),\ pid\ =\ (\d+)')
		pid = 0
		for result in re.findall('[\*]+(.*?)[\*]+', text, re.S):
			#(self.name, pid) = name_regex.findall(result)[0]
			print("")

		random.seed(proc_num)
		rand_color = random.randint(0, 16777215)
		self.color = (f'#{hex(rand_color)[2:]}')
		proc_num = proc_num + 1;

		# Get stat info
		stat_regex = re.compile('\d+')
		for line in text.split('\n')[7:]:
			stats = stat_regex.findall(line)
			if len(stats) == 3:
				self.start_tick.append(int(stats[0]))
				self.duration.append(int(stats[1]))
				################################################################################################################
				# For test3: Comment the line above and uncomment the code below for duration so that duration 0 could be seen #
				################################################################################################################
				# if (int(stats[1]) == 0) :
				# 	self.duration.append(0.2)
				# else:
				# 	self.duration.append(int(stats[1]))
				self.priority.append(int(stats[2]))
				



# Get all pstat output
with open(target_file, "r") as raw:
	for result in re.findall('PSTAT_START(.*?)PSTAT_END', raw.read(), re.S):
		procs_raw.append(result)

# Parse output into internal data structure
for proc_text in procs_raw:
	procs.append(Proc(proc_text))

# Graph
fig, ax = plt.subplots()
ax.grid(True)

for proc in procs:
	for i in range(len(proc.priority)):
		ax.broken_barh([(proc.start_tick[i], proc.duration[i])],
					   (proc.priority[i], 1),
					   facecolors=proc.color
		)


ax.set_ylim(0, 3)
# Line below only works for matplotlib=3.2.2
#ax.set_yticklabels(("Q0", "Q1", "Q2"))
ax.set_yticks(np.arange(3))
ax.invert_yaxis()
plt.title(title, x=0.9, y=0.9)
plt.savefig(output_file)
