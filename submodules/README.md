# Submodules

```bash
$ git submodule init
$ git submodule update
$ git submodule sync
```

## Build Universal CTags

Linux

```bash
$ ./autogen.sh
$ ./configure --prefix=$(realpath ~)
$ make
$ make install
```

MacOS

```bash
$ brew tap universal-ctags/universal-ctags
$ brew install --HEAD universal-ctags
```

