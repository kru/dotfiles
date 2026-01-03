### How To Use

Pre:
- Install GNU stow
- Install Nerd Font (optional)
- Install zsh
- Install tmux
- Install NeoVim

1. Clone repository by the following command

```
git clone git@github.com:kru/dotfiles.git
```

2. Create the symlink using stow to each tools accordingly, for examples:

#### ZSH
```
mkdir ~/.zsh
touch ~/.zshenv
echo "EXPORT ZSH=~/.zsh" > ~/.zshenv
```

#### NeoVim
```
stow -t ~/.config/nvim nvim
```

*NOTE*: Please make sure the path is exist (either create the new path or specify other path)

**DISCLAIMER**

This is personal dev configurations, so use with caution as the workflow between us different
