# remindme - Terminal Reminder

## What this command does
`remindme` is a simple shell script that allows users to schedule reminders directly from the terminal. It supports scheduling reminders based on:
- A delay (e.g., "in 30m")
- A specific time (e.g., "at 15:30")
- Interactive mode if no arguments are provided

Once the time arrives, a notification appears on the system

---

## Why/When this command is useful
This command is useful when you:
- Need a quick reminder without setting up calendar events.
- Want to be notified while working in the terminal.
- Prefer lightweight reminders without running an app.

---

## How you can use this command

### **Installation**
1. Make the script executable:
   ```bash
   chmod 755 remindme 

### **Usage**
#### **Command-line input**
- Schedule a reminder after a delay:
  ```bash
  remindme "Stretch your legs" in 30m
  ```
- Schedule a reminder at a specific time:
  ```bash
  remindme "Join meeting" at 15:30
  ```

#### **Interactive mode**
If no arguments are provided, the script will ask for input:
```bash
$ remindme
Enter reminder message: Submit CS131 assignment
Enter time (e.g., 'in 10m' or 'at 14:30'): in 5m
Reminder set: "Submit CS131 assignment" in 300 seconds...
```

---

## Examples
```bash
$ remindme "Take a break" in 10m
Reminder set: "Take a break" in 600 seconds...

# After 10 minutes, a notification appears:
# "Reminder: Take a break"

$ remindme "Work call" at 14:00
Reminder set: "Work call" at 14:00...
```
