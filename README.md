# DotFiles

This repository contains my dotfiles and configuration files for various applications and systems.

- :bug: [Issues](#bug-issues)
    - :wrench: [Modules (NixOS)](#wrench-modules-(nixos))
    - :screwdriver: [Modules (Home Manager)](#screwdriver-modules-(home-manager))
- :clipboard: [To Do](#clipboard-todo)
    - :desktop_computer: [Systems](#desktop_computer-systems-1)
    - :house_with_garden: [Homes](#house_with_garden-homes-1)
    - :screwdriver: [Modules (Home Manager)](#screwdriver-modules-(home-manager)-1)
    - :test_tube: [Checks](#test_tube-checks-1)
- :rocket: [CI/CD](#rocket-cicd)

## :bug: Issues

Below are a list of issues that need to be fixed.

### :wrench: Modules (NixOS)

#### **greeter**
- [ ] Incorrect resolutions on multi-monitor setups

### :screwdriver: Modules (Home Manager)

#### **desktop**
- [ ] waybar media module broken
- [ ] waybar systemd module does not work with user units (see https://github.com/Alexays/Waybar/issues/3444)

## :clipboard: To Do

Below are a list of features that need to be added.

### :desktop_computer: Systems

#### **broad**
- [ ] Find better way to read token for ddns

#### **lima**
- [ ] Clean lima boot config

#### **runner**
- [ ] Create lib for random UUIDs

### :house_with_garden: Homes

#### **elliott@lima**
- [ ] Organise tools

### :screwdriver: Modules (Home Manager)

#### **desktop**
- [ ] Build AGS widgets

### :test_tube: Checks

#### **pre-commit**
- [ ] Fix act pre-commit

## :rocket: CI/CD

This repository uses GitHub Actions for CI/CD with runners provisoned using [RunsOn](https://runs-on.com).
