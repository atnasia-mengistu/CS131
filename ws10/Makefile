.PHONY: all clean

all: clean.csv

# Trim columns to id, age, score
trimmed.csv: raw.csv
	cut -d',' -f1,3,5 raw.csv > trimmed.csv

# Remove rows with missing age or score
clean.csv: trimmed.csv
	awk -F',' 'NR==1 || ($$2 != "" && $$3 != "")' trimmed.csv > clean.csv

# Clean intermediate files
clean:
	rm -f trimmed.csv clean.csv

