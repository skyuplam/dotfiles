# dotfiles
My Personal dotfiles .:.

## Manage dotfiles

I use [stow](https://www.gnu.org/software/stow/) to manage my dotfiles.

Here is an example:

By organizing the folder structure as the following.

```sh
dotfiles
├──vim/
├──tmux/
...
```

To install my vim config, simply run the command `stow vim` under the `dotfiles`
folder. `stow` will symbolic link the content under `vim` folder to your home
dir.


## Private files

`fishshell`: run `touch ~/.local.fish` to create an empty local fish config to store all
your private stuff, e.g. `API_KEY`, `PRIVATE_TOKEN`, etc.
