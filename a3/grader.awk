BEGIN {
    FS = ","; # Set field separator
    print "Processing student grades..."
}

# calculate the average
function calc_avg(total, count) {
    return total / count
}

NR == 1 {
    next #skips the header line
}

{
    studentID = $1 
    name = $2

    total = 0
    for (i = 3; i <= NF; i++) { #NF = the grades, loops field 3 and produces the total
        total += $i
    }

    avg = calc_avg(total, NF - 2) #NF-2: number of grades
    status = (avg >= 70) ? "Pass" : "Fail" #determines pass or fail

    # Collect data
    total_scores[name] = total
    avg_scores[name] = avg
    status_map[name] = status

    # Find highest and lowest scores
    if (NR == 2 || total > max_score) {
        max_score = total
        top_student = name
    }

    if (NR == 2 || total < min_score) {
        min_score = total
        low_student = name
    }

    names[NR] = name
}

END { #The results
    print "\nStudent Report:\n"
    for (i = 2; i <= NR; i++) {
        name = names[i]
        printf "Name: %s, Total: %d, Average: %.2f, Status: %s\n", name, total_scores[name], avg_scores[name], status_map[name]
    }

    print "\nTop Scorer: " top_student " with " max_score " points"
    print "Lowest Scorer: " low_student " with " min_score " points"
}

