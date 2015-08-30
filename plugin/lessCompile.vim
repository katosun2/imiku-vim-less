"=============================================================================
"     FileName: lessCompile.vim
"         Desc: compile Less to Css
"       Author: Ryu
"        Email: neko@imiku.com
"     HomePage: http://www.imiku.com/
"      Version: 0.0.1
"   LastChange: 2015-08-28 21:08:25
"      History:
"=============================================================================
if exists("b:loaded_vim_less")
	finish
endif
let b:loaded_vim_less = 1

" defind color
hi lessSuccMsg guifg=green gui=bold
hi lessRunMsg guifg=orange
hi lessWarnMsg guifg=red

" node path
if !exists("g:lessc_node_cmd")
	let g:lessc_node_cmd = 'node'
endif

" lessc path
if !exists("g:lessc_cmd")
	let s:script_folder_path = escape(expand('<sfile>:p:h'), '\')
	let g:lessc_cmd = s:script_folder_path . '/../less/node_modules/less/bin/lessc'
endif

if !filereadable(g:lessc_cmd) 
	echohl lessWarnMsg | echomsg "lessc not found " 
	echohl lessWarnMsg | echomsg "you need config g:lessc_cmd in your vimrc" 
	echohl None
	finish
endif

" output sourceMap, default close
if !exists("g:lessc_source_open")
	let g:lessc_source_open = 0 
endif

" options default empty
if !exists("g:lessc_opts")
	let g:lessc_opts = ''
endif

if !executable(g:lessc_node_cmd)
	echohl lessWarnMsg | echomsg "node not found " 
	echohl lessWarnMsg | echomsg "you need config g:lessc_node_cmd in your vimrc" 
	echohl None
	finish
endif

func! g:CompileLessCss(...)
	" step1
	let l:fenc = &fenc
	if (l:fenc=='utf-8')
		let l:fenc = 'utf-8'
	elseif (l:fenc=='cp936')
		let l:fenc = 'gb2312'
	else 
		let l:fenc = 'utf-8'
	endif

	" step2
	let l:type = &filetype

	if empty(l:type)
		echohl lessWarnMsg | echomsg "No input file! m(_ _)m" 
		return
	endif

	" step3
	let l:input = fnameescape(expand("%:p"))

	if match(l:input, '\.less$') != -1
		let l:output = fnameescape(expand("%:p:r") . ".css")

		if g:lessc_source_open == 1
			let l:outMap = fnameescape(expand("%:r") . '.map')
			let l:cmd = g:lessc_node_cmd . ' ' . g:lessc_cmd .' --clean-css --no-color --source-map=' . l:outMap . ' ' . l:input . ' ' . l:output
		else
			let l:cmd = g:lessc_node_cmd . ' ' . g:lessc_cmd .' --clean-css --no-color ' . g:lessc_opts . ' ' . l:input . ' ' . l:output
		endif

	else
		echohl lessWarnMsg | echomsg "LESS only! m(_ _)m" | echohl None
		return
	endif

	let l:cmd = substitute(l:cmd, 'Program Files', 'Progra~1', 'g')
	let l:cmd = iconv(l:cmd, "utf-8", "gbk")

	echohl lessRunMsg | echomsg "Please, Wait... >_<" | echohl None
	let l:errs = system(l:cmd)

	if (!empty(l:errs))
		if has("win32") || has("win64") && exists("iconv") && v:lang == 'zh_CN.utf-8'
			let l:errs = iconv(substitute(l:errs, "^$", "", "g"), "gbk", "utf-8")
		else
			let l:errs = substitute(l:errs, "^$", "", "g")
		endif

		echo l:errs
	else
		echohl lessSuccMsg | echomsg "Ok! ^_^" | echohl None
	endif
endfunc

" auto compile less
func! g:OpenComileLess()
	autocmd! BufWritePost,FileWritePost *.less call g:CompileLessCss()
	echohl Title | echomsg "Open auto complie Less to Css! ^_^ " | echohl None
endfunc

" defined command
command! -nargs=* -complete=file -bang Lessc :call g:CompileLessCss(<f-args>)
cabbrev Lessc <c-r>=getcmdpos() == 1 && getcmdtype() == ":" ? "Lessc" : "lessc"<CR>

command! -nargs=0 -bang LesscAuto :call g:OpenComileLess()
cabbrev LesscAuto <c-r>=getcmdpos() == 1 && getcmdtype() == ":" ? "LesscAuto" : "lesscauto"<CR>

" vim: set noet fdm=syntax ff=dos sts=4 sw=4 ts=4 tw=78 : 
