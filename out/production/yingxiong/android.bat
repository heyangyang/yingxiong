set DEV=yingxiong
call pck.bat %DEV%
adt -package -target apk-captive-runtime -storetype pkcs12 -keystore ../../../cert/mst.p12 -storepass 112233 ´ò°ü/win.apk %DEV%-app.xml %DEV%.swf -extdir ../../../assets_mst/ane icon/icon assets_android 
pause