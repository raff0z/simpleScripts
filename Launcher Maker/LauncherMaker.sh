#!/bin/bash

command -v convert >/dev/null 2>&1 || {  zenity --warning --text "convert is required (Imagemagick)" --title "Warning!" ; exit 1; }

export applicationsPath="$HOME/.local/share/applications"
export appIconPath="$HOME/.local/share/icons/ulc"

if [ ! -d "$applicationsPath" ]; then
  mkdir -p $applicationsPath
fi

if [ ! -d "$appIconPath" ]; then
  mkdir -p $appIconPath
fi

#----------------inizio scelta argomenti--------------
export nomeApp="`zenity --entry --text="Insert Application name" --title="Application Name"`"
export versione="`zenity --entry --text="Version" --title="Application Version"`"
export NomeGenerico="`zenity --entry --text="Generic name" --title="Application Generic Name"`"
export Commento="`zenity --entry --text="Comment" --title="Application Comment"`"
zenity --info --text="Select application executable"
export Exec="`zenity --file-selection --text="Select application executable" --title="Choose executable"`"
zenity --info --text="Select the image of the application, preferably ico"

#-------------------icona----------------
export IconaPath="`zenity --file-selection --text="Select the image of the application" --title="Select the image"`"
Iconfilename=$(basename "$IconaPath")
Iconextension="${Iconfilename##*.}"
Iconfilename="${Iconfilename%.*}".ico

export applicationIconWName="$HOME/.local/share/icons/ulc/$Iconfilename"

convert -resize 128x128 $IconaPath $applicationIconWName
#-----------------------------------------

export Terminale="`zenity --title "Select" --list --text "Select true if is a terminal app" --radiolist --column "Choose" --column "Bool" FALSE "true" TRUE "false"`"
#export Tipo="`zenity --entry --text="Inserisci il tipo dell'applicazione" --title="Tipo Applicazione"`"
export Tipo="Application"
#export Categorie="`zenity --entry --text="Inserisci le categorie dell'applicazione separate da un ; " --title="Categorie Applicazione"`"
#---------------scelta categorie-----------
export categories=`cat /usr/share/applications/*.desktop | grep Categori | awk -F'=' '{print $2}' | awk '{gsub (";"," ") ; print }' | awk 'BEGIN {RS=" ";FS=" "} {print}' | sort |  uniq | sed '1{/^$/d}' | sed 's/^/FALSE /g' | sed ':a;N;$!ba;s/\n/ /g'`

export Categorie="`zenity --title "Select" --list --height 500 --text "Select some categories" --checklist --column "Choose" --column "Category" $categories --separator=";"`"
#------------------------------------------

#------------------------------------------

export applicationPathWName="$applicationsPath/$nomeApp.desktop"


touch $applicationPathWName
echo [Desktop Entry] >> $applicationPathWName
echo Version=1.0 >> $applicationPathWName
echo Name="$nomeApp" >> $applicationPathWName
echo GenericName="$NomeGenerico" >> $applicationPathWName
echo Comment="$Commento" >> $applicationPathWName
echo >> $applicationPathWName
echo Exec=\""$Exec"\">> $applicationPathWName
echo Icon=$applicationIconWName>> $applicationPathWName
echo Terminal="$Terminale">> $applicationPathWName
echo Type="$Tipo">> $applicationPathWName
echo Categories="$Categorie">> $applicationPathWName

chmod +x $applicationPathWName
