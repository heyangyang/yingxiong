@echo ƽ̨
SET DEVICE=%1

@echo air SDKĿ¼
SET FRAME=%AIR_SDK%frameworks
@echo ͨ��ane
SET ANE=../../../assets_mst/ane
@echo ƽ̨��Ҫ��ane  
SET ANE_DEVICE=../../../assets_mst/device_ane/%2
@echo ƽ̨��Ҫ��xml
SET SOURCE_SWC_PATH=..\..\..\src\%DEVICE%-app.xml
@echo copy xml����ǰĿ¼
copy /B /Y %SOURCE_SWC_PATH% .
@echo ��ʼ���swf
%AIR_SDK%bin\amxmlc -load-config %FRAME%\airmobile-config.xml -swf-version=27 -external-library-path+=%ANE% -external-library-path+=%ANE_DEVICE%  -debug=false -optimize=true -output %DEVICE%.swf -- ../../../src/%DEVICE%.as
:aaa