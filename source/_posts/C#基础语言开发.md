---
title: C#基础语言开发
date: 2025-10-12 21:53:03
tags: 
  - C#
  - Godot
categories: Godot
cover: https://cdn.jsdelivr.net/gh/rainlotus97/images/data/2025-10-12/Snipaste_2025-10-12_21-56-23-397b7d.png
description: 记录自学C#语言的过程
---

# C#基础语言开发

## 1.基础准备

### 1.1 准备工作

确保已经安装以下环境，即可在VS Code中正常运行项目

- [.NET SDK](https://dotnet.microsoft.com/download)
- [VS Code](https://code.visualstudio.com/)
- [C# 扩展](https://marketplace.visualstudio.com/items?itemName=ms-dotnettools.csharp)

### 1.2 创建新项目

**方法一：使用终端命令**

```bash
# 打开终端（Ctrl+`）
# 创建项目目录并进入
mkdir MyFirstCSharpProject
cd MyFirstCSharpProject

# 创建控制台项目
dotnet new console
```

**方法二：使用 VS Code 命令面板**

1. 按 `Ctrl+Shift+P` 打开命令面板
2. 输入 `.NET: New Project`
3. 选择 "Console Application"
4. 选择项目位置和名称

### 1.3 项目结构

创建成功后，你会看到以下文件结构：

```text
MyFirstCSharpProject/
├── Program.cs          # 主程序文件
├── MyFirstCSharpProject.csproj  # 项目配置文件
└── obj/               # 编译生成文件
```

### 1.4 配置和运行

#### 1.4.1 打开项目

```bash
# 在项目目录中打开 VS Code
code .
```

#### 1.4.2 理解 Program.cs

默认生成的 `Program.cs` 内容：

```c#
// See https://aka.ms/new-console-template for more information
Console.WriteLine("Hello, World!");
```

#### 1.4.3 运行项目

**方法一：使用 .NET CLI（推荐）**

```bash
# 在 VS Code 终端中运行
dotnet run

# 或者先编译再运行
dotnet build
dotnet run
```

**方法二：使用 Code Runner 扩展**

1. 安装 "Code Runner" 扩展
2. 打开 `Program.cs` 文件
3. 点击右上角的 ▶️ 运行按钮
4. 或按 `Ctrl+Alt+N`

**方法三：使用调试功能**

1. 按 `F5` 或点击运行 → 启动调试
2. 首次运行会创建 `.vscode/launch.json` 配置文件

### 1.5 📝 完整示例：创建自定义项目

让我们创建一个更完整的示例：

#### 1.5.1 创建项目

```bash
dotnet new console -n CalculatorApp
cd CalculatorApp
code .
```

#### 1.5.2 修改 Program.cs

```c#
using System;

namespace CalculatorApp
{
    class Program
    {
        static void Main(string[] args)
        {
            Console.WriteLine("=== 简易计算器 ===");
            
            while (true)
            {
                Console.WriteLine("\n请选择操作:");
                Console.WriteLine("1. 加法");
                Console.WriteLine("2. 减法"); 
                Console.WriteLine("3. 退出");
                Console.Write("请输入选择 (1-3): ");
                
                string choice = Console.ReadLine();
                
                if (choice == "3")
                {
                    Console.WriteLine("感谢使用！");
                    break;
                }
                
                if (choice == "1" || choice == "2")
                {
                    Console.Write("请输入第一个数字: ");
                    double num1 = Convert.ToDouble(Console.ReadLine());
                    
                    Console.Write("请输入第二个数字: ");
                    double num2 = Convert.ToDouble(Console.ReadLine());
                    
                    double result = choice == "1" ? num1 + num2 : num1 - num2;
                    string operation = choice == "1" ? "+" : "-";
                    
                    Console.WriteLine($"结果: {num1} {operation} {num2} = {result}");
                }
                else
                {
                    Console.WriteLine("无效选择，请重新输入！");
                }
            }
        }
    }
}
```

#### 1.5.3 运行项目

```bash
dotnet run
```

### 1.6 ⚙️ 重要配置

#### 1.6.1 调试配置

如果调试功能不正常，检查 `.vscode/launch.json`：

```json
{
    "version": "0.2.0",
    "configurations": [
        {
            "name": "C# Demo Debug", // 自定义调试名称
            "type": "coreclr",
            "request": "launch",
            "preLaunchTask": "build",  // 引用自定义任务
            "program": "${workspaceFolder}/bin/Debug/net8.0/C#.dll", // 根据当前项目/bin目录查找配置
            "args": [],
            "cwd": "${workspaceFolder}",
            "console": "internalConsole",
            "stopAtEntry": false
        }
    ]
}
```

#### 1.6.2 任务配置(可选)

可选的任务配置：.vscode/tasks.json 一般launch.json中配置了**preLaunchTask**时使用

```json
{
    "version": "2.0.0",
    "tasks": [
        {
            "label": "build",
            "command": "dotnet",
            "type": "process",
            "args": [
                "build",
                "${workspaceFolder}/C#.csproj", // 实际项目的名称：xxx.csproj
                "/property:GenerateFullPaths=true",
                "/consoleloggerparameters:NoSummary"
            ],
            "group": "build",
            "presentation": {
                "reveal": "silent"
            },
            "problemMatcher": "$msCompile"
        }
    ]
}
```
