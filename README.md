# Flash Image Editor

## Project Description

This bash script takes in a flash image in the .ihex format and alters appropriate bytes.

Its main purpose is to edit large flash image files to make the metric gathering process easier.

It alters the fifth byte and the last byte of every record block excpet for the very last record block in which case it only changes the fifth byte.

This project was created during my Summer 2024 Co-op at Medtronic.

## How To Use

1. Run ./edit_flash_image.sh *your flash input file*
2. Open the file named "modified_*your flash input file*"
