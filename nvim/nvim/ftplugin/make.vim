if exists("b:did_ftplugin_make")
  finish
endif

let b:did_ftplugin_make = 1 " Don't load twice in one buffer
setlocal noexpandtab shiftwidth=4 softtabstop=0
