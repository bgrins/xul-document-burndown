# Loop through each day, updating the hg repo, and create a
# list of files matching .xul on the entire tree for that day

find ./xul-analysis-mozilla-central -type f -name '*.xul' > ./file-lists/yyyy-mm-dd.txt