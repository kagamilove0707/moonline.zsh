#moonline.zsh

__moonline.zsh__ provides a modern prompt for zsh.

and moonline.zsh respects [lightline.vim]'s spirit.

###Image

default color scheme:

![default color scheme](https://raw.github.com/wiki/kagamilove0707/moonline.zsh/images/moonline_default.png)

##Sprit of this script (inspired [lightline.vim])

  * Minimalism. The core script is very small.
  * Configurability. You can create your own component and easily add to the prompt.
  * Orthogonality. Any plugin (framework) should not change the settings of another plugin. Such plugin-crossing settings should be written by users in `.zshrc`

##Author

TSUKIKAGE Osana (<https://github.com/kagamilove0707>)

##License

This software is released under the MIT License, see LICENSE.

##Installation

install with the following commands.

```
git clone https://github.com/kagamilove0707/moonline.zsh.git ~/.moonline
echo "test -f ~/.moonline/moonline.zsh && source ~/.moonline/.moonline.zsh" >> ~/.zshrc
source ~/.zshrc
```

but this is a one example, you should install moonline.vim to your dotfiles directory.

(or you used antigen, append `antigen bundle kagamilove0707/moonline.zsh` to `.zshrc`. however, antigen isn't save my spirit. so, I don't use antigen.)

[lightline.vim]: https://github.com/itchyny/lightline.vim
