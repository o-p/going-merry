## Setup

```bash
$ cp config ~/.gitconfig

# creat a directory for Git global hooks
$ mkdir -p ~/.git-share/hooks
$ git config --global core.hooksPath $_

# link wanted hooks
$ ln -s hooks/post-commit ~/.git-share/hooks/post-commit
```

