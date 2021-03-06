# A Personal Emacs config

This configuration forked from [Steve Purcell](https://github.com/purcell/emacs.d).

Emacs itself comes with support for many programming languages. This
config adds improved defaults and extended support for the following, listed
in the approximate order of how much I use them, from most to least:

* Haskell / Purescript / Elm / OCaml
* Ruby / Ruby on Rails
* SQL
* CSS / LESS / SASS / SCSS
* Javascript / Typescript / Coffeescript
* HTML / HAML / Markdown / Textile / ERB
* Common Lisp (with Slime)
* Python
* Rust
* Clojure (with Cider and nRepl)
* PHP
* Erlang

In particular, there's a nice config for *autocompletion* with
[TabNine](https://tabnine.com/) TabNine uses deep learning to help you write code faster.

## Screenshots

![demo.png](https://i.loli.net/2019/11/29/JZqBvFGQDbRYT1w.png)
The config should run on Emacs 25.1 or greater and is designed to
degrade smoothly - see the CI build - but note that much newer
versions are required for an increasing number of key packages, so to
get full functionality you should use the latest Emacs version
available to you.


## Supported Emacs versions

The config should run on Emacs 25 or greater

## Installation

To install, clone this repo to `~/.emacs.d`, i.e. ensure that the
`init.el` contained in this repo ends up at `~/.emacs.d/init.el`:

```
git clone https://github.com/EdmondFrank/.emacs.d.git ~/.emacs.d
```

Upon starting up Emacs for the first time, further third-party
packages will be automatically downloaded and installed. If you
encounter any errors at that stage, try restarting Emacs, and possibly
running `M-x package-refresh-contents` before doing so.
