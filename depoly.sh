#!/bin/bash

# 智能提交信息生成脚本 - 根据文件类型生成相应的提交信息

set -e

# 颜色定义
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m'

# 日志函数
log_info() { echo -e "${BLUE}ℹ️  $1${NC}"; }
log_success() { echo -e "${GREEN}✅ $1${NC}"; }
log_warning() { echo -e "${YELLOW}⚠️  $1${NC}"; }
log_error() { echo -e "${RED}❌ $1${NC}"; }
log_debug() { echo -e "${PURPLE}🐛 $1${NC}"; }
log_type() { echo -e "${CYAN}📁 $1${NC}"; }

# 分析 Git 变更并生成智能提交信息
generate_smart_commit_message() {
    local timestamp=$(date +"%Y-%m-%d %H:%M:%S")
    
    # 获取 Git 状态详情
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
            *.sh|*.bash)
                ((shell_files++))
                log_type "Shell 脚本: $filename ($status)"
                ;;
            *.md|*.markdown)
                ((markdown_files++))
                log_type "Markdown 文档: $filename ($status)"
                ;;
            *.json|*.yml|*.yaml|*.config|*.xml|*.toml)
                ((config_files++))
                log_type "配置文件: $filename ($status)"
                ;;
            *.png|*.jpg|*.jpeg|*.gif|*.svg|*.ico)
                ((image_files++))
                log_type "图片资源: $filename ($status)"
                ;;
            *.css|*.scss|*.less|*.styl)
                ((style_files++))
                log_type "样式文件: $filename ($status)"
                ;;
            *)
                ((other_files++))
                log_type "其他文件: $filename ($status)"
                ;;
        esac
    done <<< "$git_status"
    
    log_debug "文件类型统计: Shell($shell_files) MD($markdown_files) 配置($config_files) 图片($image_files) 样式($style_files) 其他($other_files)"
    log_debug "操作类型统计: 新增($added_files) 修改($modified_files) 删除($deleted_files)"
    
    # 生成操作描述
    local operation_desc=""
    if [ $added_files -gt 0 ] && [ $modified_files -eq 0 ] && [ $deleted_files -eq 0 ]; then
        operation_desc="新增"
    elif [ $deleted_files -gt 0 ] && [ $added_files -eq 0 ] && [ $modified_files -eq 0 ]; then
        operation_desc="删除"
    elif [ $modified_files -gt 0 ] && [ $added_files -eq 0 ] && [ $deleted_files -eq 0 ]; then
        operation_desc="更新"
    else
        operation_desc="变更"
    fi
    
    # 生成文件类型描述
    local type_desc=""
    local type_count=0
    
    if [ $shell_files -gt 0 ]; then
        type_desc="${type_desc}脚本"
        ((type_count++))
    fi
    
    if [ $markdown_files -gt 0 ]; then
        if [ $type_count -gt 0 ]; then
            type_desc="${type_desc}、"
        fi
        type_desc="${type_desc}文章"
        ((type_count++))
    fi
    
    if [ $config_files -gt 0 ]; then
        if [ $type_count -gt 0 ]; then
            type_desc="${type_desc}、"
        fi
        type_desc="${type_desc}配置"
        ((type_count++))
    fi
    
    if [ $image_files -gt 0 ]; then
        if [ $type_count -gt 0 ]; then
            type_desc="${type_desc}、"
        fi
        type_desc="${type_desc}图片"
        ((type_count++))
    fi
    
    if [ $style_files -gt 0 ]; then
        if [ $type_count -gt 0 ]; then
            type_desc="${type_desc}、"
        fi
        type_desc="${type_desc}样式"
        ((type_count++))
    fi
    
    if [ $other_files -gt 0 ] && [ $type_count -eq 0 ]; then
        type_desc="资源"
    elif [ $other_files -gt 0 ]; then
        type_desc="${type_desc}等"
    fi
    
    # 生成最终提交信息
    if [ -z "$type_desc" ]; then
        echo "$operation_desc博客内容 - $timestamp"
    elif [ $type_count -eq 1 ]; then
        echo "$operation_desc${type_desc} - $timestamp"
    else
        echo "$operation_desc${type_desc} - $timestamp"
    fi
}

# 主函数
main() {
    log_info "🚀 开始智能部署流程..."
    
    # 检查是否在 Git 仓库中
    if ! git rev-parse --git-dir > /dev/null 2>&1; then
        log_error "当前目录不是 Git 仓库！"
        exit 1
    fi
    
    # 显示当前 Git 状态
    log_info "📊 分析文件变更..."
    if [[ -z $(git status --porcelain) ]]; then
        log_warning "📭 没有检测到 Git 更改"
        exit 0
    fi
    
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
    
    # 2. 生成智能提交信息
    log_info "🤖 生成智能提交信息..."
    local commit_message=$(generate_smart_commit_message)
    log_success "生成的提交信息: $commit_message"
    
    # 3. 提交所有更改
    log_info "📦 添加所有更改到暂存区..."
    git add -A
    
    log_info "💾 提交更改..."
    if git commit -m "$commit_message"; then
        log_success "本地提交完成！"
    else
        log_error "Git 提交失败！"
        exit 1
    fi
    
    # 4. 推送到远程仓库
    log_info "🔄 获取当前分支名..."
    local current_branch=$(git branch --show-current)
    
    log_info "📤 推送到远程仓库 (分支: $current_branch)..."
    if git push origin "$current_branch"; then
        log_success "🎉 智能部署完成！"
        log_success "📊 Hexo 已部署 + Git 已提交并推送"
    else
        log_error "Git 推送失败！"
        exit 1
    fi
}

# 执行主函数
main "$@"