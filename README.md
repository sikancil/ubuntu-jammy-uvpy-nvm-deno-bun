# 🚀 Ubuntu Jammy + UV Python + NVM + Deno + Bun

A supercharged Ubuntu Jammy (22.04 LTS) Docker image packed with modern development tools! Perfect for polyglot development environments and CI/CD pipelines.

[![Docker Hub](https://img.shields.io/docker/pulls/dimasarif/ubuntu-jammy-uvpy-nvm-deno-bun.svg)](https://hub.docker.com/r/dimasarif/ubuntu-jammy-uvpy-nvm-deno-bun)
[![Docker Image Size](https://img.shields.io/docker/image-size/dimasarif/ubuntu-jammy-uvpy-nvm-deno-bun/latest)](https://hub.docker.com/r/dimasarif/ubuntu-jammy-uvpy-nvm-deno-bun)
[![Ubuntu Version](https://img.shields.io/badge/Ubuntu-22.04%20LTS-orange)](https://ubuntu.com/)

## 🎯 Features

This image comes pre-installed with:

- 🐍 **UV** - Modern Python package installer and resolver
- 📦 **NVM** - Node Version Manager with Node.js v20.18.1 LTS
- 🦕 **Deno** - A secure runtime for JavaScript and TypeScript
- 🥟 **Bun** - All-in-one JavaScript runtime & toolkit

## 🛠️ Pre-installed Versions

```bash
Node.js: v20.18.1 (LTS)
NPM: Latest compatible version
UV: Latest version
Python: Latest version
Deno: Latest version
Bun: Latest version
```

## 🚀 Quick Start

### Pull the Image

```bash
docker pull dimasarif/ubuntu-jammy-uvpy-nvm-deno-bun
```

### Run a Container

```bash
docker run -it dimasarif/ubuntu-jammy-uvpy-nvm-deno-bun bash
```

### Verify Installations

Once inside the container, you can verify the installations:

```bash
# Node.js & npm
node --version
npm --version

# UV & Python
uv --version
python3 --version

# Deno
deno --version

# Bun
bun --version
```

## 🔧 Environment Variables

The image comes with pre-configured environment variables:

```bash
# NVM Configuration
NVM_DIR=/root/.nvm
NODE_VERSION=20.18.1

# UV Configuration
UV_ROOT=/root/.local
UV_BIN=/root/.local/bin/uv

# Deno Configuration
DENO_INSTALL=/root/.deno
DENO_DIR=/root/.cache/deno

# Bun Configuration
BUN_INSTALL=/root/.bun
```

## 🔨 Building from Source

If you want to build the image locally:

```bash
git clone https://github.com/sikancil/ubuntu-jammy-uvpy-nvm-deno-bun.git
cd ubuntu-jammy-uvpy-nvm-deno-bun
docker build -t ubuntu-jammy-uvpy-nvm-deno-bun .
```

## 🤝 Contributing

Contributions are welcome! Feel free to:

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## 📝 License

This project is licensed under the MIT License - see the LICENSE file for details.

## 🌟 Support

If you find this image useful, please consider giving it a star on GitHub and Docker Hub!

- [GitHub Repository](https://github.com/sikancil/ubuntu-jammy-uvpy-nvm-deno-bun)
- [Docker Hub](https://hub.docker.com/r/dimasarif/ubuntu-jammy-uvpy-nvm-deno-bun)
