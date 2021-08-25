fun! Whid()
	lua for k in pairs(package.loaded) do if k:match("^whid") then package.loaded[k] = nil end end
	lua require("whid").whid()
endfun

let g:whid_value = 42

augroup Whid
	autocmd!
  command! Whid lua require'whid'.whid()
augroup END
