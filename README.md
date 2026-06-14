# Config files for zsh, vim, and more

Quick setup for basic development environment.

Installs the following by default:

- zsh
- oh-mh-zsh
- powerlevel10k
- asdf
- uv

To install and setup environment:

1. Run the following:

```sh
git clone https://github.com/rossketron/dotfiles.git
cd dotfiles
bash install.sh
```

1. After the `install.sh` script is done, you will need to open the four 'MesloNF' `.ttf` font files from a file browser and click install.
2. Open your terminal settings and change the terminal font to MesloNF 'Regular'.
3. Source zsh with the following command: `zsh`
4. (Optional) Change your default/login shell to zsh: `sudo chsh -s $(which zsh)`
