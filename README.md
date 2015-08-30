imiku-vim-less
==============
## *Vim 7.3 or later*

![vim version](https://img.shields.io/badge/vim-%3E%3D%207.3-green.svg) ![node version](https://img.shields.io/badge/node-%3E%3D%200.6-yellow.svg) ![less version](https://img.shields.io/badge/less-2.5.1-blue.svg) ![license MIT](https://img.shields.io/dub/l/vibe-d.svg)

## 使用

> 将 Less 编译 为 CSS

	:lessc

> 将 Less 自动转 为 CSS

	:lesscAuto

<br>

## 说明

`imiku-vim-less` 插件部分功能转用说明:

`indent/less.vim` : less缩进功能使用 [vim-javascript](http://github.com/pangloss/vim-javascript) 

`syntax/less.vim` : less语法高亮使用 [vim-less](http://github.com/pangloss/vim-javascript) 


## 安装

如果使用 [Vundle](https://github.com/gmarik/vundle), 将下面配置添加到你的 `.vimrc` 文件:

`Bundle 'katosun2/imiku-vim-less'`

如果使用 [Pathogen](https://github.com/tpope/vim-pathogen) 可以从代码库复制一份到你的 `'~/.vim/bundle'` 里面:

`$ cd ~/.vim/bundle`

`$ git clone https://github.com/katosun2/imiku-vim-less.git`

## 帮助

> 如何将 `node` 路径添加到插件中？

把这行配置写入到你的 vimrc 里面，注意修改 `node` 路径:

	let g:lessc_node_cmd = '你的node绝对路径'

> 如何将 `less` 路径添加到插件中？

	$ npm install less -g

	把这行配置写入到你的 vimrc 里面，注意这里的 `lessc` 路径:

	let g:lessc_cmd = '/node_modules/less/bin/lessc'

> 如何生成`sourceMap`？

	把这行配置写入到你的 vimrc 里面:

	let g:lessc_source_open = 1 
	
> 如何添加一些参数到 `lessc`？

	把相关参数配置写入到你的 vimrc 里面:

	let g:lessc_opts = '-x --no-js'

<br>

## License MIT
