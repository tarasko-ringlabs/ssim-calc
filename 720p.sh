#!/bin/sh
test_image -i 0 &
test_encode -i 2688x1512 --hdr-mode 0 -V 480i --cvbs --enc-mode 4 --mixer 0 -X -f 15 --bsize 1080p --bmax 1080p -Y --bsize 352x240 -J --bsize 720p --btype enc
test_encode -i 0 -V480i --cvbs --enc-mode 4 --enc-from-mem 1 --efm-buf-num 10 --efm-size 720p
