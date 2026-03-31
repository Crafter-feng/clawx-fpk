# ClawX FPK for 飞牛 fnOS

> 将 [ClawX](https://github.com/ValueCell-ai/ClawX)（OpenClaw 桌面客户端）打包为飞牛 fnOS 原生 FPK 应用，浏览器直接访问，无需端口代理。

## 功能特性

- ✅ 浏览器原生访问，不跳转外部网页
- ✅ 自动启动 OpenClaw Gateway
- ✅ 内置轻量 Web 服务器（Python）
- ✅ 支持 amd64 / arm64 双架构
- ✅ 一键安装 / 卸载

## 快速开始

### 方式一：下载现成 FPK（推荐）

进入 [Releases](https://github.com/YOUR_USERNAME/clawx-fpk/releases) 页面，下载对应架构的 `.fpk` 文件：

| 文件 | 架构 | 适用 NAS |
|------|------|----------|
| `clawx-amd64-X.X.X.fpk` | x86_64 | Intel/AMD CPU NAS |
| `clawx-arm64-X.X.X.fpk` | ARM64 | 树莓派 / ARM NAS |

上传到飞牛 NAS → 应用中心 → 从文件安装 → 完成 ✅

### 方式二：自行构建

```bash
# 1. Fork 本仓库

# 2. 触发 Actions
#    GitHub Actions 页面 → Build ClawX FPK → Run workflow

# 3. 等待构建完成，在 Artifacts 下载 .fpk 文件
```

## 访问方式

安装完成后，桌面会出现 ClawX 图标，点击直接用浏览器打开：

```
http://localhost:5173
```

或在同一网络下用 NAS IP 访问：
```
http://<NAS_IP>:5173
```

## 技术架构

```
ClawX.fpk/
├── fnpack.json              ← FPK 清单文件
├── install.sh              ← 安装脚本
├── uninstall.sh            ← 卸载脚本
└── data/
    ├── dist/                ← ClawX React 前端静态文件
    ├── openclaw_core/       ← OpenClaw Core 运行时
    ├── config/              ← OpenClaw 配置文件
    └── scripts/
        ├── start.sh         ← 启动脚本（Gateway + Web）
        └── server.py        ← 内置 Web 服务器
```

## 工作原理

```text
[浏览器] http://NAS:5173
         ↓
[Python Web Server]  (data/scripts/server.py)
  ├── /               → 静态文件（ClawX 前端 dist/）
  ├── /api/*          → 反向代理 → localhost:18789 (Gateway)
  └── /ws/*           → WebSocket → Gateway
         ↓
[OpenClaw Gateway]  (localhost:18789)
  └── 连接 AI 模型 / 各种渠道
```

## 配置说明

编辑 `data/config/openclaw.json`：

```json
{
  "gateway": {
    "port": 18789,
    "host": "0.0.0.0"
  },
  "plugins": {
    "dir": "plugins"
  }
}
```

首次启动后，按向导配置 AI 模型和渠道即可。

## 常见问题

**Q: 启动后显示空白页？**
检查 Gateway 是否正常：`curl http://localhost:18789/health`

**Q: 提示无法连接？**
等待 10 秒让 Gateway 完全启动，然后再试。

**Q: 端口被占用？**
修改 `fnpack.json` 中的 `runtime.port`，并更新 `data/config/openclaw.json` 中的 Gateway 端口。

## 构建自己的 FPK

### 前置准备

- GitHub 账号
- 本地安装 [Git](https://git-scm.com/)

### 步骤

```bash
# 1. Fork 本仓库到你的 GitHub

# 2. 克隆到本地
git clone https://github.com/<你的用户名>/clawx-fpk.git
cd clawx-fpk

# 3. 提交到 GitHub
git add .
git commit -m "init clawx-fpk"
git push origin main

# 4. 在 GitHub 触发 Actions
#    → Actions → Build ClawX FPK → Run workflow
#    → 输入版本号，点击运行

# 5. 下载构建产物
#    → Actions → 对应 run → Artifacts → 下载 .fpk
```

### 发布 Release

```bash
# 打 tag 触发正式 Release
git tag v0.3.2
git push origin v0.3.2
```

GitHub Actions 会自动构建两个架构的 FPK 并创建 Release。

## License

MIT — ClawX 前端版权归 [ValueCell-ai](https://github.com/ValueCell-ai/ClawX) 所有，FPK 适配由社区贡献。
