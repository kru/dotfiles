### How To Use

Pre:
- Install GNU stow
- Install JetBrains Mono Nerd Font (optional)
- Install zsh and oh-my-zsh
- Install tmux
- Install NeoVim

1. Clone repository by the following command

```
git clone git@github.com:kru/dotfiles.git
```

2. Create the symlink using stow to each tools accordingly, for examples:

#### NeoVim
```
stow -t ~/.config/nvim nvim
```

#### Tmux
```
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
tmux source ~/.config/tmux/tmux.conf
```

*NOTE*: Please make sure the path is exist (either create the new path or specify other path)

**DISCLAIMER**

This is personal dev configurations, so use with caution as the workflow between us different
