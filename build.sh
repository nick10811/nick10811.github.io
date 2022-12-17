#!/bin/bash

# clean
echo "Clean _site/"
rm -rf _site/

# build
echo ""
echo "Build"
jekyll build
echo ""
echo "Regenerate tags/"
rm -rf tags/
cp -R _site/tags .

echo ""
echo "Complete"

