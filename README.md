# My Awesome VIM Setup

This repository contains (nearly) all of the necessary configuration files for my vim environment.

## Prerequisites

Make sure the following are installed and properly configured:
- terminal of your choice
- vim (preferably neovim)
- [vim-plug](https://github.com/junegunn/vim-plug) Plugin manager
- [tmux](https://github.com/tmux/tmux) Terminal pane manager
- [tmuxinator](https://github.com/tmuxinator/tmuxinator) Tmux session manager

Optional plugins:
- [selenized color theme](https://github.com/jan-warchol/selenized)

The rest of the plugins are managed by vim-plug and thus don't need to be manually installed.

## Where to put files

**.vimrc**: home directory `~` AKA `/Users/me` on Mac, `/home/me` on Linux
**init.vim**: neovim config directory `~/.config/nvim`
**coc-settings.json**: vim/neovim config directory `~/.vim` for vim, `~/.config/nvim` for neovim
**.tmux.conf**: home directory
**tmuxinator**: config directory `~/.config`

## Initalizing the Environment

Once all the files are in the correct places, open vim and run `:PlugInstall` inside the editor. 

## Command Cheat Sheet

First, I recommend reading through [this resource](https://www.barbarianmeetscoding.com/blog/boost-your-coding-fu-with-vscode-and-vim) as it covers the basics of using vim and most of the widely used commands.

### General
- close current file: `:q`
- close all files: `:qa`
- close file without saving: `:q!`
- close all files without saving: `:qa!`
- save current file: `:w`
- save all files: `:wa`
- save and close all files: `:wqa`

### Editing

- normal mode: `<ctrl>` `c` OR `<esc>`
- edit mode (before cursor): `i`
- edit mode (after cursor): `a`
- edit mode (newline after current line): `o`
- edit mode (newline before current line): `O`
- select mode: `v`
- copy current line: `y` `y`
- delete/cut current line: `d` `d`
- delete/cut and edit current line: `c` `c`
- paste: `p`

### Movement

- move one line/char left, down, up, right -> `h/j/k/l`
- move (num) lines/chars left, down, up, right -> `{num}` `h/j/k/l`
- move to next word (cursor at start of word): `w` 
- move to next word (cursor at end of word): `e` 
- move to previous word (cursor at start of word): `b`
- move to word previous/next set of strings separated by whitespaces: `W`, `E`, `B`
- move to first line in file: `g` `g`
- move to last line in file: `G`

### Combining Editing and Movement

Note: There are some key behaviours that you should know about the commands `w`, `e`, and `b`. The difference between the lower case and upper case command (ie. `w` and `W`) is that the lower case command considers punctuation (ie. ,.'" and more) as a separate word. For example, the command `yiw` while the cursor is on the "o" character of the word "hello,there" will yank the word "hello" but not the rest of the string. However, the command `yiW` will yank the entire "hello,there" string, treating the comma as another character in a whitespace-separated word.

- copy n lines down/up: `y` `{n}` `j/k`
- delete/cut n lines down/up: `d` `{n}` `j/k`
- paste n times: `n` `p`
- copy current word: `y` `i` `w`
- copy current word (ignoring punctuation): `y` `i` `W` (see note for explanation)
- delete current word: `d` `i` `w`
- delete and edit current word: `c` `i` `w`
- copy all contents of a file: `g` `g` `y` `G` (notice how you can combine different movement options to do cool stuff like this...)

### Search

- find word in file: `/{word}` `<enter>`
- navigate between found words: `n` for next occurrence, `N` for previous occurrence
- search and replace {word} in file: `:%s/{word}/{newWord}/g` (optionally, add `c` at the end of the command to confirm each replace action)

### File Navigation

Althrough I personally use the NERDTree and FZF plugins to navigate between files, these commands are still good to know.

- open file (or create new file if it doesn't exist): `:n {file}`
- open file in horizontal split: `:sp {file}`
- open file in vertical split: `:vs {file}`
- open file in new tab: `:tabnew {file}`
- go to previous buffer: `<ctrl>` `o`
- go to next buffer: `<ctrl>` `i`
- go to next tab: `g` `t`
- go to previous tab: `g` `T`
- go to nth tab: `{n}` `g` `t`

### Custom/Plugin Commands

The following commands are NOT default vim commands but rather a list of commands that my installed plugins or I have mapped in the included .vimrc file. I highly recommend that you configure your own mappings to your liking or add mappings to commands that you frequently use.

- open NERDTree: `<ctrl>` `n` or `:NERDTree` (requires NERDTree plugin)
- search files: `<ctrl>` `f` (requires FZF plugin)
- emmet: `,` `,` (requires emmet plugin)
- navigate errors and diagnostics: `]` `g` for next, `[` `g` for previous (requires coc plugin)
- go to code definition: `g` `d` (requires coc plugin)
- go to code implementation: `g` `i` (requires coc plugin)
- go to code references: `g` `r` (requires coc plugin)
- show documentation on hover: `K` (requires coc plugin)
