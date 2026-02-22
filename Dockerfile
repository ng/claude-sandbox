FROM node:24-slim

# 1. Install system dependencies (as root)
RUN apt-get update && apt-get install -y \
  tmux curl git python3 python3-pip sudo \
  && rm -rf /var/lib/apt/lists/*

# 2. Install 'uv' for uvx (as root)
COPY --from=ghcr.io/astral-sh/uv:latest /uv /uvx /usr/bin/

# 3. Install Claude Code globally (as root)
RUN npm install -g @anthropic-ai/claude-code

# 4. Set up the 'node' user with sudo access
RUN echo "node ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

# 5. Switch to node user for config and app execution
USER node
WORKDIR /workspaces/project

# 6. Pre-configure MCP servers in the node user's home
RUN mkdir -p /home/node/.claude
COPY --chown=node:node claude.json /home/node/.claude.json

CMD ["bash"]
