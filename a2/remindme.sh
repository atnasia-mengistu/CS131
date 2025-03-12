#!/bin/bash

usage() {
    echo "Usage: remindme \"message\" in <time> OR remindme \"message\" at <HH:MM>"
    echo "Examples:"
    echo "  remindme \"Drink water\" in 30m"
    echo "  remindme \"Meeting with team\" at 15:30"
    exit 1
}

send_notification() {
    local message="$1"
    if command -v notify-send &> /dev/null; then
        notify-send "Reminder" "$message"
    elif command -v osascript &> /dev/null; then
        osascript -e "display notification \"$message\" with title \"Reminder\""
    else
        echo "Reminder: $message"
    fi
}

calculate_delay() {
    local input_time="$1"
    if [[ "$input_time" =~ ^[0-9]+[smh]$ ]]; then
        case ${input_time: -1} in
            s) echo "${input_time%?}" ;;
            m) echo "$(( ${input_time%?} * 60 ))" ;;
            h) echo "$(( ${input_time%?} * 3600 ))" ;;
        esac
    elif [[ "$input_time" =~ ^[0-9]{2}:[0-9]{2}$ ]]; then
        target_time=$(date -d "$input_time" +%s 2>/dev/null || date -j -f "%H:%M" "$input_time" +%s)
        current_time=$(date +%s)
        echo "$(( target_time - current_time ))"
    else
        usage
    fi
}

# Check if input is a file
if [[ -f "$1" ]]; then
    while IFS= read -r line; do
        eval "\"$(realpath "$0")\" $line &"
    done < "$1"
    exit 0
fi


if [ "$#" -eq 0 ]; then
    read -p "Enter reminder message: " message
    read -p "Enter time (e.g., 'in 10m' or 'at 14:30'): " time_input
    set -- "$message" $time_input
fi

if [ "$#" -lt 3 ] || [ "$2" != "in" ] && [ "$2" != "at" ]; then
    usage
fi

message="$1"
time_type="$2"
time_value="$3"

delay=$(calculate_delay "$time_value")

if [[ "$delay" -le 0 ]]; then
    echo "Invalid or past time entered."
    exit 1
fi

echo "Reminder set: \"$message\" in $delay seconds..."
sleep "$delay"
send_notification "$message"
