# A Personal Emacs config

This configuration forked from [Steve Purcell](https://github.com/purcell/emacs.d).

Emacs itself comes with support for many programming languages. This
config adds improved defaults and extended support for the following, listed
in the approximate order of how much I use them, from most to least:

* Haskell / Purescript / Elm
* Ruby / Ruby on Rails
* CSS / LESS / SASS / SCSS
* Javascript / Typescript / Coffeescript
* HTML / HAML / Markdown / Textile / ERB
* Rust
* Python
* Clojure (with Cider and nRepl)
* Common Lisp (with Slime)
* PHP
* Erlang

In particular, there's a nice config for *autocompletion* with
[TabNine](https://tabnine.com/) TabNine uses deep learning to help you write code faster.

## Screenshots

![demo.png](https://i.loli.net/2019/11/29/JZqBvFGQDbRYT1w.png)


## Supported Emacs versions

The config should run on Emacs 25 or greater

## Installation

To install, clone this repo to `~/.emacs.d`, i.e. ensure that the
`init.el` contained in this repo ends up at `~/.emacs.d/init.el`:

```
git clone https://github.com/EdmondFrank/.emacs.d ~/.emacs.d
```

Upon starting up Emacs for the first time, further third-party
packages will be automatically downloaded and installed. If you
encounter any errors at that stage, try restarting Emacs, and possibly
running `M-x package-refresh-contents` before doing so.
