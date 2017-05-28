#!/usr/bin/env python3
# A python script to grab approximately all the titles from the McAfee virus database

import urllib

start_id = 313

# change me to where you want it to stop
end_id = 3676398

full_url = "http://www.mcafee.com/threat-intelligence/malware/default.aspx?id="

for s in range(start_id, end_id + 1):
	current_address = full_url + str(s)
	f = urllib.urlopen(current_address)
	p = f.read()
	i = p.find("<title>")
	j = p.find(" - ")
	title = p[i+7:j].strip()
	virus_entry = title + " : " + current_address
	
	# uncomment this line to make sure it is working
	# print virus_entry
	with open("virus_list.txt", "a") as myfile:
		myfile.write(virus_entry + "\n")

