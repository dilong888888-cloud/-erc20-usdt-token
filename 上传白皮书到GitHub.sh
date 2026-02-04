#!/bin/bash

# 上传白皮书到GitHub

echo "🚀 开始上传白皮书到GitHub..."
echo ""

# 白皮书文件路径
WHITEPAPER_FILE="ERC20-USDT代币发布/ERC20-USDT_Whitepaper.md"
GITHUB_REPO="https://github.com/dilong888888-cloud/-erc20-usdt-token.git"
REPO_NAME="-erc20-usdt-token"

# 检查文件是否存在
if [ ! -f "$WHITEPAPER_FILE" ]; then
    echo "❌ 错误：找不到白皮书文件"
    echo "   路径：$WHITEPAPER_FILE"
    exit 1
fi

echo "✅ 找到白皮书文件：$WHITEPAPER_FILE"
echo ""

# 创建临时目录
TEMP_DIR=$(mktemp -d)
echo "📁 创建临时目录：$TEMP_DIR"
echo ""

# 克隆仓库
echo "📥 克隆GitHub仓库..."
cd "$TEMP_DIR"
git clone "$GITHUB_REPO" "$REPO_NAME" 2>&1 | head -10

if [ ! -d "$REPO_NAME" ]; then
    echo "❌ 错误：无法克隆仓库"
    echo "   请检查："
    echo "   1. 是否有网络连接"
    echo "   2. 是否有GitHub访问权限"
    echo "   3. 仓库地址是否正确：$GITHUB_REPO"
    exit 1
fi

cd "$REPO_NAME"

# 复制白皮书文件
echo "📋 复制白皮书文件..."
cp "/Users/zhuzhu/Desktop/自动漏洞挖掘程序/$WHITEPAPER_FILE" .

# 检查是否成功复制
if [ ! -f "ERC20-USDT_Whitepaper.md" ]; then
    echo "❌ 错误：无法复制白皮书文件"
    exit 1
fi

echo "✅ 白皮书文件已复制"
echo ""

# 添加文件到git
echo "📝 添加文件到Git..."
git add ERC20-USDT_Whitepaper.md

# 提交
echo "💾 提交更改..."
git commit -m "Add ERC20-USDT Whitepaper" 2>&1

# 推送
echo "🚀 推送到GitHub..."
echo "⚠️  注意：这需要GitHub认证"
echo ""
git push origin main 2>&1 || git push origin master 2>&1

if [ $? -eq 0 ]; then
    echo ""
    echo "✅ 白皮书上传成功！"
    echo ""
    echo "📋 白皮书链接："
    echo "   https://raw.githubusercontent.com/dilong888888-cloud/-erc20-usdt-token/main/ERC20-USDT_Whitepaper.md"
    echo ""
    echo "🌐 GitHub Pages链接（如果已启用）："
    echo "   https://dilong888888-cloud.github.io/-erc20-usdt-token/ERC20-USDT_Whitepaper.md"
else
    echo ""
    echo "⚠️  推送可能需要手动认证"
    echo "   请手动执行以下命令："
    echo "   cd $TEMP_DIR/$REPO_NAME"
    echo "   git push origin main"
fi

# 清理
cd /tmp
rm -rf "$TEMP_DIR"

echo ""
echo "✅ 完成！"

