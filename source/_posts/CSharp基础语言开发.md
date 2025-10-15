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

## 2.数据类型

|   **类别**   | **子类别** | **具体类型**                       | **说明**                         |
| :----------: | ---------- | ---------------------------------- | -------------------------------- |
|  **值类型**  | 整数类型   | `sbyte`, `byte`, `short`, `ushort` | 8位和16位整数，有符号和无符号    |
|              |            | `int`, `uint`, `long`, `ulong`     | 32位和64位整数，有符号和无符号   |
|              | 浮点类型   | `float`, `double`, `decimal`       | 单精度、双精度和高精度小数       |
|              | 字符类型   | `char`                             | 16位Unicode字符                  |
|              | 布尔类型   | `bool`                             | 布尔值，true或false              |
|              | 结构体     | `struct`                           | 自定义值类型                     |
|              | 枚举       | `enum`                             | 命名常量集合                     |
| **引用类型** | 类         | `object`, `string`, 自定义`class`  | 所有类型的基类、字符串、自定义类 |
|              | 接口       | `interface`                        | 定义契约接口                     |
|              | 数组       | `int[]`, `string[]` 等             | 相同类型元素的集合               |
|              | 委托       | `delegate`                         | 方法引用类型                     |
| **特殊类型** | 动态类型   | `dynamic`                          | 运行时类型解析                   |
|              | 可空类型   | `int?`, `bool?` 等                 | 允许值类型为null                 |

补充说明：

1. 值类型：直接存储数据，分配在栈上，赋值时复制完整值。
2. 引用类型：存储数据的内存地址，分配在堆上，赋值时复制引用。
3. 默认值：值类型默认为 0/false 等，引用类型默认为 null。

示例代码：

```csharp
int number = 10;                    // 值类型
string text = "Hello";              // 引用类型
int? nullableInt = null;            // 可空类型
dynamic dynamicVar = "Dynamic";     // 动态类型
```

## 3.C# 与 TypeScript 对比学习指南（Godot开发重点）

### 3.1 基础数据类型与语法对比

#### 3.1.1 基础数据类型

| TypeScript                             | C# (Godot)                              | 说明     |
| -------------------------------------- | --------------------------------------- | -------- |
| `let num: number = 10;`                | `int num = 10;`                         | 整数类型 |
| `let str: string = "hello";`           | `string str = "hello";`                 | 字符串   |
| `let bool: boolean = true;`            | `bool flag = true;`                     | 布尔值   |
| `let arr: number[] = [1,2,3];`         | `int[] arr = new int[] {1,2,3};`        | 数组     |
| `let map = new Map<string, number>();` | `Dictionary<string, int> dict = new();` | 字典/Map |
| `let set = new Set<number>();`         | `HashSet<int> set = new();`             | 集合     |
| `let obj: any = "anything";`           | `dynamic obj = "anything";`             | 动态类型 |

#### 3.1.2 变量声明与访问修饰符

TypeScript:

```typescript
class Example {
    public name: string = "public";
    private age: number = 20;
    protected email?: string;
    readonly id: number = 1;
}
```

C#:

```csharp
public class Example
{
    public string Name { get; set; } = "public";
    private int _age = 20;
    protected string? Email { get; set; }
    public readonly int Id = 1;
    
    // 自动属性（常用）
    public int Score { get; private set; }
    
    // 完整属性（有逻辑时使用）
    private int _health = 100;
    public int Health 
    { 
        get => _health;
        set 
        {
            _health = Math.Clamp(value, 0, 100);
            OnHealthChanged?.Invoke(_health);
        }
    }
}
```

#### 3.1.3 类与继承

TypeScript:

```typescript
class Entity {
    constructor(public id: number) {}
    
    move(): void {
        console.log("Moving");
    }
}

class Player extends Entity {
    private health: number = 100;
    
    takeDamage(damage: number): void {
        this.health -= damage;
    }
}
```

C#:

```csharp
public class Entity
{
    public int Id { get; }
    
    public Entity(int id)
    {
        Id = id;
    }
    
    public virtual void Move()
    {
        GD.Print("Moving");
    }
}

public class Player : Entity
{
    private int _health = 100;
    
    public Player(int id) : base(id) 
    {
    }
    
    public void TakeDamage(int damage)
    {
        _health -= damage;
    }
    
    // 重写父类方法
    public override void Move()
    {
        base.Move(); // 调用父类实现
        GD.Print("Player is moving");
    }
}
```

#### 3.1.4 接口与枚举

TypeScript:

```typescript
enum Direction {
    Up = "UP",
    Down = "DOWN"
}

interface IDamageable {
    health: number;
    takeDamage(amount: number): void;
}

class Enemy implements IDamageable {
    health: number = 100;
    
    takeDamage(amount: number): void {
        this.health -= amount;
    }
}
```

C#:

```csharp
public enum Direction
{
    Up,
    Down,
    Left,
    Right
}

public interface IDamageable
{
    int Health { get; }
    void TakeDamage(int amount);
}

public class Enemy : IDamageable
{
    public int Health { get; private set; } = 100;
    
    public void TakeDamage(int amount)
    {
        Health -= amount;
    }
}
```

### 3.2 C# 特有重要特性

#### 3.2.1 委托 (Delegates) - C#的核心特性

委托类似于TypeScript中的函数类型，但更强大：

基本委托:

```csharp
// 声明委托类型
public delegate void SimpleDelegate();
public delegate int CalculateDelegate(int a, int b);

// 使用委托
public class Calculator
{
    public void TestDelegates()
    {
        // 方法组转换
        SimpleDelegate del1 = SayHello;
        CalculateDelegate del2 = Add;
        
        // 调用委托
        del1(); // 输出: Hello!
        int result = del2(5, 3); // result = 8
        
        // 多播委托（可以组合多个方法）
        SimpleDelegate multiDel = SayHello;
        multiDel += SayGoodbye;
        multiDel(); // 依次输出: Hello! 然后 Goodbye!
    }
    
    private void SayHello() => GD.Print("Hello!");
    private void SayGoodbye() => GD.Print("Goodbye!");
    private int Add(int a, int b) => a + b;
}
```

在Godot中的实际应用:

```csharp
public partial class EventManager : Node
{
    // 定义游戏事件委托
    public delegate void GameEventDelegate(string eventName, object data);
    public static GameEventDelegate OnGameEvent;
    
    public static void TriggerEvent(string eventName, object data = null)
    {
        OnGameEvent?.Invoke(eventName, data);
    }
}

// 使用
public partial class UI : Control
{
    public override void _Ready()
    {
        EventManager.OnGameEvent += HandleGameEvent;
    }
    
    private void HandleGameEvent(string eventName, object data)
    {
        switch (eventName)
        {
            case "PlayerDamaged":
                UpdateHealthBar(data);
                break;
            case "LevelComplete":
                ShowLevelComplete();
                break;
        }
    }
}
```

#### 3.2.2 事件 (Events) - 封装后的委托

事件提供了更好的封装性和安全性：

```csharp
public class Player : CharacterBody2D
{
    // 声明事件
    public event Action<int> HealthChanged; // Action是预定义的委托
    public event Action PlayerDied;
    public event Action<string, int> ItemCollected;
    
    private int _health = 100;
    
    public void TakeDamage(int damage)
    {
        _health -= damage;
        
        // 触发事件
        HealthChanged?.Invoke(_health);
        
        if (_health <= 0)
        {
            PlayerDied?.Invoke();
        }
    }
    
    public void CollectItem(string itemName, int value)
    {
        ItemCollected?.Invoke(itemName, value);
    }
}

// 订阅事件
public partial class GameUI : Control
{
    private Player _player;
    
    public override void _Ready()
    {
        _player = GetNode<Player>("Player");
        
        // 订阅事件
        _player.HealthChanged += OnHealthChanged;
        _player.PlayerDied += OnPlayerDied;
        _player.ItemCollected += OnItemCollected;
    }
    
    private void OnHealthChanged(int newHealth)
    {
        GetNode<Label>("HealthLabel").Text = $"Health: {newHealth}";
    }
    
    private void OnPlayerDied()
    {
        ShowGameOverScreen();
    }
    
    private void OnItemCollected(string itemName, int value)
    {
        ShowItemPopup(itemName);
    }
}
```

#### 3.2.3 泛型 (Generics)

比TypeScript的泛型更强大：

```csharp
// 泛型类
public class ObjectPool<T> where T : Node, new()
{
    private Queue<T> _pool = new Queue<T>();
    
    public T GetObject()
    {
        if (_pool.Count > 0)
            return _pool.Dequeue();
        
        return new T();
    }
    
    public void ReturnObject(T obj)
    {
        _pool.Enqueue(obj);
    }
}

// 泛型方法
public class GameUtils
{
    public static T FindComponentInChildren<T>(Node parent) where T : class
    {
        foreach (Node child in parent.GetChildren())
        {
            if (child is T component)
                return component;
                
            T found = FindComponentInChildren<T>(child);
            if (found != null)
                return found;
        }
        return null;
    }
}

// 使用
var bulletPool = new ObjectPool<Bullet>();
Bullet bullet = bulletPool.GetObject();

// 在Godot节点中查找组件
Player player = GameUtils.FindComponentInChildren<Player>(this);
```

#### 3.2.4 特性 (Attributes) - Godot中大量使用

```csharp
// Godot中的特性使用
public partial class Player : CharacterBody2D
{
    [Export] // 在编辑器中显示
    public int MaxHealth { get; set; } = 100;
    
    [Export(PropertyHint.Range, "0,100,1")] // 带范围限制
    public int Health { get; set; } = 100;
    
    [Export(PropertyHint.File, "*.tscn")] // 文件选择
    public string LevelScenePath { get; set; }
    
    [ExportGroup("Combat Settings")] // 分组
    [Export]
    public int AttackDamage = 10;
    
    [Signal] // 声明Godot信号
    public delegate void HealthChangedEventHandler(int newHealth);
    
    // 节点路径导出（自动获取节点引用）
    [Export] 
    private NodePath _spritePath;
    
    private Sprite2D _sprite;
    
    public override void _Ready()
    {
        _sprite = GetNode<Sprite2D>(_spritePath);
    }
}
```

### 3.3 命名空间与Godot的特殊性

#### 3.3.1 命名空间使用

传统C#项目:

```csharp
namespace MyGame.Core
{
    public class GameManager
    {
        // 类实现
    }
}

namespace MyGame.UI
{
    using MyGame.Core;
    
    public class GameUI
    {
        private GameManager _manager;
    }
}
```

Godot中的常见模式:

```csharp
// Godot通常不使用命名空间，因为脚本路径就是标识
// 但可以使用using引入Godot的命名空间

using Godot;
using System.Collections.Generic;

// Godot自动根据文件路径管理类，不需要手动namespace
public partial class Player : CharacterBody2D
{
    // Godot会自动处理类识别
}
```

#### 3.3.2 Godot中的using指令

```csharp
using Godot;                  // Godot核心功能
using Godot.Collections;      // Godot专用集合
using System;                 // C#基础库
using System.Linq;            // LINQ查询
using System.Threading.Tasks; // 异步编程

public partial class AdvancedExample : Node
{
    // 可以使用所有using引入的功能
}
```

### 3.4 Godot中的设计模式与消息传递

#### 3.4.1 观察者模式 - Godot信号系统

Godot信号（推荐）:

```csharp
public partial class Player : CharacterBody2D
{
    [Signal]
    public delegate void HealthChangedEventHandler(int newHealth);
    [Signal]
    public delegate void PlayerDiedEventHandler();
    
    private int _health = 100;
    
    public void TakeDamage(int damage)
    {
        _health -= damage;
        EmitSignal(SignalName.HealthChanged, _health);
        
        if (_health <= 0)
            EmitSignal(SignalName.PlayerDied);
    }
}

// 在其他节点中连接
public partial class UI : Control
{
    public override void _Ready()
    {
        Player player = GetNode<Player>("../Player");
        player.HealthChanged += OnHealthChanged;
        player.PlayerDied += OnPlayerDied;
    }
    
    private void OnHealthChanged(int newHealth)
    {
        // 更新UI
    }
    
    private void OnPlayerDied()
    {
        // 显示游戏结束
    }
}
```

#### 3.4.2 单例模式 - Godot自动加载

创建全局单例:

```csharp
// GameManager.cs - 设置为自动加载单例
public partial class GameManager : Node
{
    public static GameManager Instance { get; private set; }
    
    public int Score { get; private set; }
    public Player CurrentPlayer { get; set; }
    
    public override void _Ready()
    {
        if (Instance == null)
        {
            Instance = this;
        }
        else
        {
            QueueFree(); // 防止重复实例
        }
    }
    
    public void AddScore(int points)
    {
        Score += points;
        // 可以在这里触发全局事件
    }
}

// 在任何地方使用
public partial class Coin : Area2D
{
    public override void _Ready()
    {
        BodyEntered += OnBodyEntered;
    }
    
    private void OnBodyEntered(Node body)
    {
        if (body is Player)
        {
            GameManager.Instance.AddScore(10);
            QueueFree();
        }
    }
}
```

#### 3.4.3 事件总线模式 - 全局消息系统

```csharp
// 全局事件总线
public static class EventBus
{
    public static event Action<string> OnMessage;
    public static event Action<int> OnScoreChanged;
    public static event Action<Player> OnPlayerSpawned;
    
    public static void PublishMessage(string message)
    {
        OnMessage?.Invoke(message);
    }
    
    public static void PublishScoreChanged(int newScore)
    {
        OnScoreChanged?.Invoke(newScore);
    }
    
    public static void PublishPlayerSpawned(Player player)
    {
        OnPlayerSpawned?.Invoke(player);
    }
}

// 发布者
public partial class Enemy : CharacterBody2D
{
    private void Die()
    {
        EventBus.PublishMessage("Enemy defeated!");
        EventBus.PublishScoreChanged(100);
    }
}

// 订阅者
public partial class UI : Control
{
    public override void _Ready()
    {
        EventBus.OnMessage += ShowMessage;
        EventBus.OnScoreChanged += UpdateScoreDisplay;
    }
    
    private void ShowMessage(string message)
    {
        GetNode<Label>("MessageLabel").Text = message;
    }
    
    private void UpdateScoreDisplay(int score)
    {
        GetNode<Label>("ScoreLabel").Text = $"Score: {score}";
    }
}
```

#### 3.4.4 服务定位器模式

```csharp
// 服务容器
public static class ServiceLocator
{
    private static Dictionary<Type, object> _services = new Dictionary<Type, object>();
    
    public static void Register<T>(T service)
    {
        _services[typeof(T)] = service;
    }
    
    public static T Get<T>()
    {
        if (_services.TryGetValue(typeof(T), out object service))
        {
            return (T)service;
        }
        throw new Exception($"Service {typeof(T)} not registered");
    }
    
    public static bool TryGet<T>(out T service)
    {
        if (_services.TryGetValue(typeof(T), out object obj))
        {
            service = (T)obj;
            return true;
        }
        service = default;
        return false;
    }
}

// 注册服务
public partial class AudioManager : Node
{
    public override void _Ready()
    {
        ServiceLocator.Register<AudioManager>(this);
    }
    
    public void PlaySound(string soundName)
    {
        // 播放音效
    }
}

// 使用服务
public partial class Player : CharacterBody2D
{
    public void TakeDamage()
    {
        if (ServiceLocator.TryGet<AudioManager>(out AudioManager audio))
        {
            audio.PlaySound("hurt");
        }
    }
}
```

### 3.5 异步编程对比

#### 3.5.1 Promise vs async/await

TypeScript:

```typescript
function loadData(): Promise<string> {
    return new Promise((resolve) => {
        setTimeout(() => resolve("Data loaded"), 1000);
    });
}

async function initialize(): Promise<void> {
    const data = await loadData();
    console.log(data);
}
```

C#:

```csharp
public async Task<string> LoadDataAsync()
{
    await Task.Delay(1000);
    return "Data loaded";
}

public async Task InitializeAsync()
{
    string data = await LoadDataAsync();
    GD.Print(data);
}

// Godot中的异步（使用Godot的Task）
public async Task LoadSceneAsync(string scenePath)
{
    var sceneLoader = ResourceLoader.LoadThreadedRequest(scenePath);
    
    while (ResourceLoader.LoadThreadedGetStatus(scenePath) == ResourceLoader.ThreadLoadStatus.InProgress)
    {
        await ToSignal(GetTree(), "process_frame");
    }
    
    PackedScene scene = ResourceLoader.LoadThreadedGet(scenePath) as PackedScene;
    AddChild(scene.Instantiate());
}
```
