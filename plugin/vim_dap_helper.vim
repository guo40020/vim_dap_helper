let s:plugin_path = escape(expand('<sfile>:p:h'), '\')
exe 'py3file ' . escape(s:plugin_path, ' ') . '/plug.py'

function! LoadLaunchJson()
  python3 load_launch()
endfunction

command! LoadLaunchJson call LoadLaunchJson()
command Test lua require 'plug'.debug()
