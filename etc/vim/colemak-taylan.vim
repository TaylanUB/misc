" Redesigned mapping for Vim 7, for the Colemak layout
" Designed by Taylan Ulrich Bayırlı/Kammer
" Inspired by Shai Coleman's colemak.vim
"
" h = Left          n = Down           e = Up             i = Right
" H = Left word     N = Low            E = High           I = End word
" j = Page Up       l = Page Down      u = Left WORD      y = End WORD
" J = Join          L = Soft BOL       U = Next tab       Y = Previous tab
"
" the g commands work as expected:
" gj -> gn, gk -> ge
" ge -> gy, gE -> gY
" gi -> gs, gI -> gS
"
" gu is gc, guu is gcc
" gU is gC, gUU is gCC (but gU/gUU still work too)
"
" gs is now g\
"
" the z commands work as expected:
" zj -> qn, zk -> qe
"
" zn and zN are now qp and qP (qN (zN) still works too)
" ze is now qS (contrast to qs (zs))
"
" You can use Tab in place of Esc, to quit insert mode.
" Tab also stops search highlighting, in normal mode.
" Use S-Tab for literal tabs, in insert mode.
"
" Space appends a space in normal mode.
" Return appends a newline in normal mode.
"
" s is now a (Alter)
" i is now s (Stick)
" a is now t (Tail)
" t is now b (Before)
" y is now c (Copy)
" c is now w (sWap)
" n is now k (seeK)
" z is now q
" q is now Q
" Q is now \
"
" undo/redo is z/Z (Zap)
" line-Undo is gz
"
" inner object is now o (reverse mnemonic!)
" e.g. dib is now dob
" for do, just use :diffget, it's not that common!
"
" For X clipboard yanking:
"  C is "+
"  CC is "*
"
" In a help file:
" <CR> = goto
" <BS> = back
"

" hnei
noremap h h
noremap n j
    noremap gn gj
    noremap qn zj
        noremap qp zn
        noremap qP zN
noremap e k
    noremap ge gk
    noremap qe zk
        noremap qS ze
noremap i l
noremap <C-n> <C-e>
noremap <C-e> <C-y>
" HNEI
noremap H b
noremap N L
noremap E H
noremap I e
" jluy   j/l not meant as operator motions
nnoremap <silent> <expr> j (winheight(0)-1) . "\<C-u>"
vnoremap <silent> <expr> j (winheight(0)-1) . "\<C-u>"
nnoremap <silent> <expr> l (winheight(0)-1) . "\<C-d>"
vnoremap <silent> <expr> l (winheight(0)-1) . "\<C-d>"
noremap u B
    noremap gc gu
    nnoremap gcc guu
noremap y E
    noremap gy ge
" JLUY
noremap J J
noremap L ^
nnoremap U gT
vnoremap U gT
    noremap gC gU
    nnoremap gCC gUU
nnoremap Y gt
vnoremap Y gt
    noremap gY gE
" Insert
nnoremap s i
vnoremap s \
    nnoremap gs gi
    vnoremap gs gi
        nnoremap g\ gs
        vnoremap g\ gs
nnoremap S I
vnoremap S I
    nnoremap gS gI
    vnoremap gS gI
" Append
nnoremap t a
nnoremap T A
" Substitute
nnoremap a s
vnoremap a s
nnoremap A S
vnoremap A S
" Yank
nnoremap c y
vnoremap c y
nnoremap cc yy
" Change
nnoremap w c
vnoremap w c
nnoremap ww cc
nnoremap W C
vnoremap W C
" Till
noremap b t
noremap B T
" Search Next/Prev
noremap k n
noremap K N
" Undo/Redo
nnoremap z u
nnoremap Z <C-r>
nnoremap gz U
" z -> q -> Q -> \
noremap q z
noremap qq zz
noremap Q q
noremap \ Q
" Inner Object
vnoremap o i
onoremap o i
" Space&Return   The un/re-do is to return to the initial cursor position.
nnoremap <silent> <Space> i<Space><Esc>u:silent redo<CR>
nnoremap <silent> <Return> o<Esc>u:silent redo<CR>
" Escape/Tab
nnoremap <silent> <Tab> :nohlsearch<CR>
vnoremap <Tab> <Esc><Nul>
inoremap <Tab> <Esc>
inoremap <Esc>[Z <Tab>| " Equals <S-Tab> but works despite noesckeys
" X clipboard yanking
nnoremap C "+
vnoremap C "+
nnoremap CC "*
vnoremap CC "*
" Help-file navigation
autocmd FileType help nnoremap <buffer> <CR> <C-]>
autocmd FileType help nnoremap <buffer> <Backspace> <C-t>
