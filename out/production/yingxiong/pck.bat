@echo 平台
SET DEVICE=%1

@echo air SDK目录
SET FRAME=%AIR_SDK%frameworks
@echo 通用ane
SET ANE=../../../assets_mst/ane
@echo 平台需要的ane  
SET ANE_DEVICE=../../../assets_mst/device_ane/%2
@echo 平台需要的xml
SET SOURCE_SWC_PATH=..\..\..\src\%DEVICE%-app.xml
@echo copy xml到当前目录
copy /B /Y %SOURCE_SWC_PATH% .
@echo 开始打包swf
%AIR_SDK%bin\amxmlc -load-config %FRAME%\airmobile-config.xml -swf-version=27 -external-library-path+=%ANE% -external-library-path+=%ANE_DEVICE%  -debug=false -optimize=true -output %DEVICE%.swf -- ../../../src/%DEVICE%.as
:aaa