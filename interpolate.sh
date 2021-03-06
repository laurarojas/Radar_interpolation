#!/bin/bash

#This script makes interpolated images from iris radar hdf5 files, using optflow c++ library. Interpolation is between file1 and file2.
#Paramiters for this program are:
#filename1 = First images hdf5 file
#filename2 = last images hdf5 file
#timesteps = how many pictures will be generated, from filename1 to filename2. Start and end files are included to this.
#sweep = num of sweep or elevation angle
#var = Variable witch will be interpolated, Z2,KDP2,RHOVH2 [only these ones works, others will not convert ot grayscale and backto physical values]
#site = site name or prefix for file
###Optional agruments#######
#vector field 1 = forward vector field
#vector field 2 = backward vector field

#output
#interpolated images, in png and geotiff formats
#Motion vector fields if optional arguments are not used.
#png images of file1 and file2
echo "using config file " $1
. $1 #include variables from config file
EXPECTED_ARGS=0

#Check all arguments

if [ $# -lt $EXPECTED_ARGS ]
then
  echo "Usage: `basename $0` [config file]"
  echo "var: Z2,KDP2,RHOHV2"
  exit $E_BADARGS
fi

#check if output directories exist if not create them
if [ ! -d "$morp_output" ]; then
	echo "morph directory does not exist.."
	mkdir "$morp_output"
fi

if [ ! -d "$images" ]; then
	echo "image directory does not exist..."
	mkdir "$images"
fi

if [ ! -d "$motion" ]; then
        echo "motion directory does not exist..."
        mkdir "$motion"
fi


#extract filenames from config files
file_1=$(basename $file1)
file_2=$(basename $file2)
echo "file_2" $file_2


export IMAGE_FOLDER=$images

echo "file 1 to operate $file_1"
echo "file 2 to operate $file_2"
#timesteps=$3
#var=$5
#sweep=$4
#site=$6
#output files are name with ploted variable 16bit
#ofile1=$file_1"_"$var".tiff"
#ofile2=$file_2"_"$var".tiff"

ofile1=$file_1"_"$var".tiff"
ofile2=$file_2"_"$var".tiff"

echo "Output filenames"
echo $ofile1 "<-ofile 1"
echo $ofile2 "<- ofile 2"

#output files for 8bit data
ofile1_8bit="8bit_"$ofile1
ofile2_8bit="8bit_"$ofile2
echo $ofile1_8bit "<-ofile 8bit 1"
echo $ofile2_8bit "<- ofile 8bit 2"
#set enviromental varibale for what measurmetns are used this is used when making geotiffs from interpolated images
export MEASURMENT_VAR=$var

pref=`echo $file_1 | awk '{print substr($0,1,3)}'`
prod=`echo $file_1 | awk '{print substr($0,17,3)}'` 
echo "hdf5 to geotiff"
#Here converting hdf5 files to geotiff
#hdf5 to geotiff

#make 16bit images from hdf5 files 
python hdf52geotiff/iris_ppi2.py $file1 $sweep $var $dtime $ofile1 > /dev/null
python hdf52geotiff/iris_ppi2.py $file2 $sweep $var $dtime $ofile2 > /dev/null

#resize to next power of 2 and convert to png
#16bit images
ofile1_png=$file_1"_"$var".png"
ofile2_png=$file_2"_"$var".png"
#8bit images
ofile1_8bit_png="8bit_"$file_1"_"$var".png"
ofile2_8bit_png="8bit_"$file_2"_"$var".png"

echo "ofile1 png="$ofile1_png
echo "ofile2 png="$ofile2_png
echo "ofile1 8bit png="$ofile1_8bit_png
echo "ofile2 8bit png="$ofile2_8bit_png

echo "Convert and resize png images"

#convert 16bit images
convert_resize/convert_resize.sh $images$ofile1 $images$ofile1_png > /dev/null
convert_resize/convert_resize.sh $images$ofile2 $images$ofile2_png > /dev/null

#convert 8bit images
convert_resize/convert_resize_8bit.sh $images$ofile1_8bit $images$ofile1_8bit_png > /dev/null
convert_resize/convert_resize_8bit.sh $images$ofile2_8bit $images$ofile2_8bit_png > /dev/null

#use morph4 program to just calculate motion vectors from 8bit images if motion field need to be calculated
prefix_motion="motion_vector_"$site
echo $prefix_motion
if [ -z "$vec1"];
then
	echo "calculate motion filed"
	./optflow_8bit/build/bin/morph --image1 $images$ofile1_8bit_png --image2 $images$ofile2_8bit_png --numtimesteps $timesteps --algorithm proesmans --outprefix $prefix_motion > /dev/null
fi

echo "Using morph program"
#use optflow morph program for interpolation morph2 saves motion fields morph3 use these
prefix=$site"_"$dtime
echo $prefix
if [ -z "$vec1"];
then
#this is used when external vector field is generated from Z2 variable. This also saves motion vields
echo $images$ofile1_png
echo $images$ofile2_png
echo $prefix_motion"motion1.pdvm"
echo $prefix
	./optflow/build/bin/morph3 --image1 $images$ofile1_png --image2 $images$ofile2_png --numtimesteps $timesteps --algorithm proesmans --outprefix $prefix --vec1 $prefix_motion"-motion1.pdvm" --vec2 $prefix_motion"-motion2.pdvm" > /dev/null
fi

if [ -n "$vec1"];
then
#this use external vector field for calculating motion
	vec1=$7
	vec2=$8
	./optflow/build/bin/morph3 --image1 $images$ofile1_png --image2 $images$ofile2_png --numtimesteps $timesteps --algorithm proesmans --outprefix $prefix --vec1 $vec1 --vec2 $vec2 > /dev/null
fi

echo "Making geotiff images"
#make geotiff from interpolated images based on coordinates from hdf5 files, This script use enviromental variable for calculation
# this line: export MEASURMENT_VAR=$var
echo $prefix"-morph-*.png"
./makegeotiff/convert2geotiff.sh $prefix"-morph-*.png" $file1

echo "Cleaning"
mv *.tiff $morp_output
mv motion_vector* motion/
rm $prefix*


