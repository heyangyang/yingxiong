@echo ƽ̨
SET DEVICE=GameStartLoader

SET ANE=../../../assets_mst/ane
@echo air SDKĿ¼
SET FRAME=%AIR_SDK%frameworks
@echo ��ʼ���swf
%AIR_SDK%bin\amxmlc -load-config %FRAME%\airmobile-config.xml -external-library-path+=%ANE%  -swf-version=27 -debug=false -optimize=true -output %DEVICE%.swf -- ../../../src/%DEVICE%.as
:aaa