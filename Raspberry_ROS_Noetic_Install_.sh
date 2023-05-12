#!/bin/bash

echo "   __  ___  _______   _______   ______   ___    _ _" 
echo " |  |/  / |       \ |       \ |____  | |__ \  /_ | "
echo " |  '  /  |  .--.  ||  .--.  |    / /     ) |  | | "
echo " |    <   |  |  |  ||  |  |  |   / /     / /   | | "
echo " |  .  \  |  '--'  ||  '--'  |  / /     / /_   | | "
echo " |__|\__\ |_______/ |_______/  /_/     |____|  |_| "
                                                  
echo ""
echo "　　　　 ∧＿∧ 　　　　　　　系統晶片之嵌入式即時作業系統 "
echo "　　 　(　･∀ ･)　　　　 　　授課教師：蔡曉萍教授"
echo "　　 　(　つ┳⊃ 　　　　 　　適用版本：樹莓派3B+,樹莓派4B"
echo "　　 　ε(_)へ⌒ヽﾌ　　　 　　安裝版本：ROS Noetic"
echo "　　 (　　(　･ω･)　　　 　　課程助教：顏瑋良製作"
echo "  ≡≡≡　◎　―◎ 　⊃ 　⊃　　　　  2023  　祝大家安裝順利成功"

echo ""
echo "[Note] Target OS version  >>> Ubuntu 20.04.x (Focal Fossa) or Linux Mint 21.x or Raspbian_buster"
echo "[Note] Target ROS version >>> ROS Noetic Ninjemys"
echo "[Note] Catkin workspace   >>> $HOME/catkin_ws"
echo ""
echo "PRESS [ENTER] TO CONTINUE THE INSTALLATION"
echo "IF YOU WANT TO CANCEL, PRESS [CTRL] + [C]"
read
 
echo "[Set the target OS, ROS version and name of catkin workspace]"
name_os_version=${name_os_version:="focal"}
name_ros_version=${name_ros_version:="noetic"}
name_catkin_workspace=${name_catkin_workspace:="embedded_catkin_ws"}


echo "[Set Swqp]"

cd /var
sudo swapoff /var/swap
sudo dd if=/dev/zero of=swap bs=1M count=2048
sudo mkswap /var/swap
sudo swapon /var/swap

echo "[Add the ROS repository]"
sudo sh -c 'echo "deb http://packages.ros.org/ros/ubuntu buster main" > /etc/apt/sources.list.d/ros-noetic.list'

echo "[Download the ROS keys]"
sudo apt-key adv --keyserver 'hkp://keyserver.ubuntu.com:80' --recv-key C1CF6E31E6BADE8868B172B4F42ED6FBAB17C654


echo "[Update the package lists]"
sudo apt update -y
sudo apt upgrade -y


echo "[Install ros-desktop-full version of Noetic"
sudo apt install -y ros-$name_ros_version-desktop-full

echo "[Environment setup and getting rosinstall]"
source /opt/ros/$name_ros_version/setup.sh
sudo apt-get install -y python-rosdep python-rosinstall-generator python-wstool python-rosinstall build-essential cmake


echo "[Initialize rosdep and Update]"
sudo sh -c "rosdep init"
rosdep update

echo "[Make the catkin workspace and test the catkin_make]"
mkdir -p $HOME/$name_catkin_workspace/src
cd $HOME/$name_catkin_workspace/src
catkin_init_workspace
cd $HOME/$name_catkin_workspace
catkin_make


echo "[Install rosdep and Update]"
wstool init src noetic-ros_comm-wet.rosinstall
rosdep install -y --from-paths src --ignore-src --rosdistro noetic -r --os=debian:buster


echo "[Set the ROS evironment]"

sudo src/catkin/bin/catkin_make_isolated --install -DCMAKE_BUILD_TYPE=Release --install-space /opt/ros/noetic -j1 -DPYTHON_EXECUTABLE=/usr/bin/python3


source /opt/ros/noetic/setup.bash

echo "[Complete!!!]"
exit 0
~







#金鑰設定

sudo sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'

sudo apt-key adv --keyserver 'hkp://keyserver.ubuntu.com:80' --recv-key C1CF6E31E6BADE8868B172B4F42ED6FBAB17C654

#Linux更新
sudo apt-get update
sudo apt-get upgrade


#安裝相依包
sudo apt install -y python-rosdep python-rosinstall-generator python-wstool python-rosinstall build-essential cmake


#初始ros

sudo rosdep init
rosdep update


#創建資料夾
mkdir -p /home/pi/ros_catkin_ws
cd /home/pi/ros_catkin_ws


#下載桌面版本

rosinstall_generator desktop --rosdistro melodic --deps --wet-only --tar > melodic-desktop-wet.rosinstall

wstool init src melodic-desktop-wet.rosinstall





#下載套件至src
rosinstall_generator robot --rosdistro melodic --deps --wet-only --tar > melodic-robot-wet.rosinstall

wstool init src melodic-robot-wet.rosinstall




#wstool更新
wstool update -j4 -t src



#解決依賴性問題
cd /home/pi/ros_catkin_ws
rosdep install -y --from-paths src --ignore-src --rosdistro melodic -r --os=debian:buster




#建立catkin
sudo ./src/catkin/bin/catkin_make_isolated --install -DCMAKE_BUILD_TYPE=Release --install-space /opt/ros/melodic -j2


source /opt/ros/melodic/setup.bash
