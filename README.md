# useful-bash-scripts
A random collection of scripts that may come in handy

`split-csv.sh`: update the filename with the correct one, also decide on how many lines you want to split it by
e.g. if your file is 1GB and you want to split it into 10 chunks, calculate the number of lines per file you need by:

total_number_of_lines = `wc -l filname.csv`
number of lines per file = `Math.floor(total_number_of_lines/ 10)`
