# DotFiles

This repository contains my dotfiles and configuration files for various applications and systems.

- :bug: [Issues](#bug-issues)
    - :screwdriver: [Modules (Home Manager)](#screwdriver-modules-(home-manager))
    - :wrench: [Modules (NixOS)](#wrench-modules-(nixos))
    - :page_facing_up: [Overlays](#page_facing_up-overlays)
- :construction: [To Do](#clipboard-todo)
    - :test_tube: [Checks](#test_tube-checks-1)
    - :screwdriver: [Modules (Home Manager)](#screwdriver-modules-(home-manager)-1)
    - :wrench: [Modules (NixOS)](#wrench-modules-(nixos)-1)
    - :page_facing_up: [Overlays](#page_facing_up-overlays-1)
    - :desktop_computer: [Systems](#desktop_computer-systems-1)
- :rocket: [CI/CD](#rocket-cicd)

## :bug: Issues

Below are a list of issues that need to be fixed.

### :screwdriver: Modules (Home Manager)

#### **desktop**
- [ ] Waybar media module broken
- [ ] Waybar systemd module does not work with user units (see https://github.com/Alexays/Waybar/issues/3444)

### :wrench: Modules (NixOS)

#### **greeter**
- [ ] Incorrect resolutions on multi-monitor setups

#### **profiles**
- [ ] Update uos printer config

### :page_facing_up: Overlays

#### **rmview**
- [ ] Temporary fix for the rmview package

## :clipboard: To Do

Below are a list of features that need to be added.

### :test_tube: Checks

#### **pre-commit**
- [ ] Fix act pre-commit

### :screwdriver: Modules (Home Manager)

#### **applications**
- [ ] Better handling of unwanted desktop items

#### **desktop**
- [ ] Build AGS widgets
- [ ] Implement dynamic wallpaper
- [ ] Organise hyprland style config

#### **git**
- [ ] Setup signed commits

#### **networking**
- [ ] Integrate ssh with bitwarden

#### **xdg**
- [ ] Needs a lot of work

### :wrench: Modules (NixOS)

#### **applications**
- [ ] Better handling of unwanted desktop items

#### **greeter**
- [ ] Is this fix still needed?

#### **home-manager**
- [ ] Look into alternative to path link

#### **locale**
- [ ] Simplify this module

#### **metrics**
- [ ] Migtrate from promtail to grfana-alloy

#### **networking**
- [ ] Automate TailScale tagging

#### **nix**
- [ ] Come up with better auto update solution

#### **users**
- [ ] Implement fix for updating /etc/shadow
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

#### **broad**
- [ ] Find better way to read token for ddns

#### **lima**
- [ ] Clean lima boot config
- [ ] Cleanup lima networking config
- [ ] Does lima need openrazer?
- [ ] Migrate lima to impermanence + nixos-facter

#### **runner**
- [ ] Create lib for random UUIDs
- [ ] Remove custom grafana-to-ntfy module once merged upstream

## :rocket: CI/CD

This repository uses GitHub Actions for CI/CD with runners provisoned using [RunsOn](https://runs-on.com).
