set DEV=GameStartAUc
set DEV_ANE=android_uc
set DEV_PACK=°²×¿uc
call pck.bat %DEV% %DEV_ANE%
adt -package -target apk-captive-runtime -storetype pkcs12 -keystore ../../../cert/mst.p12 -storepass 112233 ´ò°ü/%DEV_PACK%.apk %DEV%-app.xml %DEV%.swf -extdir ../../../assets_mst/ane -extdir ../../../assets_mst/device_ane/%DEV_ANE% icon/icon_uc assets_android ucgamesdk
pause