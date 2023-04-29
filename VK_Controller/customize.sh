SKIPUNZIP=0
MODDIR=${0%/*}

mkdir -p /storage/emulated/0/Android/VK_Controller
echo "- 配置文件在/storage/emulated/0/Android/VK_Controller"
[ -f /storage/emulated/0/Android/VK_Controller/normal.conf ] && mv /storage/emulated/0/Android/VK_Controller/normal.conf /storage/emulated/0/Android/VK_Controller/normal.conf.bak
echo "# #开头即表明该行无效，请添加配置时仔细阅读相关说明事项
# #开头即表明该行无效，请添加配置时仔细阅读相关说明事项
# #开头即表明该行无效，请添加配置时仔细阅读相关说明事项

# 重启后生效
# 重启后生效
# 重启后生效

# 配置格式:
# 参数名称 数值
# 核心类型：
#          lp:小核
#          hp:大核
#          pr:超大核
# limit_freq：触发限制时目标频率
# lcpi/spc：限制条件参数

# 非专业人士请不要修改该部分内容，开始

# ---------------------------------------------------------------------

# Normal 常规配置

# 小核配置
limit_freq_lp 1305600
lcpi_threshold_lp 2
spc_threshold_lp 44

# 大核配置
limit_freq_hp 1555200
lcpi_threshold_hp 3
spc_threshold_hp 25

# 超大核配置
limit_freq_pr 1785600
lcpi_threshold_pr 4
spc_threshold_pr 20

# BOOST 全局加速配置

# 小核配置
limit_freq_lp_boost 1708800
lcpi_threshold_lp_boost 4
spc_threshold_lp_boost 44

# 大核配置
limit_freq_hp_boost 1881600
lcpi_threshold_hp_boost 4
spc_threshold_hp_boost 25

# 超大核配置
limit_freq_pr_boost 1785600
lcpi_threshold_pr_boost 4
spc_threshold_pr_boost 20

# ---------------------------------------------------------------------

# 非专业人士请不要修改该部分内容，结束
" >/storage/emulated/0/Android/VK_Controller/normal.conf

[ ! -f /storage/emulated/0/Android/VK_Controller/custom.conf ] && echo "# #开头即表明该行无效，请添加配置时仔细阅读相关说明事项
# #开头即表明该行无效，请添加配置时仔细阅读相关说明事项
# #开头即表明该行无效，请添加配置时仔细阅读相关说明事项

# 重启后生效
# 重启后生效
# 重启后生效

# 配置格式:
# 参数名称 数值
# 核心类型：
#          lp:小核
#          hp:大核
#          pr:超大核

# BOOST 单应用 加速配置
# 根据自己需要，按需添加
# 小核可用频率：300000 403200 499200 595200 691200 806400 902400 998400 1094400 1209600 1305600 1401600 1497600 1612800 1708800 1804800
# 大核可用频率：710400 844800 960000 1075200 1209600 1324800 1440000 1555200 1670400 1766400 1881600 1996800 2112000 2227200 2342400 2419200
# 超大核可用频率：844800 960000 1075200 1190400 1305600 1420800 1555200 1670400 1785600 1900800 2035200 2150400 2265600 2380800 2496000 2592000 2688000 2764800 2841600

# ---------------------------------------------------------------------

# 专属配置
# 必须严格按照用法进行添加
# 用法：
#      # APP应用名
#      limit_freq_核心类型_APP包名 频率
#      APP包名
# 例如：
#      # 王者荣耀
#      limit_freq_lp_com.tencent.tmgp.sgame 1708800
#      com.tencent.tmgp.sgame

# ---------------------------------------------------------------------

# 通用配置
# 未设置单应用专属加速配置时
# 会从normal.conf全局加速配置选取加速频率
# 用法：
#      # APP应用名
#      APP包名
# 例如：
#      # Example
#      com.example.test

# ---------------------------------------------------------------------

# 专属配置开始

# 王者荣耀
limit_freq_lp_com.tencent.tmgp.sgame 1708800
com.tencent.tmgp.sgame

# 王者荣耀前瞻版
limit_freq_lp_com.tencent.tmgp.sgamece 1708800
com.tencent.tmgp.sgamece

# 专属配置结束

# ---------------------------------------------------------------------

# 通用配置开始


# 通用配置结束

# ---------------------------------------------------------------------
" >/storage/emulated/0/Android/VK_Controller/custom.conf
