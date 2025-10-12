#!/bin/bash

# 修复版 Hexo 部署与 Git 提交脚本 - 能检测新增文件

set -e  # 遇到错误立即退出

# 颜色定义
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# 日志函数
log_info() { echo -e "${BLUE}ℹ️  $1${NC}"; }
log_success() { echo -e "${GREEN}✅ $1${NC}"; }
log_warning() { echo -e "${YELLOW}⚠️  $1${NC}"; }
log_error() { echo -e "${RED}❌ $1${NC}"; }

# 检测 Git 更改（包括新增文件）
has_git_changes() {
    # 检查是否有已跟踪文件的修改或未跟踪的新文件
    if [[ -n $(git status --porcelain) ]]; then
        return 0  # 有更改
    else
        return 1  # 无更改
    fi
}

# 显示 Git 状态（调试用）
show_git_status() {
    log_info "📊 当前 Git 状态:"
    git status --short
}

# 生成提交信息
generate_commit_message() {
    local timestamp=$(date +"%Y-%m-%d %H:%M:%S")
    
    local templates=(
        "博客更新 | 自动部署 - $timestamp"
        "内容发布 | 持续集成 - $timestamp"
        "文章新增 | 知识分享 - $timestamp"
        "资源更新 | 博客维护 - $timestamp"
        "自动提交 | 部署流程 - $timestamp"
    )
    
    local random_index=$((RANDOM % ${#templates[@]}))
    echo "${templates[$random_index]}"
}

# 主函数
main() {
    log_info "🚀 开始一体化部署流程..."
    
    # 检查是否在 Git 仓库中
    if ! git rev-parse --git-dir > /dev/null 2>&1; then
        log_error "当前目录不是 Git 仓库！"
        exit 1
    fi
    
    # 显示当前 Git 状态（调试信息）
    show_git_status
    
    # 1. 执行 Hexo 清理和部署
    log_info "🧹 清理 Hexo 缓存..."
    hexo clean
    
    log_info "📝 生成并部署 Hexo 博客..."
    if hexo g -d; then
        log_success "Hexo 部署完成！"
    else
        log_error "Hexo 部署失败！"
        exit 1
    fi
    
    # 2. 重新检查 Git 状态（部署可能产生新文件）
    log_info "🔄 重新检查 Git 状态..."
    show_git_status
    
    # 3. 检测是否有任何 Git 更改（包括新增文件）
    if ! has_git_changes; then
        log_warning "📭 没有检测到 Git 更改，跳过提交"
        log_success "🎉 Hexo 部署完成！"
        exit 0
    fi
    
    # 4. 生成提交信息并提交
    local commit_message=$(generate_commit_message)
    log_info "📄 生成的提交信息: $commit_message"
    
    log_info "📦 添加所有更改到暂存区（包括新文件）..."
    
    # 使用 git add -A 添加所有更改（包括新文件、修改和删除）
    git add -A
    
    # 再次显示状态确认已添加
    log_info "📊 添加后的 Git 状态:"
    git status --short
    
    log_info "💾 提交更改..."
    if git commit -m "$commit_message"; then
        log_success "本地提交完成！"
    else
        log_error "Git 提交失败！"
        exit 1
    fi
    
    # 5. 推送到远程仓库
    log_info "🔄 获取当前分支名..."
    local current_branch=$(git branch --show-current)
    
    log_info "📤 推送到远程仓库 (分支: $current_branch)..."
    if git push origin "$current_branch"; then
        log_success "🎉 一体化部署完成！"
        log_success "📊 Hexo 已部署 + Git 已提交并推送"
    else
        log_error "Git 推送失败！"
        exit 1
    fi
}

# 执行主函数
main "$@"