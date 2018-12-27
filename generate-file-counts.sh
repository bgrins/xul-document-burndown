# Loop through the files saved in the generate-file-lists and
# filter them for test and non-test files so they can be easily
# read for graphing

[ -e ./file-counts.json ] && rm file-counts.json

# XXX: to figure out which rev to update to, see if we can get this info locally:
# https://hg.mozilla.org/mozilla-central/pushloghtml?startdate=2018-12-25&enddate=2018-12-26


echo "{" > file-counts.json

notest=$(grep -c -v "test[s]\?" ./file-lists/yyyy-mm-dd.txt)
test=$(grep -c "test[s]\?" ./file-lists/yyyy-mm-dd.txt)

echo "\"yyyy-mm-dd\": [${notest}, ${test}]" >> file-counts.json

echo "}" >> file-counts.json
