@echo 平台
SET DEVICE=GameStartLoader

SET ANE=../../../assets_mst/ane
@echo air SDK目录
SET FRAME=%AIR_SDK%frameworks
@echo 开始打包swf
%AIR_SDK%bin\amxmlc -load-config %FRAME%\airmobile-config.xml -external-library-path+=%ANE%  -swf-version=27 -debug=false -optimize=true -output %DEVICE%.swf -- ../../../src/%DEVICE%.as
:aaa