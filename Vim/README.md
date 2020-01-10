![Vim](https://www.vim.org/images/vim_header.gif)

1. 安裝 vim-plug:

  ```bash
  $ curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  ```

2. `cd` to this directory where the README is.

3. `echo "source $(realpath rc.vim)" >> ~/.vimrc`

4. link each folder contents to relative ~/.vim/ folders, e.g.

  ```bash
  $ mkdir ~/.vim/colors/ ~/.vim/plugins/
  $ ln -s $(realpath ./colors/monokai.vim) ~/.vim/colors/
  ...
  ```
5. Execute vim and run `:PlugInstall` command

