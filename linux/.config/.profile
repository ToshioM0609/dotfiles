#!/usr/bin/env bash
#
# @(#) : .profile main
#
# @version  1.0.2
# @author   Furukawa, Atsushi <atsushifx@aglabo.com>
# @date     2022-08-16
# @license  MIT
#
# @description
# ~/.config/.profile: command interpreter main for login shells.
# exec utilties settings & path  
#

# ~/.profile: executed by the command interpreter for login shells.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
umask 022

echo "Exec .config/.profile"

# // functions
isInteractive() {
  case $- in
    *i*) return 1;;
      *) return 0;;
  esac
  return 1;
}


##  common environ settings
if [ -n "$HOME/.config/.common.env" ]; then
  . "$HOME/.config/.common.env"
fi
export PATH

# in zsh this is called by zshenv

# if running bash
if [ -n "$BASH_VERSION" ]; then
  # include .bashrc if it exists
  if [ -f "$HOME/.bashrc" ]; then
    . "$HOME/.bashrc"
  fi

  # user defined bashrc
  if [[ isInteractive ]] && [[ -f ${HOME}/.config/bash/bashrc ]]; then
    . ${HOME}/.config/bash/bashrc
  fi
fi

# rbenv eval
# eval "$(rbenv init -)"

# opam configuration
# test -r /home/atsushifx/.opam/opam-init/init.sh && . /home/atsushifx/.opam/opam-init/init.sh > /dev/null 2> /dev/null || true