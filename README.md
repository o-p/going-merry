# Going Merry

![](https://vignette.wikia.nocookie.net/onepiece/images/4/41/Going_Merry_Infobox.png/revision/latest?cb=20121214234157)

新手村啟航的基本配備, 存在 Git 上方便隨時逃難!?

## Setup

```bash
git clone git@github.com:o-p/going-merry.git
cd going-merry

# ssh 設定
chmod 0700 ~/.ssh
mkdir ~/.ssh/keys
ln -s ssh/gen.sh ~/.ssh/keys/gen.sh
cp ssh/config ~/.ssh/config

# 配置 tmux
ln -s $(realpath ./tmux/tmux.conf) ~/.tmux.conf
```

## tmux

- 複製到家目錄下, `tmux source-file ~/.tmux.conf` 或者重新連線會自動載入這個版本, 之後都可以用 `r` 重載
- command prefix: `ctrl + <space>`
- split: `v` & `b`
- 在panes間切換: `h` `j` `k` `l`

## 自行安裝

只紀錄 macOS 的安裝指令, 工作機上自行安裝的機會有限

```bash
# ccat - 帶 syntax highlight 的 cat
$ brew install ccat
# httpie - 易用版 curl
$ brew install httpie
# tldr - 社群精簡版指令用法 (使用 pip3 安裝到 ~/.local/bin 避免 npm 會隨著 nvm 切版本跑掉)
$ pip3 install tldr
```
