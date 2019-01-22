#!/bin/sh -x


yuv_reference=$1
fps=15
res_name=$2

if [[ $res_name == "1080p" ]]; then
	res_info="1920x1080"
elif [[ $res_name == "720p" ]]; then
	res_info="1280x720"
else
	echo wrong resolution name: $res_name
	exit 1
fi

outdir=h264/$res_name

mkdir -p $outdir

echo Resolution: $res_name, $res_info
qp_ranges="1~1 1~51 24~51 1~38 14~51 51~51"
bitrate=1400000

for qp_range in $qp_ranges
do
	h264_file=$outdir/$(echo qp-$qp_range | tr '~' '-')
	test_encode -A -h $res_name -f $fps -b 5 --idr 1 --profile 2 --bc cbr --bitrate $bitrate --qp-limit-i $qp_range --qp-limit-p $qp_range -e
	test_stream -A -f $h264_file &
	pid=$!
	test_efm -t 0 -y $yuv_reference -s $res_info -r $fps
	kill -9 $pid
done

