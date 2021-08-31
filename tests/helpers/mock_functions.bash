# shellcheck source=tests/helpers/global_variables.bash
source "tests/helpers/global_variables.bash"

systemctl() {
	# systemctl will return zero exit code if args are correct
	if [[ "${#}" == 3 ]] &&
		[[ "${1}" == "is-active" ]] &&
		[[ "${2}" == "--quiet" ]] &&
		[[ "${3}" == "pt-os-updater" ]]; then
		touch "${valid_systemctl_breadcrumb:?}"
		return 1
	else
		# Avoid sleeping in do_update_check - check for breadcrumb
		return 1
	fi
}
export -f systemctl

get_display() {
	echo ":0"
}
export -f get_display

env() {
	if [[ "${#}" == 2 ]]; then
		[[ "${1}" == "DISPLAY=$(get_display)" ]] || return 1
		[[ "${2}" == "/usr/lib/pt-os-updater/check-now" ]] || return 1
		echo "env update check - ${1}: OK"

		return 0
	elif [[ "${#}" == 5 ]]; then
		[[ "${1}" == "SUDO_USER=root" ]] || [[ "${1}" == "SUDO_USER=pi" ]] || return 1
		[[ "${2}" == "raspi-config" ]] || return 1
		[[ "${3}" == "nonint" ]] || return 1
		[[ "${4}" == "do_audio" ]] || return 1
		[[ "${5}" == "1" ]] || [[ "${5}" == "9" ]] || return 1
		echo "env do_audio - ${1}: OK"

		return 0
	else
		return 1
	fi
}

xset() {
	[[ "${#}" == 3 ]] || return 1
	[[ "${1}" == "dpms" ]] || return 1
	[[ "${2}" == "force" ]] || return 1
	[[ "${3}" == "on" ]] || return 1
	echo "xset: OK"
	return 0
}
export -f xset

xrandr() {
	if [[ "${#}" == 4 ]]; then
		[[ "${1}" == "--output" ]] || return 1
		# $2 is display name
		[[ "${3}" == "--mode" ]] || return 1
		[[ "${4}" == "1920x1080" ]] || return 1
		echo "xrandr set res - ${2}: OK"
		return 0
	elif [[ "${#}" == 1 ]]; then
		[[ "${1}" == "--query" ]] || return 1
		echo "Screen 0: minimum 320 x 200, current 1920 x 1080, maximum 7680 x 7680
HDMI-1 connected primary 1920x1080+0+0 (normal left inverted right x axis y axis) 1214mm x 683mm
   1920x1080     60.00*+  59.94    30.00    29.97
   1920x1080i    60.00    50.00    59.94
   1280x720      60.00    50.00    59.94
   640x480       60.00    59.94
   1920x1080_vnc  60.00"
		return 0
	fi
	return 1
}
export -f xrandr

runlevel() {
	echo "N 5"
}
export -f runlevel
