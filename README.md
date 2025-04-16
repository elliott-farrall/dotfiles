# DotFiles

This repository contains my dotfiles and configuration files for various applications and systems.

- :bug: [Issues](#bug-issues)
    - :wrench: [Modules (NixOS)](#wrench-modules-(nixos))
    - :page_facing_up: [Overlays](#page_facing_up-overlays)
- :construction: [To Do](#clipboard-todo)
    - :screwdriver: [Modules (Home Manager)](#screwdriver-modules-(home-manager)-1)
    - :wrench: [Modules (NixOS)](#wrench-modules-(nixos)-1)
    - :page_facing_up: [Overlays](#page_facing_up-overlays-1)
    - :desktop_computer: [Systems](#desktop_computer-systems-1)
    - :egg: [Shells](#egg-shells-1)
- :rocket: [CI/CD](#rocket-cicd)

## :bug: Issues

Below are a list of issues that need to be fixed.

### :wrench: Modules (NixOS)

#### **profiles**
- [ ] Update uos printer config

### :page_facing_up: Overlays

#### **rmview**
- [ ] Temporary fix for the rmview package

## :clipboard: To Do

Below are a list of features that need to be added.

### :screwdriver: Modules (Home Manager)

#### **applications**
- [ ] Better handling of unwanted desktop items

#### **desktop**
- [ ] Build AGS widgets
- [ ] Implement dynamic wallpaper
- [ ] Organise hyprland style config

#### **git**
- [ ] Setup signed commits

#### **locker**
- [ ] Better integration of lockers between nixos and home-manager

#### **networking**
- [ ] Integrate ssh with bitwarden

#### **rclone**
- [ ] Use builtin rclone module

#### **shell**
- [ ] Make zsh default shell

#### **xdg**
- [ ] Needs a lot of work

### :wrench: Modules (NixOS)

#### **applications**
- [ ] Better handling of unwanted desktop items

#### **boot**
- [ ] Implement silent boot module

#### **greeter**
- [ ] Is this fix still needed?

#### **locale**
- [ ] Simplify this module

#### **locker**
- [ ] Test systemd-lock-handler

#### **metrics**
- [ ] Migtrate from promtail to grfana-alloy

#### **networking**
- [ ] Automate TailScale tagging

#### **shell**
- [ ] Make zsh default shell

#### **users**
- [ ] Migrate primary user to uid 1001

#### **vfs**
- [ ] Test autotrash

#### **virtualisation**
- [ ] Cleanup automated dockerhub login

### :page_facing_up: Overlays

#### **mathematica**
- [ ] Add WolframScript overlay

#### **renovate**
- [ ] Remove when [PR](https://github.com/renovatebot/renovate/pull/33991) is merged

#### **wpa_supplicant**
- [ ] Is this still needed?

### :desktop_computer: Systems

#### **lima**
- [ ] Cleanup lima networking config
- [ ] Does lima need openrazer?

### :egg: Shells

#### **default**
- [ ] Rebuild devshell

## :rocket: CI/CD

This repository uses GitHub Actions for CI/CD with runners provisoned using [RunsOn](https://runs-on.com).
