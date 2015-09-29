set DEV=GameStartIos
set DEV_ANE=ios
call pck.bat %DEV% %DEV_ANE%
java.exe -Dapplication.home=%AIR_SDK% -Dfile.encoding=UTF-8 -Djava.awt.headless=true -Duser.language=en -Duser.region=en -Xmx512m -jar %AIR_SDK%\lib\adt.jar -package  -target ipa-app-store  -storetype PKCS12 -keystore ../../../cert/dev_qmms.p12 -storepass 223344  -provisioning-profile ../../../cert/dev_qmms.mobileprovision ´ò°ü/TestiosQMMS_JT.ipa %DEV%-app.xml -extdir ../../../assets_mst/ane -extdir ../../../assets_mst/device_ane/%DEV_ANE%  %DEV%.swf Default.png Default@2x.png Default-568h@2x.png Default~ipad.png Default-Landscape.png Default-Landscape@2x~ipad.png Default-Landscape~ipad.png assets_ios icon/icon
pause
