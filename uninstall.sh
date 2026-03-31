#!/bin/bash
# ClawX FPK 卸载脚本
echo "[ClawX] 正在卸载..."
APP_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DATA_DIR="$APP_DIR/data"

# 停止进程
pkill -f "server.py.*clawx"  2>/dev/null && echo "[✓] Web 服务已停止" || echo "[-] Web 服务未运行"
# 不杀 Gateway，因为它可能是用户全局安装的

# 清理数据（可选：保留配置）
# rm -rf "$DATA_DIR/logs" && echo "[✓] 日志已清理"

echo "[ClawX] 卸载完成"
echo "[提示] OpenClaw Gateway 未受影响，如需卸载请单独处理"
