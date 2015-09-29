
call CompileSWF.bat
%AIR_SDK%\bin\adl.exe -profile extendedMobileDevice -screensize NexusOne -XscreenDPI 252 -XversionPlatform AND -nodebug -extdir ane GameStartDesktop-app.xml  -- %1 
