# .dotfiles
dot files 

# NixOS
trying some things with nixos

import the files like this:
```
imports = [
  ./tmux
  ./nvim
]
```

since these are directories the `default.nix` should get picked up
