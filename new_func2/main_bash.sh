#!/bin/bash

file1="poly2equilibration0.in"
file2="efield0.txt"
num_duplicates=40
num_duplicates1=51
output_file="inputfiles1.txt"
output_file1="inputfiles2.txt"
count=0

for ((i=1; i<=num_duplicates; i++)); do
    rand_num=$(shuf -i 100000-999999 -n 1) 
    rand_num2=$(shuf -i 10000-99999 -n 1)
    replaced_value=$((i))
    equilibration_value=$((i))
    
    new_file_func="poly2equilibration_$((i)).in"
    sed -e "s/923456/${rand_num}/g" -e "s/76858/${rand_num2}/g" -e "s/logeq.1/logeq.${replaced_value}/g" -e "s/equilibrate_1/equilibrate_${equilibration_value}/g" -e "s/data2eq.func_1/data2eq.func_${replaced_value}/g" -e "s/restart2eq.func_1/restart2eq.func_${replaced_value}/g" "$file1" > "$new_file_func"
    echo "$new_file_func"
    echo '"'$new_file_func'"' >> "$output_file"
    
    for ((j=1; j<=num_duplicates1; j++)); do
        count=$((count+1))
        new_file_efield="efield_$((count)).txt"
        sed -e "s/read_1_1/read_${i}_${j}/g" -e "s/923456/${rand_num}/g;s/923456/${rand_num}/g" -e "s/76858/${rand_num2}/g;s/76858/${rand_num2}/g" -e "s/log.1/log.${count}/g" -e "s/eq_1/eq_${count}/g" -e "s/elfield_1/elfield_${count}/g" "$file2" > "$new_file_efield"
        echo "$new_file_efield"
        echo '"'$new_file_efield'"' >> "$output_file1"
    done
done


## Generate 40 different equilibration files and 2000 different efield files 
