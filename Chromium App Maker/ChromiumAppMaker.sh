#!/bin/bash

zenity --info --text="Select appplication image, preferably png and 128x128"
export immagine="`zenity --file-selection --text="select application image" --title="Select an image"`"
export nomeApp="`zenity --entry --text="Insert application name" --title="Application Name"`"
export descrApp="`zenity --entry --text="Insert a description" --title="Application Description"`"
export urlApp="`zenity --entry --text="Insert url application (without http://)" --title="Url Application"`"
export portApp="`zenity --entry --text="Insert port application (empty if is not specified)" --title="Port Application"`"
mkdir ~/"$nomeApp"
echo {  >> ~/"$nomeApp"/manifest.json
echo \"name\": \""$nomeApp"\",  >> ~/"$nomeApp"/manifest.json
echo \"description\": \""$descrApp"\",  >> ~/"$nomeApp"/manifest.json
echo \"version\": \"0.0\",  >> ~/"$nomeApp"/manifest.json
echo \"icons\": {  >> ~/"$nomeApp"/manifest.json
echo \"128\": \"128.png\"  >> ~/"$nomeApp"/manifest.json
echo },  >> ~/"$nomeApp"/manifest.json
echo \"app\": {  >> ~/"$nomeApp"/manifest.json
echo \"urls\": [  >> ~/"$nomeApp"/manifest.json
echo \"http://"$urlApp"\"  >> ~/"$nomeApp"/manifest.json
echo ],  >> ~/"$nomeApp"/manifest.json
echo \"launch\": {  >> ~/"$nomeApp"/manifest.json
if [ "$portApp" == "" ] ;then 
	echo \"web_url\": \"http://"$urlApp"\"  >> ~/"$nomeApp"/manifest.json
else
	echo \"web_url\": \"http://"$urlApp"":""$portApp"\"  >> ~/"$nomeApp"/manifest.json
fi
echo }  >> ~/"$nomeApp"/manifest.json
echo },  >> ~/"$nomeApp"/manifest.json
echo \"permissions\": [  >> ~/"$nomeApp"/manifest.json
echo \"unlimitedStorage\",  >> ~/"$nomeApp"/manifest.json
echo \"notifications\"  >> ~/"$nomeApp"/manifest.json
echo ]  >> ~/"$nomeApp"/manifest.json
echo }  >> ~/"$nomeApp"/manifest.json
cp "$immagine" ~/"$nomeApp"/128.png
zenity --info --text="Now open chromium/chrome -> tools -> extensions and enable \"Developer Mode\" , clic on \"load unpacked extension...\" and select the app folder in your home"
