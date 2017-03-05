#!/bin/csh -f
# usual.sdf.csh from http://zinc.docking.org
# Run this script to download ZINC
# Requires curl (default) or wget, http://wget.docking.org
#
# Thus, to run this script
#         using curl, do:     csh usual.sdf.csh
#         using wget, do:     csh usual.sdf.csh wget
#
setenv base http://zinc.docking.org/db/bysubset/23
setenv fn .zinc.$$
cat <<+ > $fn
23_p0.0.sdf.gz
23_p0.1.sdf.gz
23_p0.10.sdf.gz
23_p0.11.sdf.gz
23_p0.12.sdf.gz
23_p0.13.sdf.gz
23_p0.14.sdf.gz
23_p0.15.sdf.gz
23_p0.16.sdf.gz
23_p0.17.sdf.gz
23_p0.18.sdf.gz
23_p0.19.sdf.gz
23_p0.2.sdf.gz
23_p0.20.sdf.gz
23_p0.21.sdf.gz
23_p0.22.sdf.gz
23_p0.23.sdf.gz
23_p0.24.sdf.gz
23_p0.25.sdf.gz
23_p0.26.sdf.gz
23_p0.27.sdf.gz
23_p0.28.sdf.gz
23_p0.29.sdf.gz
23_p0.3.sdf.gz
23_p0.30.sdf.gz
23_p0.31.sdf.gz
23_p0.32.sdf.gz
23_p0.33.sdf.gz
23_p0.34.sdf.gz
23_p0.35.sdf.gz
23_p0.36.sdf.gz
23_p0.37.sdf.gz
23_p0.38.sdf.gz
23_p0.39.sdf.gz
23_p0.4.sdf.gz
23_p0.40.sdf.gz
23_p0.41.sdf.gz
23_p0.42.sdf.gz
23_p0.43.sdf.gz
23_p0.44.sdf.gz
23_p0.45.sdf.gz
23_p0.46.sdf.gz
23_p0.47.sdf.gz
23_p0.48.sdf.gz
23_p0.49.sdf.gz
23_p0.5.sdf.gz
23_p0.50.sdf.gz
23_p0.51.sdf.gz
23_p0.52.sdf.gz
23_p0.53.sdf.gz
23_p0.54.sdf.gz
23_p0.55.sdf.gz
23_p0.56.sdf.gz
23_p0.57.sdf.gz
23_p0.58.sdf.gz
23_p0.59.sdf.gz
23_p0.6.sdf.gz
23_p0.60.sdf.gz
23_p0.61.sdf.gz
23_p0.62.sdf.gz
23_p0.63.sdf.gz
23_p0.64.sdf.gz
23_p0.65.sdf.gz
23_p0.66.sdf.gz
23_p0.67.sdf.gz
23_p0.68.sdf.gz
23_p0.69.sdf.gz
23_p0.7.sdf.gz
23_p0.70.sdf.gz
23_p0.71.sdf.gz
23_p0.72.sdf.gz
23_p0.73.sdf.gz
23_p0.74.sdf.gz
23_p0.75.sdf.gz
23_p0.8.sdf.gz
23_p0.9.sdf.gz
23_p1.0.sdf.gz
23_p1.1.sdf.gz
23_p1.10.sdf.gz
23_p1.11.sdf.gz
23_p1.2.sdf.gz
23_p1.3.sdf.gz
23_p1.4.sdf.gz
23_p1.5.sdf.gz
23_p1.6.sdf.gz
23_p1.7.sdf.gz
23_p1.8.sdf.gz
23_p1.9.sdf.gz
+
if ($#argv>0) then
     wget --base=$base -i < $fn
else
     foreach i (`cat $fn`)
          curl --url $base/$i -o $i
     end
endif
rm -f $fn
# File created on  Mon Nov 24 15:47:41 PST 2014
# This is the end of the csh script.
