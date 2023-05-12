#!/bin/bash

# File Name: Project Backup.sh
# Describe: This script is used to perform automatic backups of a project folder on an hourly basis.
#           It accepts two command-line arguments: the path of the project folder to be backed up and the backup storage path.
#           The script creates a compressed tar file of the project folder and stores it in the specified backup path.
#           It keeps the latest 24 backup files and removes older backups.
#           Additionally, the script sets up a cron schedule to execute the backup process every hour.


echo "[Set the path of the project folder to be backed up. & Set the path for storing the backups.]"
if [ "$#" -ne 2 ]; then
  echo "Usage: ./Project_Backup.sh <project_folder_path> <backup_folder_path>"
  exit 1
fi

project_dir="$1"
backup_dir="$2"

backup_file="$backup_dir/project_$(date +%Y%m%d%H%M%S).tar.gz"
tar -czf "$backup_file" "$project_dir"

echo "[Keep the latest 24 backup files.]"
ls -t "$backup_dir"/project_*.tar.gz | tail -n +25 | xargs rm --

echo "[Set up a cron schedule to backup the project every hour.]"
(crontab -l 2>/dev/null; echo "0 * * * * /bin/bash /path/to/backup.sh") | crontab -