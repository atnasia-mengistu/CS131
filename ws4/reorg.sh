#!/bin/bash

# Get timestamp for file naming
timestamp=$(date "+%F-%T")

# Input dataset
input_file="2019-01-h1.csv"

# Vendor IDs to filter
vendor_ids=("1.0" "2.0" "4.0")

# Loop through vendor IDs and create separate files
for vid in "${vendor_ids[@]}"; do
    output_file="${timestamp}-${vid}.csv"
    awk -F',' -v vid="$vid" '$1 == vid {print}' "$input_file" > "$output_file"
done

# Add generated files to .gitignore
for vid in "${vendor_ids[@]}"; do
    echo "${timestamp}-${vid}.csv" >> .gitignore
done

# Create ws4.txt with wc command results
wc -l ${timestamp}-*.csv > ws4.txt
echo -e "\nContents of .gitignore:" >> ws4.txt
cat .gitignore >> ws4.txt

# Ensure script has execute permissions
chmod +x reorg.sh

echo "Processing complete. Check ws4.txt for details."
