# Setup MacOS using Prezto

Prezto is the configuration framework for [Zsh][1]; it enriches the command line interface environment with sane defaults, aliases, functions, auto completion and prompt themes.

- [Installation](#installation)
  - [1. Install Homebrew](#1-install-homebrew)
  - [2. Install Zsh](#2-install-zsh)
  - [3. Launch Zsh](#3-launch-zsh)
    - [for Intel Mac](#for-intel-mac)
    - [for M1 Mac](#for-m1-mac)
  - [4. Clone the repository](#4-clone-the-repository)
  - [5. Run setup script](#5-run-setup-script)
- [Troubleshooting](#troubleshooting)
- [Updating](#updating)
  - [Follow Upstream Repository](#follow-upstream-repository)
- [Usage](#usage)
  - [Modules](#modules)
  - [Themes](#themes)
  - [External Modules](#external-modules)
- [Customization](#customization)
- [Misc](#misc)
  - [Resources](#resources)
  - [License](#license)

## Installation

### 1. Install Homebrew

```console
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

### 2. Install Zsh

```console
brew install zsh
```

### 3. Launch Zsh

#### for Intel Mac

```console
/usr/local/bin/zsh
```

#### for M1 Mac

```console
/opt/homebrew/bin/zsh
```

### 4. Clone the repository

Make sure `$XDG_CONFIG_HOME` and `$ZDOTDIR`.

```console
git clone --recursive https://github.com/shin-sforzando/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"
```

### 5. Run setup script

```console
./.zprezto/setup_01.zsh
./.zprezto/setup_02.zsh
```

## Troubleshooting

If you are not able to find certain commands after switching to *Prezto*, modify the `PATH` variable in *~/.zprofile* then open a new Zsh terminal window or tab.

## Updating

Run `zprezto-update` to automatically check if there is an update to zprezto.
If there are no file conflicts, zprezto and its submodules will be automatically updated. If there are conflicts you will instructed to go into the `$ZPREZTODIR` directory and resolve them yourself.

To pull the latest changes and update submodules manually:

```console
cd $ZPREZTODIR
git pull
git submodule sync --recursive
git submodule update --init --recursive
```

### Follow Upstream Repository

```console
git remote add upstream https://github.com/sorin-ionescu/prezto.git
git fetch upstream
git merge upstream/master
git submodule update --init --recursive
```

## Usage

Prezto has many features disabled by default. Read the source code and accompanying README files to learn of what is available.

### Modules

1. Browse */modules* to see what is available.
2. Load the modules you need in *~/.zpreztorc* then open a new Zsh terminal window or tab.

### Themes

1. For a list of themes, type `prompt -l`.
2. To preview a theme, type `prompt -p name`.
3. Load the theme you like in *~/.zpreztorc* then open a new Zsh terminal window or tab.

  ![sorin theme][2]
  Note that the `git` module may be required for special symbols to appear,
  such as those on the right of the above image. Add `'git'` to the `pmodule`
  list (under `zstyle ':prezto:load' pmodule \` in your *~/.zpreztorc*) to
  enable this module.

### External Modules

1. By default modules will be loaded from */modules* and */contrib*.
2. Additional module directories can be added to the
  `:prezto:load:pmodule-dirs` setting in *~/.zpreztorc*.
  Note that module names need to be unique or they will cause an error when loading.

  ```sh
  zstyle ':prezto:load' pmodule-dirs $HOME/.zprezto-contrib
  ```

## Customization

The project is managed via [Git][3].
It is highly recommended that you fork this project; so, that you can commit your changes and push them to [GitHub][4] to not lose them. If you do not know how to use Git, follow this [tutorial][5] and bookmark this [reference][6].

## Misc

### Resources

The [Zsh Reference Card][7] and the [zsh-lovers][8] man page are indispensable.

### License

This project is licensed under the MIT License.

[1]: https://www.zsh.org
[2]: https://i.imgur.com/nrGV6pg.png "sorin theme"
[3]: https://git-scm.com
[4]: https://github.com
[5]: https://gitimmersion.com
[6]: https://git.github.io/git-reference/
[7]: http://www.bash2zsh.com/zsh_refcard/refcard.pdf
[8]: https://grml.org/zsh/zsh-lovers.html
[9]: modules#readme
[10]: runcoms#readme
[11]: modules/git#readme
