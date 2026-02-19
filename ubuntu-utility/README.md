### Ubuntu setup scripts

Automatically install programs and configure your ubuntu system.

```
ubuntu-utility/
├── main.sh           # runs all scripts below
├── envsetup.sh       # sets DOTFILES environment variable
├── keyboard.sh       # keyboard layouts (console + GNOME)
├── docker.sh         # docker
├── terraform.sh      # terraform
├── apt-apps.sh       # daily apps via apt
├── brave.sh          # brave browser
├── alacritty.sh     # alacritty terminal + dotfiles symlinks
├── ssh.sh            # ssh config
├── opencode.sh       # opencode CLI
└── dotfiles/         # config files (symlinked to ~/.config)
    ├── keyboard.dconf
    └── alacritty/
        ├── alacritty.toml    # uses DOTFILES env var
        └── themes/
            └── catppuccin-frappe.toml
```

Run `main.sh` on fresh Ubuntu. All scripts safe to re-run.

**Alacritty setup:**
- First run: `./alacritty.sh` - installs alacritty, creates symlinks, updates config with absolute paths
- Re-run: Updates paths automatically if repo was moved
