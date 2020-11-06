#! /bin/bash
clear
read -p '欢迎使用玩客云armbian 甜糖CDN自动部署程序
本程序全自动判断系统版本，不管是N1还是玩客云都可以一键部署！                                

==============================================
    填写邀请码：428050  免费获取15张加成卡！
==============================================

请输入邀请码 428050 开始自动部署：' number
 
if [ $number = 428050 ];then
	echo "输入正确，开始部署！"         
	cp -pdr /etc/rc.local /etc/rc.local.default
	cp -pdr /etc/crontab /etc/crontab.default
	
	rm -rf /mnts
	mkdir /mnts
	fdisk -l
	read -p "请复制粘贴要挂载的分区，例如/dev/sda1:" fenqu
	mount $fenqu /mnts/

	rm -rf /usr/node
	mkdir /usr/node
	cd /usr/node/
	if [ $(getconf WORD_BIT) = '32' ];then
		echo "32位系统，3秒后即将开始部署32位甜糖程序!"
		sleep 3s
		wget https://raw.githubusercontent.com/ohhhyy/myhosts/master/ttnode32 -O ttnode
	else
		echo "64位系统，3秒后即将开始部署64位甜糖程序!"
		sleep 3s
		wget https://raw.githubusercontent.com/ohhhyy/myhosts/master/ttnode64 -O ttnode
	fi
		wget https://raw.githubusercontent.com/ohhhyy/myhosts/master/crash_monitor.sh
		wget https://raw.githubusercontent.com/ohhhyy/myhosts/master/log.log
	chmod -R 777 *
	
	#cd /etc
	#rm -rf rc.local
	#wget http://94.191.86.51/node/rc.local
	#chmod -R 777 rc.local
	
	sed -i "12a mount $fenqu /mnts/\nservice sshd start\n/usr/node/ttnode -p /mnts" /etc/rc.local
	
	mac=00:60:2F$(dd bs=1 count=3 if=/dev/random 2>/dev/null |hexdump -v -e '/1 ":%02X"')
	
	sed -i "6a hwaddress $mac" /etc/network/interfaces
	
	sed -i '14a */1 * * * *	root	/usr/node/crash_monitor.sh' /etc/crontab
	clear
	echo "
	--------------------------------------------------------------------------------------------------
	
	部署成功，请输入命令：reboot 重启！
	/etc/rc.local、/etc/crontab 文件都有备份到同目录加后缀.default
	
	===================================================
	===================================================
	      请大力填写我的甜糖发财邀请码：428050
	===================================================
	===================================================
	
	
	--------------------------------------------------------------------------------------------------
	"

else
	echo "输入有误！我的邀请码是：428050"
fi
