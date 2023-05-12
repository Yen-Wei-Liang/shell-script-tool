# Shell Script Tool Table of contents

* [1. Install ROS Noetic on Raspberry pi4B (3B+)](#1-ROSNoetic)   
* [2. Project Backup](#2-ProjectBackup)   


### File Name : Raspberry_ROS_Noetic_Install_.sh <a name="1-ROSNoetic"></a>
### Describe  : 
This script is used to install an embedded real-time operating system with ROS (Robot Operating System).
It supports Ubuntu 20.04.x (Focal Fossa), Linux Mint 21.x, and Raspbian Buster.
The script installs ROS Noetic Ninjemys and sets up the catkin workspace.
It also configures the environment variables and installs necessary dependencies.

### Usage example:
#### 1. Open a terminal and navigate to the directory containing the script.
#### 2. Make the script executable: chmod +x script_name.sh
```bash=
chmod +x Raspberry_ROS_Noetic_Install_.sh
```
#### 3. Run the script: ./script_name.sh
```bash=
sudo bash Raspberry_ROS_Noetic_Install_.sh
```
#### 4. Follow the instructions displayed in the terminal to proceed with the installation.
#### 5. Once the installation is complete, the script will exit.



### File Name: Project Backup.sh <a name="2-ProjectBackup"></a>
### Describe: 
This script is used to perform automatic backups of a project folder on an hourly basis.
It accepts two command-line arguments: the path of the project folder to be backed up and the backup storage path.
The script creates a compressed tar file of the project folder and stores it in the specified backup path.
It keeps the latest 24 backup files and removes older backups.
Additionally, the script sets up a cron schedule to execute the backup process every hour.

### Usage example:
```bash=
sudo bash Project_Backup.sh <project_folder_path> <backup_folder_path>
```
