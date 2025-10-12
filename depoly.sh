#!/bin/bash

# 智能部署脚本：避免无意义部署 + 智能提交信息

set -e

# 日志函数
log_info() { echo "ℹ️  $1"; }
log_success() { echo "✅ $1"; }
log_warning() { echo "⚠️  $1"; }
log_error() { echo "❌ $1"; }

# 检查是否有实际的内容更新
has_meaningful_changes() {
    local git_status=$(git status --porcelain)
    
    # 排除不需要触发部署的文件类型
    while IFS= read -r line; do
        if [[ -z "$line" ]]; then
            continue
        fi
        
        local status=${line:0:2}
        local filename=${line:3}
        
        # 检查文件类型 - 只有这些类型的文件变更才需要重新部署
        case "$filename" in
            # 内容相关文件
            source/_posts/*.md|source/_posts/*.markdown) return 0 ;;
            # 配置相关文件
            _config.yml|_config.*.yml|themes/*) return 0 ;;
            # 布局和模板文件
            scaffolds/*|source/_data/*|source/_drafts/*) return 0 ;;
            # 脚本文件（可能影响生成）
            *.js|*.ts) return 0 ;;
        esac
    done <<< "$git_status"
    
    # 如果没有找到需要部署的文件变更
    return 1
}

# 分析 Git 变更并生成智能提交信息
generate_smart_commit_message() {
    local timestamp=$(date +"%Y-%m-%d %H:%M:%S")
    local git_status=$(git status --porcelain)
    
    # 初始化文件类型计数器
    local shell_files=0
    local markdown_files=0
    local config_files=0
    local image_files=0
    local style_files=0
    local other_files=0
    
    # 初始化操作类型计数器
    local added_files=0
    local modified_files=0
    local deleted_files=0
    
    # 分析每个文件的变更
    while IFS= read -r line; do
        if [[ -z "$line" ]]; then
            continue
        fi
        
        local status=${line:0:2}
        local filename=${line:3}
        
        # 统计操作类型
        case "$status" in
            "A "|"??") ((added_files++)) ;;
            "M "|" M") ((modified_files++)) ;;
            "D ") ((deleted_files++)) ;;
        esac
        
        # 统计文件类型
        case "$filename" in
            *.sh|*.bash) ((shell_files++)) ;;
            *.md|*.markdown) ((markdown_files++)) ;;
            *.json|*.yml|*.yaml|*.config|*.xml|*.toml) ((config_files++)) ;;
            *.png|*.jpg|*.jpeg|*.gif|*.svg|*.ico) ((image_files++)) ;;
            *.css|*.scss|*.less|*.styl) ((style_files++)) ;;
            *) ((other_files++)) ;;
        esac
    done <<< "$git_status"
    
    # 生成操作描述
    local operation_desc=""
    if [ $added_files -gt 0 ] && [ $modified_files -eq 0 ] && [ $deleted_files -eq 0 ]; then
        operation_desc="发布"
    elif [ $deleted_files -gt 0 ] && [ $added_files -eq 0 ] && [ $modified_files -eq 0 ]; then
        operation_desc="移除"
    elif [ $modified_files -gt 0 ] && [ $added_files -eq 0 ] && [ $deleted_files -eq 0 ]; then
        operation_desc="优化"
    else
        operation_desc="更新"
    fi
    
    # 生成文件类型描述
    local type_desc=""
    local type_count=0
    
    if [ $shell_files -gt 0 ]; then
        type_desc="脚本"
        ((type_count++))
    fi
    
    if [ $markdown_files -gt 0 ]; then
        if [ $type_count -gt 0 ]; then
            type_desc="${type_desc}与文章"
        else
            type_desc="文章"
        fi
        ((type_count++))
    fi
    
    if [ $config_files -gt 0 ]; then
        if [ $type_count -gt 0 ]; then
            type_desc="${type_desc}与配置"
        else
            type_desc="配置"
        fi
        ((type_count++))
    fi
    
    if [ $image_files -gt 0 ]; then
        if [ $type_count -gt 0 ]; then
            type_desc="${type_desc}与图片"
        else
            type_desc="图片"
        fi
        ((type_count++))
    fi
    
    if [ $style_files -gt 0 ]; then
        if [ $type_count -gt 0 ]; then
            type_desc="${type_desc}与样式"
        else
            type_desc="样式"
        fi
        ((type_count++))
    fi
    
    if [ $other_files -gt 0 ] && [ $type_count -eq 0 ]; then
        type_desc="资源"
    elif [ $other_files -gt 0 ] && [ $type_count -gt 0 ]; then
        type_desc="${type_desc}等"
    fi
    
    # 根据不同类型的组合生成精炼的提交信息
    local commit_message=""
    
    if [ $type_count -eq 0 ]; then
        # 没有特定类型，使用通用描述
        local generic_msgs=(
            "博客维护 | 持续改进"
            "内容更新 | 优化体验"
            "资源同步 | 保持最新"
            "项目整理 | 代码优化"
        )
        local random_index=$((RANDOM % ${#generic_msgs[@]}))
        commit_message="${generic_msgs[$random_index]} - $timestamp"
        
    elif [ $type_count -eq 1 ]; then
        # 单一文件类型
        case "$type_desc" in
            "脚本")
                local msgs=("优化脚本功能 | 提升效率" "完善工具链 | 自动化流程" "脚本维护 | 功能增强")
                ;;
            "文章")
                local msgs=("发布新文章 | 知识分享" "更新博客内容 | 思想记录" "文章优化 | 阅读体验")
                ;;
            "配置")
                local msgs=("调整配置项 | 系统优化" "更新设置 | 性能调优" "配置维护 | 环境完善")
                ;;
            "图片")
                local msgs=("添加图片资源 | 视觉优化" "更新媒体内容 | 丰富展示" "图片资源 | 内容增强")
                ;;
            "样式")
                local msgs=("美化界面样式 | 视觉升级" "优化视觉效果 | 用户体验" "样式调整 | 界面优化")
                ;;
            *)
                local msgs=("内容更新 | 持续改进" "资源维护 | 项目优化")
                ;;
        esac
        local random_index=$((RANDOM % ${#msgs[@]}))
        commit_message="${msgs[$random_index]} - $timestamp"
        
    else
        # 多种文件类型
        local multi_msgs=(
            "综合更新 | 多维度优化"
            "多项改进 | 全面提升"
            "内容与功能 | 同步升级"
            "多资源更新 | 系统维护"
        )
        local random_index=$((RANDOM % ${#multi_msgs[@]}))
        commit_message="${multi_msgs[$random_index]} - $timestamp"
    fi
    
    echo "$commit_message"
}

# 主函数
main() {
    log_info "开始智能部署流程..."
    
    # 检查是否在 Git 仓库中
    if ! git rev-parse --git-dir > /dev/null 2>&1; then
        log_error "当前目录不是 Git 仓库！"
        exit 1
    fi
    
    # 显示当前 Git 状态
    log_info "分析文件变更..."
    if [[ -z $(git status --porcelain) ]]; then
        log_warning "没有检测到 Git 更改"
        exit 0
    fi
    
    # 检查是否有需要部署的实质性变更
    if ! has_meaningful_changes; then
        log_warning "检测到更改，但无需重新部署 Hexo"
        log_info "仅提交 Git 变更..."
        
        # 生成智能提交信息
        local commit_message=$(generate_smart_commit_message)
        log_success "提交信息: $commit_message"
        
        # 提交所有更改
        git add -A
        git commit -m "$commit_message"
        git push origin $(git branch --show-current)
        
        log_success "Git 提交完成！跳过 Hexo 部署。"
        exit 0
    fi
    
    # 有实质性变更，执行完整部署流程
    log_info "检测到需要部署的变更，开始完整部署流程..."
    
    # 1. 执行 Hexo 清理和部署
    log_info "清理 Hexo 缓存..."
    hexo clean
    
    log_info "生成并部署 Hexo 博客..."
    if hexo g -d; then
        log_success "Hexo 部署完成！"
    else
        log_error "Hexo 部署失败！"
        exit 1
    fi
    
    # 2. 生成智能提交信息
    log_info "生成智能提交信息..."
    local commit_message=$(generate_smart_commit_message)
    log_success "提交信息: $commit_message"
    
    # 3. 提交所有更改
    log_info "添加所有更改到暂存区..."
    git add -A
    
    log_info "提交更改..."
    if git commit -m "$commit_message"; then
        log_success "本地提交完成！"
    else
        log_error "Git 提交失败！"
        exit 1
    fi
    
    # 4. 推送到远程仓库
    log_info "获取当前分支名..."
    local current_branch=$(git branch --show-current)
    
    log_info "推送到远程仓库 (分支: $current_branch)..."
    if git push origin "$current_branch"; then
        log_success "智能部署完成！"
        log_success "Hexo 已部署 + Git 已提交并推送"
    else
        log_error "Git 推送失败！"
        exit 1
    fi
}

# 执行主函数
main "$@"