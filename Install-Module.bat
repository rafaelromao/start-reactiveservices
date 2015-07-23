SET modulespath="%homedrive%%homepath%\Documents\WindowsPowerShell\Modules\Start-ReactiveServices"
rd /s /q %modulespath%
md %modulespath%
copy *.ps?1 %modulespath%