# Going Merry

![](https://vignette.wikia.nocookie.net/onepiece/images/4/41/Going_Merry_Infobox.png/revision/latest?cb=20121214234157)

新手村啟航的基本配備, 存在 Git 上方便隨時逃難!?

## Setup

```bash
git clone git@github.com:o-p/going-merry.git
cd going-merry

# 這邊看環境有可能是 [.bashrc|.profile]
# 這樣比較方便針對每台機器調整 PATH
echo "source $(pwd -P)/.bashrc" >> ${HOME}/.profile

# ssh 設定
chmod 0700 ~/.ssh
mkdir ~/.ssh/keys
ln -s ssh/gen.sh ~/.ssh/keys/gen.sh
cp ssh/config ~/.ssh/config

# 配置 tmux
ln -s .tmux.conf ~/.tmux.conf

# 配置 vim (完成後 :PlugInstall 安裝 plugins)
curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
ln -s .vimrc ~/.vimrc

git config --global core.hooksPath '~/path/to/going-merry/git-hooks'
```

## vim

- 為了強制養成習慣, 已經關閉方向鍵功能, 目前還保留 `h`, `j`, `k`, `l`
- prefix `,`


## tmux

- 複製到家目錄下, `tmux source-file ~/.tmux.conf` 或者重新連線會自動載入這個版本, 之後都可以用 `r` 重載
- command prefix: `ctrl + a`
- split: `v` & `b`
- 在panes間切換: `h` `j` `k` `l`

## 自行安裝

只紀錄 macOS 的安裝指令, 工作機上自行安裝的機會有限

```bash
# ccat - 帶 syntax highlight 的 cat
$ brew install ccat
# httpie - 易用版 curl
$ brew install httpie
# tdlr - 社群精簡版指令用法
$ npm i -g tdlr
```
