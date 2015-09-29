set DEV=GameStartLj
set DEV_ANE=device
set DEV_PACK=lj
call pck.bat %DEV% %DEV_ANE%
adt -package -target apk-captive-runtime -storetype pkcs12 -keystore ../../../cert/lj_SDK.p12 -storepass 112233 ´ò°ü/%DEV_PACK%.apk %DEV%-app.xml %DEV%.swf -extdir ../../../assets_mst/ane -extdir ../../../assets_mst/device_ane/%DEV_ANE% icon/icon assets_android
pause