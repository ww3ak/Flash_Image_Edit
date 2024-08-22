#!/bin/bash

input_file=$1

#sed 's/CC/BB/' <$input_file >modified_$input_file

#16 lines in a block (256)
#have to change the first byte of the record to magicNumber (CC)
#and the last byte of the last record to magicNumber (AB)
#considered  "corrupt" if either the first magic number of eor is not set


input_file=$1

# Define the magicNumber
magicNumber="CC"

#define the end of record (eor)
eor="AB"

# Read the input file into an array 
mapfile -t lines < $input_file

# Get the total number of lines
total_lines=${#lines[@]}

# Calculate the number of blocks (each block is 16 lines)
total_records=$((total_lines / 16))

# Loop through each block (skipping the first and last lines)
for ((i=0; i<total_records; i++))
do
  # line index of each block
  second_line_index=$((i * 16 + 1))

  # line index of the end of each block 
  end_of_record_index=$((i * 16 + 16))

  # Change the fifth byte of the records first line to magicNumber (CC)
  lines[second_line_index]="${lines[second_line_index]:0:9}${magicNumber}${lines[second_line_index]:11}"

  # Change the 20th byte of each block's last line to magicNumber (AB)
  if [ $i -ne $((total_records-1)) ]; then
    lines[end_of_record_index]="${lines[end_of_record_index]:0:39}${eor}${lines[end_of_record_index]:41}"
  fi
done

# Write the modified lines to a new file
printf "%s\n" "${lines[@]}" > modified_$input_file

# Print a message indicating the file has been modified and saved
echo "File modified and saved as modified_$input_file"