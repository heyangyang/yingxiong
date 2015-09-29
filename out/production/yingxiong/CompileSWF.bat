@echo 平台
SET DEVICE=GameStartDesktop

SET ANE=../../../assets_mst/ane
@echo air SDK目录
SET FRAME=%AIR_SDK%frameworks
@echo 开始打包swf
%AIR_SDK%bin\amxmlc -load-config %FRAME%\airmobile-config.xml -swf-version=27 -external-library-path+=%ANE% -debug=false -optimize=true -output %DEVICE%.swf -- ../../../src/%DEVICE%.as

pause