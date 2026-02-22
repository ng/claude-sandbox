# claude-sandbox

Run [Claude Code](https://docs.anthropic.com/en/docs/claude-code) in an isolated Docker container from any project directory.

## Why?

Claude Code with `--dangerously-skip-permissions` is powerful but risky — it can execute arbitrary commands on your machine. Running it inside a container gives you the same capabilities with full isolation: if Claude decides to `rm -rf /` or install something unexpected, it only affects the disposable container.

The sandbox also provides a consistent environment across machines — same tools, same MCP servers, same config — without polluting your host system.

## What's included

- **Claude Code** with [Serena](https://github.com/oraios/serena) and [MUI MCP](https://github.com/mui/mui-mcp) servers pre-configured
- **Node.js 24**, Python 3, git, tmux, curl
- **[uv](https://github.com/astral-sh/uv)** for fast Python tooling
- **AWS Bedrock** authentication via bearer token

## Setup

```bash
git clone https://github.com/yourusername/claude-sandbox.git
cd claude-sandbox
./install
source ~/.zshrc  # or open a new terminal
```

This builds the Docker image, creates a `.env` from `.env.example`, and adds a `claude-sandbox` shell function to your shell config. Edit `.env` with your credentials before first use.

## Usage

```bash
cd /path/to/any/project
claude-sandbox
```

Your current directory is mounted into the container at `/workspaces/project`. Claude Code starts with full permissions inside the container, but your host system remains untouched.

You can also pass arguments through to Claude Code:

```bash
claude-sandbox --model opus
```

## Configuration

### MCP servers

Edit `claude.json` to add or remove MCP servers, then rebuild:

```bash
docker compose build
```

### Environment variables

Edit `.env` in the repo root (created from `.env.example` on install):

| Variable | Default | Description |
|---|---|---|
| `AWS_BEARER_TOKEN_BEDROCK` | — | Bearer token for Bedrock auth |
| `AWS_REGION` | `us-east-1` | AWS region |
| `CLAUDE_CODE_USE_BEDROCK` | `1` | Enable Bedrock provider |
| `CLAUDE_CODE_EXPERIMENTAL_AGENT_TEAMS` | `1` | Enable agent teams |
