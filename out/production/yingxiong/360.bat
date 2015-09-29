set DEV=GameStart360
set DEV_ANE=android_360
set DEV_PACK=360
call pck.bat %DEV% %DEV_ANE%
call pck_yxlm.bat
%AIR_SDK%\lib\adt.jar -package -target apk-captive-runtime -storetype pkcs12 ^
-keystore ../../../cert/mst.p12 ^
-storepass 112233 ´ò°ü/%DEV_PACK%.apk %DEV%-app.xml GameStartLoader.swf ^
-extdir ../../../assets_mst/ane ^
-extdir ../../../assets_mst/device_ane/%DEV_ANE% icon/icon assets_360 ^
alipay_plugin.apk ^
pro.jar so %DEV%.swf libclearsdk.gzip.ver libclearsdk.gzip libclear.process.filter 360sdk_bg.jpg
pause