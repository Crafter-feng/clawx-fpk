#!/bin/bash
# ClawX FPK 安装脚本
echo "╔══════════════════════════════════════════╗"
echo "║        ClawX FPK 安装程序                ║"
echo "╚══════════════════════════════════════════╝"

APP_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DATA_DIR="$APP_DIR/data"
LOG_DIR="$DATA_DIR/logs"

# 创建必要目录
mkdir -p "$LOG_DIR"
mkdir -p "$DATA_DIR/config"
mkdir -p "$DATA_DIR/openclaw_core"

# 写入 OpenClaw 默认配置
if [ ! -f "$DATA_DIR/config/openclaw.json" ]; then
    cat > "$DATA_DIR/config/openclaw.json" << 'CONF'
{
  "gateway": {
    "port": 18789,
    "host": "0.0.0.0"
  },
  "plugins": { "dir": "plugins" }
}
CONF
    echo "[✓] OpenClaw 配置文件已创建"
else
    echo "[✓] OpenClaw 配置文件已存在"
fi

echo ""
echo "========================================"
echo " 安装完成！"
echo ""
echo " 下一步："
echo "  1. 确保 NAS 已安装 OpenClaw Core"
echo "     （如未安装，请联系阿强帮你装）"
echo ""
echo "  2. 启动 ClawX："
echo "     cd $APP_DIR"
echo "     bash data/scripts/start.sh"
echo ""
echo "  3. 浏览器打开："
echo "     http://localhost:5173"
echo "========================================"
