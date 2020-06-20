BASIC_DIR=$(pwd)
chmod +x $BASIC_DIR/scripts/basic.sh
chmod +x $BASIC_DIR/scripts/checkrequirements.sh
chmod +x $BASIC_DIR/scripts/settings_setup.sh
$BASIC_DIR/scripts/checkrequirements.sh
echo $BASIC_DIR
echo "export BASIC_DIR=\"$BASIC_DIR\"" >> ~/.bashrc
echo "alias basic=\"$BASIC_DIR/scripts/basic.sh\"" >> ~/.bashrc