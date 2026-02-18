### Ubuntu setup scripts

Automatically install programs and configure your ubuntu system.

```
ubuntu-utility/
├── main.sh           # runs all scripts below
├── keyboard.sh       # keyboard layouts (console + GNOME)
├── docker.sh         # docker
├── terraform.sh      # terraform
├── apt-apps.sh       # daily apps via apt
├── brave.sh          # brave browser
├── ssh.sh            # ssh config
├── opencode.sh       # opencode CLI
└── dotfiles/         # config files
    └── keyboard.dconf
```

Run `main.sh` on fresh Ubuntu. All scripts safe to re-run.
