#!/bin/bash
#
# Copyright (c) 2019-2020 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part2.sh
# Description: OpenWrt DIY script part 2 (After Update feeds)
#

# 修改lan
sed -i 's/192.168.1.1/10.0.0.1/g' package/base-files/files/bin/config_generate

# Add new luci-app-openclash
rm -rf feeds/luci/applications/luci-app-openclash
git clone -b dev --depth 1 https://github.com/vernesong/OpenClash.git /tmp/OpenClash
mv /tmp/OpenClash/luci-app-openclash package/

git clone --depth 1 https://github.com/nikkinikki-org/OpenWrt-nikki.git /tmp/nikki
mv /tmp/nikki/luci-app-nikki package/
mv /tmp/nikki/nikki package/

# 移除 openwrt feeds 自带的核心库
rm -rf feeds/packages/net/{xray-core,v2ray-geodata,sing-box,chinadns-ng,dns2socks,hysteria,ipt2socks,microsocks,naiveproxy,shadowsocks-rust,shadowsocksr-libev,simple-obfs,tcping,v2ray-plugin,xray-plugin,geoview,shadow-tls,smartdns}
git clone https://github.com/Openwrt-Passwall/openwrt-passwall-packages package/passwall-packages

# 移除 openwrt feeds 过时的luci版本
rm -rf feeds/luci/applications/luci-app-passwall
git clone https://github.com/Openwrt-Passwall/openwrt-passwall package/passwall-luci

# 移除旧版homeproxy
rm -rf feeds/luci/applications/luci-app-homeproxy
git clone https://github.com/VIKINGYFY/homeproxy package/homeproxy

# 移除旧版daed
rm -rf feeds/packages/net/dae
rm -rf feeds/packages/net/daed
rm -rf feeds/packages/net/honk
rm -rf feeds/luci/applications/luci-app-daed
rm -rf feeds/luci/applications/luci-app-honk
#git clone https://github.com/kenzok8/openwrt-daede
git clone https://github.com/kenzok8/openwrt-honk

# 添加mosdns
rm -rf feeds/packages/net/mosdns
rm -rf feeds/luci/applications/luci-app-mosdns
git clone https://github.com/sbwml/luci-app-mosdns package/mosdns

# 添加podman 
git clone --depth 1 --single-branch https://github.com/breeze303/openwrt-podman package/podman
./scripts/feeds install -a

# 更换Geodata
# rm -rf feeds/packages/net/v2ray-geodata
# git clone https://github.com/laosan-xx/my-v2ray-geodata package/geodata
