"" vim settings
"" @(#) vim user specific settings[
""
"
" @versiion  1.0.0
" @author    Furukawa, Atsushi <atsushifx@aglabo.com>
" @date      2022-07-02
" @license   MIT
"

""
" viminfo
" set viminfofile=$XDG_DATA_HOME/vim/viminfo


"" vim common settings

" encoding : default display Japanese
set fenc=utf-8
set encoding=utf-8
set fileformats=unix

" 行番号
set number

" vim の矩形選択で文字が無くても右へ進める
set virtualedit=block

" 挿入モードでバックスペースで削除できるようにする
set backspace=indent,eol,start

