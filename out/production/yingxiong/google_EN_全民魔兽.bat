set DEV=GameStartGoogle_En
set DEV_ANE=google_en
set DEV_PACK=qmms_google_En
call pck.bat %DEV% %DEV_ANE%
call pck_yxlm.bat
java -jar %AIR_SDK%\lib\adt.jar ^
-package -target apk-captive-runtime ^
-storetype pkcs12 -keystore ../../../cert/google.p12 ^
-storepass 112233 ´ò°ü/%DEV_PACK%.apk %DEV%-app.xml GameStartLoader.swf ^
-extdir ../../../assets_mst/ane ^
-extdir ../../../assets_mst/device_ane/%DEV_ANE% icon/icon assets_google_en_atf %DEV%.swf 
pause
