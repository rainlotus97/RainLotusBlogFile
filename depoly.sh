#!/bin/bash

# 简化版部署脚本：有变更就部署，无变更则跳过

set -e

# 日志函数
log_info() { echo "ℹ️  $1"; }
log_success() { echo "✅ $1"; }
log_warning() { echo "⚠️  $1"; }
log_error() { echo "❌ $1"; }

# 生成提交信息
generate_commit_message() {
    local timestamp=$(date +"%Y-%m-%d %H:%M:%S")
    
    # 获取 Git 状态详情
    local git_status=$(git status --porcelain)
    
    # 简单统计变更类型
    local added_files=0
    local modified_files=0
    local deleted_files=0
    
    while IFS= read -r line; do
        if [[ -z "$line" ]]; then
            continue
        fi
        
        local status=${line:0:2}
        
        case "$status" in
            "A "|"??") ((added_files++)) ;;
            "M "|" M") ((modified_files++)) ;;
            "D ") ((deleted_files++)) ;;
        esac
    done <<< "$git_status"
    
    # 生成操作描述
    local operation=""
    if [ $added_files -gt 0 ] && [ $modified_files -eq 0 ] && [ $deleted_files -eq 0 ]; then
        operation="新增内容"
    elif [ $deleted_files -gt 0 ] && [ $added_files -eq 0 ] && [ $modified_files -eq 0 ]; then
        operation="删除内容"
    elif [ $modified_files -gt 0 ] && [ $added_files -eq 0 ] && [ $deleted_files -eq 0 ]; then
        operation="更新内容"
    else
        operation="内容变更"
    fi
    
    echo "$operation | $timestamp"
}

# 主函数
main() {
    log_info "开始部署流程..."
    
    # 检查是否在 Git 仓库中
    if ! git rev-parse --git-dir > /dev/null 2>&1; then
        log_error "当前目录不是 Git 仓库！"
        exit 1
    fi
    
    # 检查是否有变更
    log_info "检查文件变更..."
    if [[ -z $(git status --porcelain) ]]; then
        log_warning "没有检测到文件变更，跳过部署"
        exit 0
    fi
    
    # 显示变更摘要
    log_info "检测到以下变更:"
    git status --short
    
    # 生成提交信息
    log_info "生成提交信息..."
    local commit_message=$(generate_commit_message)
    log_success "提交信息: $commit_message"
    
    # 执行 Hexo 部署
    log_info "清理 Hexo 缓存..."
    hexo clean
    
    log_info "生成并部署 Hexo 博客..."
    if hexo g -d; then
        log_success "Hexo 部署完成！"
    else
        log_error "Hexo 部署失败！"
        exit 1
    fi
    
    # 提交所有变更
    log_info "添加所有更改到暂存区..."
    git add -A
    
    log_info "提交更改..."
    if git commit -m "$commit_message"; then
        log_success "本地提交完成！"
    else
        log_error "Git 提交失败！"
        exit 1
    fi
    
    # 推送到远程仓库
    log_info "获取当前分支名..."
    local current_branch=$(git branch --show-current)
    
    log_info "推送到远程仓库 (分支: $current_branch)..."
    if git push origin "$current_branch"; then
        log_success "部署完成！"
        log_success "Hexo 已部署 + Git 已提交并推送"
    else
        log_error "Git 推送失败！"
        exit 1
    fi
}

# 执行主函数
main "$@"