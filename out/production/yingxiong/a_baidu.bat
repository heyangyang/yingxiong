set DEV=GameStartBaidu
set DEV_ANE=android_bd
call pck.bat %DEV% %DEV_ANE%
adt -package -target apk-captive-runtime -storetype pkcs12 -keystore ../../../cert/mst.p12 -storepass 112233 ´ò°ü/a_baidu.apk %DEV%-app.xml %DEV%.swf -extdir ../../../assets_mst/ane -extdir ../../../assets_mst/device_ane/%DEV_ANE% icon/icon_baidu assets_android 
pause