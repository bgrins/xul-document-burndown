# Loop through each day, updating the hg repo, and create a
# list of files matching .xul on the entire tree for that day


d=2019-10-01
end=$(date +"%Y-%m-%d")

echo "Loading data from from $d until $end"

cd xul-analysis-mozilla-central && hg revert --all && hg update tip

# XXX: Does checking for merge (-m) commits with a specific date (-d) get us
# the correct data, similar to:
# https://hg.mozilla.org/mozilla-central/pushloghtml?startdate=2018-12-25&enddate=2018-12-26
# Normal commit dates can be wrong, but the hope is that merge commits are actually
# authored on the same date as the push, so it'd be a simpler way than querying the pushlog.
while : ; do

  current=$d
  d=$(date -j -f %Y-%m-%d -v+1d $current +%Y-%m-%d)
  rev=$(hg log -l 1 -m -d $current --template "{node}")

  if [ -e ../file-lists/$current.txt ]
  then
    echo "Already have data for $current"
    if [ "$current" == "$end" ]; then
        break
    fi
    continue
  fi

  if [ -z "$rev" ]
  then
    echo "No rev for $current"
  else
    echo "Got rev for $current: $rev"
    hg update -r $rev
    find . -type f -name '*.xul' > ../file-lists/$current.txt
  fi

  if [ "$current" == "$end" ]; then
      break
  fi

done

hg update tip
cd ..


