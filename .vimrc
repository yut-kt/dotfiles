set nocompatible " viとの互換性をなくす

" なぜか矢印がO+ABCDになるのでマップで割り当て
nnoremap OA k
nnoremap OB j
nnoremap OC l
nnoremap OD h

" ----- 文字コード -----
set encoding=utf-8
scriptencoding utf-8

set fileencoding=utf-8 " 保存時の文字コード
set fileencodings=ucs-boms,utf-8,euc-jp,cp932 " 読み込み時の文字コード自動判別
set fileformats=unix,dos,mac " 改行コードの自動判別
set ambiwidth=double         " 文字が崩れないようにする


" ----- ファイル -----
set nobackup   " バックアップファイルを作らない
set noswapfile " スワップファイルを作らない
set autoread   " 編集中のファイルが変更されたら自動で読み直す


" ----- 入力、表示 -----
set expandtab     " タブを空白入力に置き換え
set tabstop=4     " タブの表示幅
set softtabstop=4 " 連続した空白に対してタブ、BSでカーソルが動く幅
set autoindent    " 改行時に前の行のインデントを継続
set smartindent   " 改行時に前の行の構文によってインデントを増減する
set shiftwidth=4  " smartindentで増減する幅
set list          " 空白文字の可視化
set listchars=trail:- " 空白文字の表示形式


set virtualedit=onemore,block " 行末までカーソルを移動できるようにする
set whichwrap=b,s,h,l,<,>,[,],~ " 行末から次の行への移動が可能にする

set number       " 行番号を表示
set cursorline   " カーソル行をハイライト
set cursorcolumn " カーソル列をハイライト

set ruler            " カーソルの位置を表示
set showcmd          " 入力中のコマンドを表示
set title            " 編集中のファイル名を表示
set showmode         " モードを表示
set laststatus=2     " ステータスラインを2行表示
set statusline=[%n]  " ファイルナンバー表示
set statusline+=\ %F " 空白+ファイル名表示
set statusline+=\ %m " 空白+ファイルの変更を表示
set statusline+=%r   " 読み込み専用か表示
set statusline+=%h   " ヘルプページなら[HELP]と表示
set statusline+=%w   " プレビューウインドウなら[Prevew]と表示
set statusline+=%=   " ここからツールバー右側
set statusline+=%y   " ファイルタイプ表示
set statusline+=\ [%{&fileformat} " 空白+ファイルフォーマットを表示
" 文字コードを表示
set statusline+=:%{has('multi_byte')&&\&fileencoding!=''?&fileencoding:&encoding}]
set statusline+=\ [L=%l/C=%c] "行列の表示
set statusline+=\ [%p%%]\     "現在行が全体行の何%目か表示



inoremap <C-e> <Esc>$a
inoremap <C-a> <Esc>^i
noremap <C-e> <Esc>$a
noremap <C-a> <Esc>^i


" 行が折り返しされていた場合、表示行単位でカーソルを移動する
nnoremap j gj
nnoremap k gk
nnoremap <down> gj
nnoremap <up> gk

set backspace=indent,eol,start " BSの有効化

set showmatch " 括弧の対応関係を一瞬表示する
" 自動的に閉じ括弧を入力
imap { {}<LEFT>
imap [ []<LEFT>
imap ( ()<LEFT>

" 最後のカーソル位置を復元する
if has("autocmd")
    autocmd BufReadPost *
    \ if line("'\"") > 0 && line ("'\"") <= line("$") |
    \   exe "normal! g'\"" |
    \ endif
endif

" ----- 検索 -----
set incsearch  " 文字が入力されるたびに検索を行う
set ignorecase " 検索パターンに大文字小文字を区別しない
set smartcase  " 検索に大文字を含んでいたら大文字小文字を区別する
set hlsearch   " 検索結果をハイライト
set wrapscan   " 検索候補の最後から先頭に戻る

" ESCキー2度押しでハイライトの切り替え
nnoremap <silent><Esc><Esc> :<C-u>set nohlsearch!<CR>


" ----- 補完 -----
set wildmenu     " コマンドモードの補完
set history=100 " 保存するコマンド履歴の数

" ----- マウス -----
if has('mouse')
    set mouse=a
    if has('mouse_sgr')
        set ttymouse=sgr
    elseif v:version > 703 || v:version is 703 && has('patch632')
        set ttymouse=sgr
    else
        set ttymouse=xterm2
    endif
endif

" ----- 貼り付け -----
if &term =~ "xterm"
    let &t_SI .= "\e[?2004h"
    let &t_EI .= "\e[?2004l"
    let &pastetoggle = "\e[201~"

    function XTermPasteBegin(ret)
        set paste
        return a:ret
    endfunction

    inoremap <special> <expr> <Esc>[200~ XTermPasteBegin("")
endif


" ----- 色 -----
syntax on

" コメントの色
autocmd ColorScheme * highlight Comment ctermfg=22 guifg=#008800
" 行番号の色
autocmd ColorScheme * highlight LineNr ctermfg=darkgray
" ステータスラインの色
autocmd ColorScheme * highlight StatusLine cterm=none ctermfg=30 ctermbg=none
" カラースキーム
colorscheme molokai
set t_Co=256


" ----- プラグイン -----
if has('vim_starting')
    " deinパス設定
    let s:dein_dir = fnamemodify('~/.vim/dein/', ':p') "<-お好きな場所
    let s:dein_repo_dir = s:dein_dir . 'repos/github.com/Shougo/dein.vim' "<-固定

    " dein.vim本体の存在チェックとインストール
    if !isdirectory(s:dein_repo_dir)
        execute '!git clone https://github.com/Shougo/dein.vim' shellescape(s:dein_repo_dir)
    endif

    " dein.vim本体をランタイムパスに追加
    if &runtimepath !~# '/dein.vim'
        execute 'set runtimepath^=' . s:dein_repo_dir
    endif
endif

" 必須
call dein#begin(s:dein_dir)
call dein#add('Shougo/neocomplcache')


" Plugins
" vimのlua機能が使える時だけ以下のVimプラグインをインストールする
if has('lua')
    call dein#add('Shougo/neocomplete.vim')
    call dein#add('Shougo/neosnippet')
    call dein#add('Shougo/neosnippet-snippets')
endif

" ファイルをtree表示してくれる
call dein#add('scrooloose/nerdtree')

" キーマップを作成しておく
nnoremap :tree :NERDTree

" コメントON/OFFを手軽に実行
call dein#add('tomtom/tcomment_vim')
" 必須
call dein#end()
filetype plugin indent on
syntax enable

" プラグインのインストール
if dein#check_install()
  call dein#install()
endif






