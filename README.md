# 🚀 Dotfiles Bootstrap Setup

A modular, cross-platform dotfiles and environment bootstrap system. Designed to be portable, profile-aware, and GitHub-ready — with support for secrets, services, stow, and submodules.

---

## 🧩 Components

| File | Purpose |
|------|---------|
| `bootstrap.sh` | Main launcher: loads platform, secrets, profiles, then runs setup |
| `setup_from_yaml.sh` | Main setup logic using `apps.yaml` definitions |
| `platform.sh` | Detects the OS: macOS, Arch, etc. |
| `installer.sh` | Cross-platform app installer abstraction |
| `secrets.sh` | Loads/decrypts secrets from `secrets.yaml.gpg` and exports to env |
| `profiles.sh` | Prompts user to select from `profiles.yaml`, sets tags |
| `dotfiles.sh` | Unstows old dotfiles, stows from current `$DOTFILES_DIR` |
| `apps.yaml` | Main config file: groups, apps, tags, dotfiles, post-install hooks |
| `profiles.yaml` | List of named profiles and their associated tags |
| `.gitignore` | Prevents committing sensitive files (e.g. secrets) |
| `install.sh` | Remote-install wrapper: clone & run bootstrap |
| `pull.sh` | Pull latest changes from your setup repo |
| `pull-submodules.sh` | Recursively update all Git submodules |
| `convert_submodules.sh` | Interactively convert plugin folders to proper submodules |
| `com.user.dockerlogin.plist` | macOS LaunchAgent to autostart Docker (optional) |

---

## 🛠 Getting Started

```bash
# Clone repo and run
git clone https://github.com/yourname/dotfiles-bootstrap.git ~/setupv2
cd ~/setupv2
./bootstrap.sh
```

Or use curl:
```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/yourname/dotfiles-bootstrap/main/install.sh)"
```

---

## 🔐 Secrets

Store secrets in `secrets.yaml`, like:
```yaml
GITHUB_TOKEN: ghp_abc123
API_KEY: supersecret
```

Encrypt it:
```bash
gpg -o secrets.yaml.gpg -e -r you@example.com secrets.yaml
```

The `secrets.sh` script will load and export these.

---

## 🧑‍💻 Profiles

Use `profiles.yaml` to define tag-based environments like:

```yaml
profiles:
  - name: Work Mac
    tags: [cli,dev,secure]

  - name: Hyprland
    tags: [arch,tiling,dev]
```

The selected profile sets the tag filter for `setup_from_yaml.sh`.

---

## 🧰 Dotfiles

- Place stow-compatible dotfiles in a directory
- Set the path using the `DOTFILES` env var or default to `$HOME/dotfiles`
- Uses `stow` to symlink per-app configurations

---

## 🔄 Git Submodules

Convert plugin folders to submodules:
```bash
./convert_submodules.sh tmux/.config/tmux/plugins
```

Update them all:
```bash
./pull-submodules.sh
```

---

## ✅ Final Thoughts

- Modular and composable
- Tag-aware and profile-based
- Secrets-friendly and OS-aware
- GitHub deployable and CI-ready

This is your plug-and-play dev environment for any Mac, Arch, or Linux system.
