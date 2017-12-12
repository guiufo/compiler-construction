#! /bin/sh

echo "---------- Script para executar programas automaticamente -----------\n"

echo "Smali -> Dex -> Zip -> Classe"
java -jar smali.jar assemble $1.smali -o classes.dex
zip arquivo.zip classes.dex
adb push arquivo.zip /data/local
adb shell dalvikvm -cp /data/local/arquivo.zip $1
