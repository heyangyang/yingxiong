@echo ƽ̨
SET DEVICE=GameStartDesktop

SET ANE=../../../assets_mst/ane
@echo air SDKĿ¼
SET FRAME=%AIR_SDK%frameworks
@echo ��ʼ���swf
%AIR_SDK%bin\amxmlc -load-config %FRAME%\airmobile-config.xml -swf-version=27 -external-library-path+=%ANE% -debug=false -optimize=true -output %DEVICE%.swf -- ../../../src/%DEVICE%.as

pause