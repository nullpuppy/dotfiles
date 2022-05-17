# dotfiles

A collection of config files and scripts for maintaining a consistent environment between systems. 

This is a work in progress and likely to be restructured a bit soon. Currently uses a couple scripts to pull down the 
git repo (if not already cloned), and link mostly just `~/.config` files.

## features

They're dotfiles. What else is there to say. Configs include vim, nvim, zsh, powerlevel10k, starship, git, etc.
Xmonad and tmux haven't been used recently; current stability of those configs is very much unknown.

## install

```sh
sh -c "$(curl -fsSL https://github.com/nullpuppy/bootstrap)"
```

or
```sh
git clone https://github.com/nullpuppy/dotfiles ~/.dotfiles
cd ~/.dotfiles
sh bootstrap
```

## todo

- [ ] Add `~/.local`
- [ ] Add nvim packages to `~/.local` or figure out alternative way to install
- [ ] Add configuration to bootstrap process to remove any personal info
- [ ] Improve bootstrap process
    - [ ] Easier updating of dependancies/submodules
    - [ ] Improve bootstrapping of new items
    - [ ] Allow for OS-dependant configuration and updates

## bugs

Feel free to file issues if you use this and run into problems.

There might be some issues with linking some things during initial bootstrap.

## thanks

This is inspired by a lot of people, and has pulled configs and ideas from a variety of places. Proper credits TBD

