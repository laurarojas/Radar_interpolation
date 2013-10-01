#!/bin/bash
#This script 
EXPECTED_ARGS=2
E_BADARGS=65

if [ $# -ne $EXPECTED_ARGS ]
then
  echo "Usage: `basename $0` [file prefix] [original hdf5 file]"
  exit $E_BADARGS
fi
#For loopu goes throuw prefix files
for i in $1
do
	fname="${i%.*}"
	#echo $i
	echo "Converting..." $fname
	python makegeotiff/make_geotiff.py $i $2 $fname".tiff"
done
