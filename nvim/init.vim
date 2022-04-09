" "VIMRC SETTINGS"

" "OPTIONS & SETTINGS"
source ~/.config/nvim/settings.vim

" "MAPPINGS, COMMANDS & AUTOCOMMANDS"
source ~/.config/nvim/mappings.vim

" "PLUGINS"
source ~/.config/nvim/plugins.vim

" "PLUGINS"
if filereadable('~/.config/nvim/local.vim')
    source ~/.config/nvim/local.vim
endif


" Colorscheme
" Use desert as default colorscheme, molokai if installed
silent! colorscheme desert
silent! colorscheme molokai


"
" "NOTES"
"
" TODO: Ännu snabbare mapping för viW och viw
" TODO: Sortera inline ([a, c, b] -> [a, b, c])
" TODO: Bättre text-obj för [{("'indent
" TODO: Bättre shortcut for bokmärken
" TODO: Bättre listning av saker som :reg och :ls
" TODO: Multicursor
" TODO: Better quickfix management
