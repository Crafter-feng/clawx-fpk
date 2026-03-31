# ClawX FPK for 飞牛 fnOS

> 将 [ClawX](https://github.com/ValueCell-ai/ClawX)（OpenClaw 桌面客户端）打包为飞牛 fnOS 原生 FPK 应用，浏览器直接打开，无需代理。

## 构建方式

**源码构建**（非解压预编译包）：
- 克隆 ClawX 源码 → pnpm 构建前端
- bun 安装 OpenClaw Core（无需 Node.js 全量依赖）
- 产物极小，构建在 GitHub Actions 完成

## 安装 FPK（推荐）

进入 [Releases](https://github.com/Crafter-feng/clawx-fpk/releases) 页面，下载对应架构的 `.fpk`：

| 文件 | 架构 |
|------|------|
| `clawx-amd64-X.X.X.fpk` | Intel / AMD CPU |
| `clawx-arm64-X.X.X.fpk` | ARM64（树莓派等）|

上传至飞牛 NAS → 应用中心 → 从文件安装

## 启动

桌面点击 ClawX 图标，或手动运行：

```bash
cd /opt/clawx
bash data/scripts/start.sh
# 浏览器打开 http://localhost:5173
```

## 架构说明

```
ClawX.fpk/
├── fnpack.json
├── install.sh / uninstall.sh
└── data/
    ├── dist/                ← ClawX 前端（vite build 产物）
    ├── openclaw_core/       ← OpenClaw Core（bun 安装）
    ├── config/openclaw.json ← Gateway 配置
    ├── scripts/
    │   ├── start.sh         ← 启动 Gateway + Web
    │   └── server.py        ← Web 服务器（静态 + 代理）
    └── logs/                ← 运行日志
```

## 常见问题

**Q: 提示 OpenClaw 未找到？**
FPK 内置了 OpenClaw Core，等待启动脚本自动初始化即可。如启动失败，请确保 NAS 架构（amd64/arm64）与 FPK 版本匹配。

**Q: 空白页？**
等待 10 秒让 Gateway 完全启动，然后刷新浏览器。

**Q: 端口被占用？**
修改 `data/config/openclaw.json` 中的 `gateway.port`，重启后生效。

## 自行构建

```bash
# 触发 GitHub Actions
git tag v0.3.2
git push origin v0.3.2

# 或手动触发（Actions 页面 → Build ClawX FPK → Run workflow）
```

## License

MIT — ClawX 前端版权归 [ValueCell-ai](https://github.com/ValueCell-ai/ClawX) 所有
