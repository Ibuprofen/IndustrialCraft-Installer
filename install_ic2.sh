#/bin/sh
FORGEFILE=minecraftforge-universal-1.4.7-6.6.0.515.zip
FORGEURL=http://files.minecraftforge.net/minecraftforge/$FORGEFILE
IC2FILE=industrialcraft-2_1.112.170-lf.jar
IC2URL=https://dl.dropbox.com/u/861751/IC2/1.112/$IC2FILE

read -p "Make sure Minecraft is not running and then hit [enter] to begin."


mkdir -p ~/Downloads/industrialcraft

cd ~/Downloads/industrialcraft

curl $FORGEURL > $FORGEFILE
curl $IC2URL > $IC2FILE

if [ -d "forgefiles" ]
then
	rm -rf forgefiles
fi
mkdir forgefiles

unzip $FORGEFILE -d forgefiles/

if [ -d "extracted" ]
then
	rm -rf extracted
fi
mkdir extracted
cd extracted

jar xf ~/Library/Application\ Support/minecraft/bin/minecraft.jar

rm -rf META-INF/

# forge files merged into extracted minecraft.jar
rsync -av ~/Downloads/industrialcraft/forgefiles/ ~/Downloads/industrialcraft/extracted/


jar uf ~/Library/Application\ Support/minecraft/bin/minecraft.jar *


echo -e "\nMinecraft must run to finish installing Forge! Now opening minecraft. Log into minecraft and if forge installs okay you will see the main menu. When you get to the menu quit minecraft, return here and press [Enter]"
sleep 3

open /Applications/Minecraft.app

read -p ""

cd ~/Downloads/industrialcraft

if [ -d ~/Library/Application\ Support/minecraft/mods ]
then
	cp $IC2FILE ~/Library/Application\ Support/minecraft/mods/
	echo "Done. Firing up minecraft!"
	open /Applications/Minecraft.app
	exit 0
else
	echo "Looks like there was an issue with forge. Exiting with sad face."
	exit 1
fi
