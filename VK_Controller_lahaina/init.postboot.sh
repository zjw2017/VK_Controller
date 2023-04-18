#config power effiecny tunning parameters
echo 1 >/sys/module/cpufreq_effiency/parameters/affect_mode
echo "300000,45000,1209600,50000,1305600" >/sys/module/cpufreq_effiency/parameters/cluster0_effiency
echo "710400,45000,1881600,50000,1075200" >/sys/module/cpufreq_effiency/parameters/cluster1_effiency
echo "844800,50000,2035200,55000,1075200" >/sys/module/cpufreq_effiency/parameters/cluster2_effiency

echo "80 2112000:95" >/sys/devices/system/cpu/cpufreq/policy4/schedutil/target_loads

echo "80 2380800:95" >/sys/devices/system/cpu/cpufreq/policy7/schedutil/target_loads

echo 1 > /sys/devices/system/cpu/cpufreq/policy0/schedutil/pmu_limit_enable
echo 1 > /sys/devices/system/cpu/cpufreq/policy4/schedutil/pmu_limit_enable
echo 1 > /sys/devices/system/cpu/cpufreq/policy7/schedutil/pmu_limit_enable

chown -h system.system /sys/devices/system/cpu/cpufreq/policy0/schedutil/target_loads
chown -h system.system /sys/devices/system/cpu/cpufreq/policy4/schedutil/target_loads
chown -h system.system /sys/devices/system/cpu/cpufreq/policy7/schedutil/target_loads

echo 500 >/sys/devices/system/cpu/cpu0/cpufreq/schedutil/up_rate_limit_us
echo 5000 >/sys/devices/system/cpu/cpu0/cpufreq/schedutil/down_rate_limit_us
echo 500 >/sys/devices/system/cpu/cpu4/cpufreq/schedutil/up_rate_limit_us
echo 20000 >/sys/devices/system/cpu/cpu4/cpufreq/schedutil/down_rate_limit_us
echo 500 >/sys/devices/system/cpu/cpu7/cpufreq/schedutil/up_rate_limit_us
echo 20000 >/sys/devices/system/cpu/cpu7/cpufreq/schedutil/down_rate_limit_us

#insmod /vendor/lib/modules/qca_cld3_wlan.ko
