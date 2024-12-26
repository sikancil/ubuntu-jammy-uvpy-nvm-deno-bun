FROM buildpack-deps:jammy

# Set environment variables
ENV DEBIAN_FRONTEND=noninteractive

# Install NVM and Node.js v20.18.1 LTS
ENV NVM_DIR="/root/.nvm"
ENV NODE_VERSION=20.18.1

RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash && \
    echo '. "$NVM_DIR/nvm.sh"' >> /root/.bashrc && \
    echo '. "$NVM_DIR/bash_completion"' >> /root/.bashrc && \
    . "$NVM_DIR/nvm.sh" && \
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" && \
    nvm install $NODE_VERSION --lts && \
    nvm use $NODE_VERSION && \
    nvm alias default $NODE_VERSION && \
    # Grant permissions to non-root user
    chmod -R 777 "$NVM_DIR" && \
    find "$NVM_DIR" -type d -exec chmod 777 {} \; && \
    find "$NVM_DIR" -type f -exec chmod 666 {} \; && \
    find "$NVM_DIR/versions" -type f -name "node" -exec chmod 777 {} \; && \
    find "$NVM_DIR/versions" -type f -name "npm" -exec chmod 777 {} \; && \
    find "$NVM_DIR/versions" -type f -name "npx" -exec chmod 777 {} \; && \
    # Ensure npm binaries and cache are accessible
    mkdir -p /root/.npm && \
    chmod -R 777 /root/.npm && \
    chmod -R 777 "$NVM_DIR/versions/node/v$NODE_VERSION/bin" && \
    chmod 777 "$NVM_DIR/versions/node/v$NODE_VERSION/bin/npm" && \
    chmod 777 "$NVM_DIR/versions/node/v$NODE_VERSION/bin/npx"

# Add NVM and Node.js to PATH
ENV PATH="/root/.nvm/versions/node/v$NODE_VERSION/bin:$PATH"

# Install UV for Python package management
ENV UV_ROOT=/root/.local \
    UV_BIN=/root/.local/bin/uv

RUN set -ex && \
    # Install UV
    curl -fsSL https://astral.sh/uv/install.sh | sh && \
    # Add UV to environment
    echo "export UV_ROOT=$UV_ROOT" >> /root/.bashrc && \
    echo "export UV_BIN=$UV_BIN" >> /root/.bashrc && \
    echo "export PATH=$UV_ROOT/bin:$PATH" >> /root/.bashrc && \
    # Clean up
    rm -rf /root/.cache/uv/* /root/.cache/pip/* && \
    # Grant permissions to non-root user
    chmod -R 755 "$UV_ROOT" && \
    find "$UV_ROOT" -type d -exec chmod 777 {} \; && \
    find "$UV_ROOT" -type f -exec chmod 666 {} \; && \
    find "$UV_ROOT" -type f -name "uv" -exec chmod 777 {} \;

# Add UV to PATH
ENV PATH="$UV_ROOT/bin:$PATH"

# Install Deno (latest version)
ENV DENO_INSTALL=/root/.deno \
    DENO_DIR=/root/.cache/deno
RUN set -ex && \
    # Create cache directory with proper permissions
    mkdir -p /root/.cache/deno && \
    chmod -R 777 /root/.cache && \
    # Install latest Deno version
    curl -fsSL https://deno.land/install.sh | sh && \
    # Add Deno to PATH and set cache dir
    echo "export DENO_INSTALL=$DENO_INSTALL" >> /root/.bashrc && \
    echo "export DENO_DIR=$DENO_DIR" >> /root/.bashrc && \
    echo "export PATH=$DENO_INSTALL/bin:$PATH" >> /root/.bashrc && \
    # Grant permissions to non-root user
    chmod -R 777 "$DENO_INSTALL" && \
    chmod -R 777 "$DENO_DIR" && \
    find "$DENO_INSTALL" -type d -exec chmod 777 {} \; && \
    find "$DENO_INSTALL" -type f -exec chmod 666 {} \; && \
    find "$DENO_INSTALL" -type f -name "deno" -exec chmod 777 {} \;

# Add Deno to PATH
ENV PATH="$DENO_INSTALL/bin:$PATH"

# Install Bun (latest version)
ENV BUN_INSTALL=/root/.bun
RUN set -ex && \
    # Install Bun using official command
    curl -fsSL https://bun.sh/install | bash && \
    # Add Bun to PATH
    echo "export BUN_INSTALL=$BUN_INSTALL" >> /root/.bashrc && \
    echo "export PATH=$BUN_INSTALL/bin:$PATH" >> /root/.bashrc && \
    # Grant permissions to non-root user
    chmod -R 777 "$BUN_INSTALL" && \
    find "$BUN_INSTALL" -type d -exec chmod 777 {} \; && \
    find "$BUN_INSTALL" -type f -exec chmod 666 {} \; && \
    find "$BUN_INSTALL/bin" -type f -name "bun" -exec chmod 777 {} \;

# Add Bun to PATH
ENV PATH="$BUN_INSTALL/bin:$PATH"

# Set working directory
WORKDIR /root

# Verify all installations
RUN set -ex && \
    echo "Verifying installations:" && \
    . "$NVM_DIR/nvm.sh" && \
    echo "Node.js $(node --version)" && \
    echo "NPM $(npm --version)" && \
    echo "UV $($UV_BIN --version)" && \
    echo "Python $(python3 --version)" && \
    echo "Deno $($DENO_INSTALL/bin/deno --version)" && \
    echo "Bun $(bun --version)"
