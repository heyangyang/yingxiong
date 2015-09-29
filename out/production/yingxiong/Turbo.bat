set DEV=GameStartTurbo
set DEV_ANE=alipay
set DEV_PACK=turbo
call pck.bat %DEV% %DEV_ANE%
call pck_yxlm.bat
java -jar %AIR_SDK%\lib\adt.jar ^
-package ^
-target apk-captive-runtime ^
-storetype pkcs12 -keystore ../../../cert/mst_2funfun.p12 ^
-storepass 112233 ´ò°ü/%DEV_PACK%.apk %DEV%-app.xml GameStartLoader.swf ^
-extdir ../../../assets_mst/ane ^
-extdir ../../../assets_mst/device_ane/%DEV_ANE% ^
icon/icon assets_360 %DEV%.swf 
pause
