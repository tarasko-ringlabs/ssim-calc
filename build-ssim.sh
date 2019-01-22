#!/bin/bash -x
reference_yuv=`readlink -f $1`
res_name=$2
outdir=h264/$res_name/`basename $reference_yuv .yuv`

if [[ $res_name == "720p" ]]; then
    resolution=1280x720
elif [[ $res_name == "1080p" ]]; then
    resolution=1920x1080
else
    echo wrong res_name $res_name
    exit 1
fi

basedir=$PWD
pushd $outdir
touch ssim_list
for h264_file in *.h264
do
    encoded_h264=$h264_file
    ssim_file=${encoded_h264}_ssim
    bitrate_file=${encoded_h264}_bitrate
    ffmpeg -f rawvideo -pix_fmt nv12 -s:v $resolution -i $reference_yuv -i $encoded_h264 -lavfi ssim="stats_file=$ssim_file" -f null -
    ffprobe -show_frames $encoded_h264 >$bitrate_file
    echo `readlink -f $ssim_file` >>ssim_list
    echo `readlink -f $bitrate_file` >>bitrate_list
done
#python $basedir/plot-ssim.py ssim_list
python $basedir/plot-bitrate.py bitrate_list
rm ssim_list bitrate_list
popd
