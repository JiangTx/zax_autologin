# zax_autologin
ZAX石斧软件校园网自动登录脚本

# 使用方法
修改[net.sh](https://github.com/JiangTx/zax_autologin/blob/main/net.sh) 中

userId='用户名'

passwd='密码'

按需修改认证网页地址/认证服务器wlanacip/认证vlan/认证wlanacname

# 提点思路

可自定义User-Agent 需要和防检测软件一起修改

可实现一台路由器认证为手机 另一台路由器认证为电脑

# 使用报告
在OpenWRT设备测试通过 LED代码适配京东云一代

京东云一代使用 ShellClash & UA3F 在100Mbps下宽带尚为可用 

# 校园网多设备检测

[UA3F](https://github.com/SunBK201/UA3F/blob/master/README.md#ua3f)(需搭配ShellClash/OpenClash使用)

[UA2F](https://github.com/Zxilly/UA2F)

# 声明
本脚本并非破解软件，不提供破解功能，无任何入侵和破解行为。

本脚本免费发布并无任何盈利行为，请勿商用。
