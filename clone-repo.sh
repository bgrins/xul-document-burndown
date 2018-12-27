if [ ! -d "xul-analysis-mozilla-central" ]; then
  hg clone https://hg.mozilla.org/mozilla-central/ xul-analysis-mozilla-central
fi

cd xul-analysis-mozilla-central && hg revert --all && hg update tip && cd ..
