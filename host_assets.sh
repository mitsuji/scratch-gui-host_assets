#!/bin/sh

export ASSETS_PATH=/home/mitsuji/Documents/dev/scratch-gui/src/lib/libraries

cat $ASSETS_PATH/backdrops.json | jq -r 'map(.assetId + "." + .dataFormat) | reduce .[] as $item (""; . + $item + "\n")' > assets_.txt
cat $ASSETS_PATH/backdrops.json | jq -r 'map(.md5ext) | reduce .[] as $item (""; . + $item + "\n")'                      >> assets_.txt
cat $ASSETS_PATH/costumes.json  | jq -r 'map(.assetId + "." + .dataFormat) | reduce .[] as $item (""; . + $item + "\n")' >> assets_.txt
cat $ASSETS_PATH/costumes.json  | jq -r 'map(.md5ext) | reduce .[] as $item (""; . + $item + "\n")'                      >> assets_.txt
cat $ASSETS_PATH/sounds.json    | jq -r 'map(.md5ext) | reduce .[] as $item (""; . + $item + "\n")'                      >> assets_.txt

cat $ASSETS_PATH/sprites.json | jq -r 'map(.costumes + .sounds) | reduce .[] as $item ([]; . + $item) | map(.md5ext) | reduce .[] as $item (""; . + $item + "\n")'                      >> assets_.txt
cat $ASSETS_PATH/sprites.json | jq -r 'map(.costumes + .sounds) | reduce .[] as $item ([]; . + $item) | map(.assetId + "." + .dataFormat) | reduce .[] as $item (""; . + $item + "\n")' >> assets_.txt

cat assets_.txt | sort -u > assets.txt

cat assets.txt | while read line
do
curl https://assets.scratch.mit.edu/internalapi/asset/$line/get/ --output host_assets/$line
done
