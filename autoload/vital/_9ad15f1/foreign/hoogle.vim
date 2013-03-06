let s:save_cpo = &cpo
set cpo&vim
let s:V = vital#{expand('<sfile>:h:h:t:r')}#new()

function! s:has_hoogle()
  return executable('hoogle')
endfunction

function! s:search(mod, func)
  let result = s:V.system('hoogle -i +' . a:mod . ' ' . a:func)
  if result =~# '^No results found\|^package '
    let pkgs = split(s:V.system('hoogle ' . a:mod), '\n')
    for pkg in map(pkgs, 'substitute(v:val, "^package ", "", "")')
      let result2 = s:V.system('hoogle +' . pkg . ' ' . a:mod)
      if result2 =~# '^No results found\|^Could not find'
        continue
      endif
      if result2 =~# '^' . a:mod . ' '
        let result = s:V.system('hoogle -i +' . pkg . ' +' . a:mod . ' ' . a:func)
        break
      endif
    endfor
  endif
  return substitute(result, '\n\n', '\n', '')
endfunction

let &cpo = s:save_cpo
