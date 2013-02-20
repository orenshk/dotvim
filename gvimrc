" map command-T to activate commandT plugin.
if has("gui_macvim")
    macmenu &File.New\ Tab key=<nop>
    map <D-t> :CommandT<CR>
    map <D-m> <nop>
endif
