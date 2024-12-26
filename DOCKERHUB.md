# Ubuntu Jammy + UV Python + NVM + Deno + Bun Base Image

A comprehensive base image built on Ubuntu Jammy (22.04) that provides multiple runtime environments for modern development workflows.

## 🛠️ Included Tools & Runtimes

### Base System

- Ubuntu Jammy (22.04) via `buildpack-deps:jammy`
- Essential build tools and development dependencies

### Node.js

- Node.js v20.18.1 LTS
- NVM (Node Version Manager) v0.39.7
- Latest NPM for Node.js v20.18.1

### Python

- System Python with UV Package Manager
- UV for fast package installation and dependency management
- Clean environment without pre-installed packages

### Deno

- Latest Deno version
- Configured cache directories
- Full TypeScript/JavaScript support

### Bun

- Latest Bun version
- Full JavaScript/TypeScript runtime capabilities

## 📦 Quick Start

```dockerfile
FROM dimasarif/ubuntu-jammy-uvpy-nvm-deno-bun:latest

# Your application setup here
COPY . .
```

## ⚙️ Pre-configured Environment

All necessary environment variables and paths are pre-configured:

- Node.js: `NVM_DIR`, `NODE_VERSION`
- Python: `UV_ROOT`, `UV_BIN`
- Deno: `DENO_INSTALL`, `DENO_DIR`
- Bun: `BUN_INSTALL`

## 🔐 Security & Permissions

- All tools and runtimes accessible to non-root users
- Proper file permissions throughout
- Clean, minimal installation

## 🏷️ Tags

- `latest`: Most recent build with latest Deno and Bun versions
- Node.js is fixed at v20.18.1 LTS for stability

## 📄 License

MIT License
