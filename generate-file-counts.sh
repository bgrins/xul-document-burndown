# Loop through the files saved in the generate-file-lists and
# filter them for test and non-test files so they can be easily
# read for graphing

[ -e ./file-counts.json ] && rm file-counts.json

echo "{" > file-counts.json

for filename in ./file-lists/*.txt; do
  notest=$(grep -c -v "test[s]\?" $filename)
  test=$(grep -c "test[s]\?" $filename)
  echo "\"$filename\": [${notest}, ${test}]," >> file-counts.json
done

# remove the last comma:
sed -i '' '$ s/.$//' file-counts.json

echo "}" >> file-counts.json
