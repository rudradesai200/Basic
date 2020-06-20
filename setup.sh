export BASIC_DIR="$1"
alias basic=$1/basic/scripts/basic.sh
chmod +x $1/basic/scripts/basic.sh
chmod +x $1/basic/scripts/checkrequirements.sh
chmod +x $1/basic/scripts/settings_setup.sh
$1/basic/scripts/checkrequirements.sh