# useful-bash-scripts
A random collection of scripts that may come in handy

`split-csv.sh`: update the filename with the correct one, also decide on how many lines you want to split it by
e.g. if your file is 1GB and you want to split it into 10 chunks, calculate the number of lines per file you need by:

total_number_of_lines = `wc -l filname.csv`
number of lines per file = `Math.floor(total_number_of_lines/ 10)`

`minikube-vpn-tunnelling.sh`: how to let minikube have access to the vpn tunnel (e.g. if your vpn is pointing to IP a.b.c.d, use this
    so minikube can see resources on that tunneled IP)

`prepare-wind-data.js` and `wind-data-download.sh` are modifications to the data download script at https://github.com/mapbox/webgl-wind (more details
    at https://blog.mapbox.com/how-i-built-a-wind-map-with-webgl-b63022b5537f)
I wasn't able to get https://software.ecmwf.int/wiki/display/GRIB/Releases working but as this is going to be deprecated, I used https://software.ecmwf.int/wiki/display/ECC/ecCodes+Home instead for the grib files. Parameters lookup can be found at http://apps.ecmwf.int/codes/grib/param-db
