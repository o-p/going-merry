![Vim](https://www.vim.org/images/vim_header.gif)

1. `cd` to this directory where the README is.
2. `echo "source $(realpath rc.vim)" >> ~/.vimrc`
3. link each folder contents to relative ~/.vim/ folders, e.g.

  ```bash
  $ mkdir ~/.vim/colors/ ~/.vim/plugins/
  $ ln -s $(realpath ./colors/monokai.vim) ~/.vim/colors/
  ...
  ```
4. Execute vim and run `:PlugInstall` command

