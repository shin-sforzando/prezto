# Setup MacOS using Prezto

Prezto is the configuration framework for [Zsh][1]; it enriches the command line interface environment with sane defaults, aliases, functions, auto completion and prompt themes.

- [Installation](#Installation)
  - [1. Install Homebrew](#1-Install-Homebrew)
  - [2. Install Zsh](#2-Install-Zsh)
  - [3. Launch Zsh:](#3-Launch-Zsh)
  - [4. Clone the repository:](#4-Clone-the-repository)
  - [5. Create a new Zsh configuration by copying the Zsh configuration files provided:](#5-Create-a-new-Zsh-configuration-by-copying-the-Zsh-configuration-files-provided)
  - [6. Create symbolic links from `dot_files`:](#6-Create-symbolic-links-from-dotfiles)
  - [7. Create `.config`](#7-Create-config)
  - [8. Set Zsh as your default shell:](#8-Set-Zsh-as-your-default-shell)
  - [9. Install packages from Homebrew](#9-Install-packages-from-Homebrew)
  - [10. Run setup script](#10-Run-setup-script)
- [Troubleshooting](#Troubleshooting)
- [Updating](#Updating)
  - [Follow Upstream Repository](#Follow-Upstream-Repository)
- [Usage](#Usage)
  - [Modules](#Modules)
  - [Themes](#Themes)
  - [External Modules](#External-Modules)
- [Customization](#Customization)
- [Misc.](#Misc)
  - [Resources](#Resources)
  - [License](#License)

## Installation

### 1. Install Homebrew

```console
$ /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
```

### 2. Install Zsh

```console
$ brew install zsh
```

### 3. Launch Zsh:

```console
$ /usr/local/bin/zsh
```

### 4. Clone the repository:

```console
$ git clone --recursive https://github.com/shin-sforzando/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"
```

### 5. Create a new Zsh configuration by copying the Zsh configuration files provided:

```console
$ setopt EXTENDED_GLOB
  for rcfile in "${ZDOTDIR:-$HOME}"/.zprezto/runcoms/^README.md(.N); do
    ln -s "$rcfile" "${ZDOTDIR:-$HOME}/.${rcfile:t}"
  done
```

     Note: If you already have any of the given configuration files, `ln` will
     cause error. In simple cases you can load prezto by adding the line
     `source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"` to the bottom of your
     `.zshrc` and keep the rest of your Zsh configuration intact. For more
     complicated setups, it is recommended that you back up your original
     configs and replace them with the provided prezto runcoms.

### 6. Create symbolic links from `dot_files`:

```console
$ setopt EXTENDED_GLOB
  for dotfile in "${ZDOTDIR:-$HOME}"/.zprezto/dot_files/^README.md(.N); do
    ln -s "$dotfile" "${ZDOTDIR:-$HOME}/.${dotfile:t}"
  done
```

### 7. Create `.config`

```console
$ mkdir .config
$ setopt EXTENDED_GLOB
  for dotdir in "${ZDOTDIR:-$HOME}"/.zprezto/dot_config_dir/*; do
    ln -s "$dotdir" "${ZDOTDIR:-$HOME}/.config/${dotdir:t}"
  done
```

### 8. Set Zsh as your default shell:

```console
$ chsh -s /usr/local/bin/zsh
```

### 9.  Install packages from Homebrew

```console
$ brew bundle
```

### 10. Run setup script

```console
$ ./setup.sh
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
git submodule update --init --recursive
```

### Follow Upstream Repository

```console
$ git remote add upstream https://github.com/sorin-ionescu/prezto.git
$ git fetch upstream
$ git merge upstream/master
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
     Note that the 'git' module may be required for special symbols to appear,
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

## Misc.
### Resources

The [Zsh Reference Card][7] and the [zsh-lovers][8] man page are indispensable.

### License

This project is licensed under the MIT License.

[1]: http://www.zsh.org
[2]: http://i.imgur.com/nrGV6pg.png "sorin theme"
[3]: http://git-scm.com
[4]: https://github.com
[5]: http://gitimmersion.com
[6]: https://git.github.io/git-reference/
[7]: http://www.bash2zsh.com/zsh_refcard/refcard.pdf
[8]: http://grml.org/zsh/zsh-lovers.html
