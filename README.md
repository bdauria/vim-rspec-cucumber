# rspec-cucumber.vim

This is a lightweight RSpec / Cucumber runner for Vim and MacVim.
This is based off the original vim-rspec by thoughtbot:
[vim-rspec](https://github.com/thoughtbot/vim-rspec)
and forked from Michael Deol's [vim-rspec-cucumber] (https://github.com/michaeldeol/vim-rspec-cucumber)

## Installation

Recommended installation with [vundle](https://github.com/gmarik/vundle):

```vim
Plugin 'bdauria/vim-rspec-cucumber'
```

If using zsh on OS X it may be necessary to move `/etc/zshenv` to `/etc/zshrc`.

## Configuration

### Key mappings

Add your preferred key mappings to your `.vimrc` file.

```vim
" rspec-cucumber.vim mappings
map <Leader>t :call RunCurrentTestFile()<CR>
map <Leader>s :call RunNearestTest()<CR>
map <Leader>l :call RunLastTest()<CR>
map <Leader>a :call RunAllTests()<CR>
```

### Custom commands
You can define custom commands for both RSpec and Cucumber, for instance:

" vim-rspec-cucumber custom commands
let g:rspec_command = "Dispatch rspec {test}"
let g:cucumber_command = "Dispatch bundle exec cucumber {test}"


### Custom runners

Overwrite the `g:test_runner` variable to set a custom launch script. At the
moment there are two MacVim-specific runners, i.e. `os_x_terminal` and
`os_x_iterm`. The default is `os_x_terminal`, but you can set this to anything
you want, provided you include the appropriate script inside the plugin's
`bin/` directory.

#### iTerm instead of Terminal

If you use iTerm, you can set `g:test_runner` to use the included iterm
launching script. This will run the specs in the last session of the current
terminal.

```vim
let g:test_runner = "os_x_iterm"
```

Credits
-------

![thoughtbot](http://thoughtbot.com/images/tm/logo.png)

The original rspec.vim is maintained by [thoughtbot, inc](http://thoughtbot.com/community)
and [contributors](https://github.com/thoughtbot/vim-rspec/graphs/contributors)
like you. Thank you!

It was strongly influenced by Gary Bernhardt's [Destroy All
Software](https://www.destroyallsoftware.com/screencasts) screencasts.

Updated by Michael Deol to accomodate both RSpec and Cucumber tests.

## License

rspec-cucumber.vim is copyright © 2014 Michael Deol. It is free software, and may be
redistributed under the terms specified in the `LICENSE` file.

The names and logos for thoughtbot are trademarks of thoughtbot, inc.
