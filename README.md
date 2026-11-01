# Canvas

John's DevPod development environment: zsh, Neovim, tmux, code-server, AI tools and
cloud/DevOps tooling in one container, built from DevContainer features.

Canvas started as a fork of [shellinator](https://github.com/nikunh/shellinator) and is
developed here independently.

## Features

- `john` user with zsh and Oh My Zsh
- Development tools and utilities
- AI development tools (aider, tmux-neovim with AI integration)
- Cloud and DevOps tools
- Node.js and Go development environments
- Kubernetes tools

## Usage with DevPod

```bash
# Create and start the environment
devpod up https://github.com/hottahidit/Canvas@john --id canvas

# SSH into the environment
ssh canvas.devpod
```

## SSH Access

SSH runs inside the container on port 2222, published on the host as `127.0.0.1:2224` so it
doesn't clash with a shellinator container on 2223. The `john` user gets the full zsh and
development setup.
