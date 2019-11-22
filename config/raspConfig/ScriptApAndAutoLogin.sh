echo "Enter network name: "
read network_name
echo "Enter password name"
read password_name
echo >> /etc/dhcpcd.conf "denyinterfaces wlan0"
echo >> /etc/network/interfaces "allow-hotplug wlan0
iface wlan0 inet static
address 192.168.1.2
netmask 255.255.255.0
network 192.168.1.1
broadcast 192.168.1.255
# wpa-conf /etc/wpa_supplicant/wpa_supplicant.conf"
echo >> /etc/hostapd/hostapd.conf "interface=wlan0
driver=nl80211
ssid=$network_name
hw_mode=g
channel=6
macaddr_acl=0
auth_algs=1
ignore_broadcast_ssid=0
wpa=2
wpa_passphrase=$password_name
wpa_key_mgmt=WPA-PSK
rsn_pairwise=CCMP"
echo >> /etc/default/hostapd 'DAEMON_CONF="/etc/hostapd/hostapd.conf"'
echo >> /etc/dnsmasq.conf "interface=wlan0
listen-address=192.168.1.2
bind-interfaces
server=8.8.8.8
domain-needed
bogus-priv
dhcp-range=192.168.1.120,192.168.1.254,12h"
echo >> /etc/sysctl.conf "net.ipv4.ip_forward=1"
sudo iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE
sudo iptables -A FORWARD -i eth0 -o wlan0 -m state --state RELATED,ESTABLISHED -j ACCEPT
sudo iptables -A FORWARD -i wlan0 -o eth0 -j ACCEPT
sh -c "iptables-save > /etc/iptables.ipv4.nat"
echo >> /etc/rc.local "iptables-restore < /etc/iptables.ipv4.nat
/usr/sbin/hostapd /etc/hostapd/hostapd.conf
service ssh restart"
echo >> /etc/lightdm/lightdm.conf "[SeatDefaults]
greeter-show-manual-login=true
greeter-hide-users=true
autologin-user=seunomedeuser
autologin-user-timeout=0"
echo "Raspberry transformado em um Acces Point.
Ip: 192.168.1.2
NetWork name: $network_name
Password name: $password_name"
