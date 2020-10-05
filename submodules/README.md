# Submodules

```bash
# For the first time installation
$ git submodule update --init --recursive

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

