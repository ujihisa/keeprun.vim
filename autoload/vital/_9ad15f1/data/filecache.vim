let s:save_cpo = &cpo
set cpo&vim


function! s:new(...)
  echo a:0
endfunction


let &cpo = s:save_cpo
