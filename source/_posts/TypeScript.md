---
title: TypeScript
cover: https://i.loli.net/2020/08/28/NsB9LCacYTlogq5.jpg
date: 2020-09-24 10:15:59
tags: TypeScript
categories: TypeScript
---
# TypeScript

## 1.1 TS简介

TypeScript 是 JavaScript 的强类型版本。然后在编译期去掉类型和特有语法，生成纯粹的 JavaScript 代码。由于最终在浏览器中运行的仍然是 JavaScript，所以 TypeScript 并不依赖于浏览器的支持，也并不会带来兼容性问题。

TypeScript 是 JavaScript 的超集，这意味着他支持所有的 JavaScript 语法。并在此之上对 JavaScript 添加了一些扩展，如 class / interface / module 等。这样会大大提升代码的可阅读性。

和 JavaScript 弱类型不同，TypeScript 这种强类型语言最大的优势在于静态类型检查，可以在代码开发阶段就预知一些低级错误的发生。

- 一种类似于 JavaScript 的语言，在 JavaScript 的基础之上增加了类型，同时增强了 JavaScript 部分语法功能
- 遵循 EcmaScript 6 标准规范
- 由微软开发
- Angular 2 框架采用 TypeScript 编写
- 背后有微软和谷歌两大公司的支持
- TypeScript 可以编译成 JavaScript 从而在支持 JavaScript 的环境中运行
- TypeScript 和 JavaScript 的关系就好比 less 和 css 的关系

TypeScript 中文网     <https://www.tslang.cn/>

在线编译环境              https://www.typescriptlang.org/play/index.html

## 1.2 TS环境搭建

1. 打开命令行，键入`npm i -g typescript` 全局安装TS
2. 继续在命令行环境下键入 `tsc -init` 进行初始化，
   你会发现根目录下多了 tsconfig.json 的文件，记录了编译成JS的选项
3. 创建ts文件
4. 打开VSCode进入该目录，按下 Ctrl+shift+B 快捷键会进行编译，初次编译会选择编译模式
5. 输入node命令运行js代码

## 1.3 变量声明

```typescript
var
- 作用域 : 全局作用域、函数作用域
- 重复声明
- 变量提升

let
- 块级作用域
- 在同一个块中不能重复声明

const
- 声明同时必须赋值
- 一旦声明不可改变（对象可以修改）
- 块级作用域
```

## 1.4 基本数据类型

```typescript
//字符串
var uname:string = "zhangsan";
let nickname: string = '张三';
let isDone: boolean = false;
let age: number = 37;
let sentence: string = `Hello, my nickname is ${ nickname }.

I'll be ${ age + 1 } years old next month.`
```

```typescript
//数组
//TypeScript像JavaScript一样可以操作数组元素。 有两种方式可以定义数组。 第一种，可以在元素类型后面接上[]，表示由此类型元素组成的一个数组：
let list: number[] = [1, 2, 3];

//第二种方式是使用数组泛型，Array<元素类型>：
let list: Array<number> = [1, 2, 3];
```

```javascript
//ts的数组只能存放单一数据类型的元素，元组则可以很好的解决此问题。
//元组类型允许表示一个已知元素数量和类型的数组，各元素的类型不必相同。 比如，你可以定义一对值分别为string和number类型的元组。
// Declare a tuple type
let x: [string, number];
// Initialize it
x = ['hello', 10]; // OK
// Initialize it incorrectly
x = [10, 'hello']; // Error
```

```typescript
//object类型
- 允许赋任意值
- 但是不能调用任意方法，即便它真的有

let foo: object = {
  name: 'Jack',
  age: 18
}

//知道即可，用的很少，没有类型校验和语法提示
```

```javascript
//Any
//有时候，我们会想要为那些在编程阶段还不清楚类型的变量指定一个类型。 这些值可能来自于动态的内容，比如来自用户输入或第三方代码库。 这种情况下，我们不希望类型检查器对这些值进行检查而是直接让它们通过编译阶段的检查。 那么我们可以使用 any类型来标记这些变量：

let notSure: any = 4;
notSure = "maybe a string instead";
notSure = false; // okay, definitely a boolean
```

```javascript
//Void 类型

//void类型像是与any类型相反，它表示没有任何类型。 当一个函数没有返回值时，你通常会见到其返回值类型是 void：

function warnUser(): void {
  alert("This is my warning message");
}

//声明一个void类型的变量没有什么大用，因为你只能为它赋予undefined：
let unusable: void = undefined;
```

```typescript
//Null 和 Undefined
// Not much else we can assign to these variables!
let u: undefined = undefined;
let n: null = null;

//never	
never 是其它类型（包括 null 和 undefined）的子类型，代表从不会出现的值。
let x: never;
let y: number;

// 运行错误，数字类型不能转为 never 类型
x = 123;
// 运行正确，never 类型可以赋值给 never类型
x = (()=>{ throw new Error('exception')})();
// 运行正确，never 类型可以赋值给 数字类型
y = (()=>{ throw new Error('exception')})();
// 返回值为 never 的函数可以是抛出异常的情况
function error(message: string): never {
    throw new Error(message);
}
// 返回值为 never 的函数可以是无法被执行到的终止点的情况
function loop(): never {
    while (true) {}
}
```

```typescript
//类型推断
// 有时候你会遇到这样的情况，你会比TypeScript更了解某个值的详细信息。 通常这会发生在你清楚地知道一个实体具有比它现有类型更确切的类型。

// 通过类型断言这种方式可以告诉编译器，“相信我，我知道自己在干什么”。 类型断言好比其它语言里的类型转换，但是不进行特殊的数据检查和解构。 它没有运行时的影响，只是在编译阶段起作用。 TypeScript会假设你，程序员，已经进行了必须的检查。

// 类型断言有两种形式。 其一是“尖括号”语法：

let someValue: any = true;
let strLength: number = (<string>someValue).length;

//另一个为as语法：
let someValue: any = "this is a string";
let strLength: number = (someValue as string).length;

//两种形式是等价的。 至于使用哪个大多数情况下是凭个人喜好；然而，当你在TypeScript里使用JSX时，只有 as语法断言是被允许的。
```

```typescript
//枚举类型

enum Color {Red, Green, Blue};
let c: Color = Color.Blue;
console.log(c);    // 输出 2
```

## 1.5 解构赋值

```typescript
//数组解构
let input = [1, 2];
let [first, second] = input;
console.log(first); // outputs 1
console.log(second); // outputs 2
```

```typescript
//上面的写法等价于：
first = input[0];
second = input[1];
```

```typescript
//利用解构赋值交换变量：
[first, second] = [second, first];
```

```typescript
//函数参数解构：
//函数参数解构：
function ff([first, second]: [number, number]) { 
  console.log(first)
  console.log(second)
}
ff([1,2])
```

```typescript
//解构剩余参数：
let [first, ...rest] = [1, 2, 3, 4]
console.log(first) // 1
console.log(rest) // [2, 3, 4]
```

```typescript
//也可以忽略其它参数：
let [first] = [1, 2, 3, 4];
console.log(first); // outputs 1
```

```typescript
//或者跳过解构：
let [, second, , fourth] = [1, 2, 3, 4]
```

```typescript
//对象解构
let o = {
    a: "foo",
    b: 12,
    c: "bar"
};
//let { a, b } = o;
//let {a, b}: {a: string, b: number} = o;

//你可以在对象里使用 ... 语法创建剩余变量：
let { a, ...passthrough } = o;
let total = passthrough.b + passthrough.c.length;

//属性解构重命名
//你也可以给属性以不同的名字：
let { a: newName1, b: newName2 } = o;
```

## 1.6 展开操作符 (...)

- 展开数组
- 展开对象

```javascript
let arr1 = [1, 2, 3];
let arr2 = [4, 5, 6];
let arr3 = [...arr1, ...arr2];

let obj1 = { a: 1, b: 2 };
let obj2 = { c: 3 }
let obj3 = { ...obj1, ...obj2 };
console.log(arr3,obj3)
```

## 1.7 函数

```typescript
//函数参数
//参数及返回值类型
//function 函数名字(参数1,参数2,参数3):函数返回值{函数体}
function add(x: number, y: number): number {
    return x + y
}
```

```typescript
//可选参数
function add(x: number, y?: number): number {
    return x + 10
}
```

```typescript
//默认参数
function add(x: number, y: number = 20): number {
    return x + y
}
```

```typescript
//剩余参数
function sum(...args: number[]): number {
    let ret: number = 0
    args.forEach((item: number): void => {
        ret += item
    })
    return ret
}

sum(1, 2, 3)
```

```typescript
//箭头函数
let add = (x: number, y: number): number => x + y
```

```typescript
//函数重载：重载是方法名字相同，而参数不同，返回类型可以相同也可以不同。

//每个重载的方法（或者构造函数）都必须有一个独一无二的参数类型列表。

//参数类型不同：
function disp(string):void; 
function disp(number):void;

//参数数量不同：
function disp(n1:number):void; 
function disp(x:number,y:number):void;

//参数类型顺序不同：
function disp(n1:number,s1:string):void; 
function disp(s:string,n:number):void;
```

## 1.8 联合类型

```typescript
//联合类型（Union Types）可以通过管道(|)将变量设置多种类型，赋值时可以根据设置的类型来赋值。

var val:string|number 
val = 12 
val = "Runoob" 


var arr:number[]|string[]; 
var i:number; 
arr = [1,2,4] 
arr = ["Runoob","Google","Taobao"] 
```

## 1.9 类

### 1.9.1 类的基本使用

```typescript
//基本示例
class Person {
    name: string;
    age: number;
    
    //构造函数
    constructor(name: string, age: number) {
        this.name = name;
        this.age = age;
    }

    sayHello() {
        console.log(this.name);
    }
}

let zs: Person = new Person('张三', 18);
```

### 1.8.2 super关键字的使用

```typescript
//继承
class Animal {
    move(distanceInMeters: number = 0) {
        console.log(`Animal moved ${distanceInMeters}m.`);
    }
}

class Dog extends Animal {
    bark() {
        console.log('Woof! Woof!');
    }
}

const dog = new Dog();
dog.bark();
dog.move(10);
dog.bark();

//这个例子展示了最基本的继承：类从基类中继承了属性和方法。 这里， Dog是一个 派生类，它派生自 Animal 基类，通过 extends关键字。 派生类通常被称作 子类，基类通常被称作 超类。

//因为 Dog继承了 Animal的功能，因此我们可以创建一个 Dog的实例，它能够 bark()和 move()。
```

```typescript
//下面是一个更复杂的例子：
class Animal {
    name: string;
    constructor(theName: string) { 
        this.name = theName; 
    }
    move(distanceInMeters: number = 0) {
        console.log(`${this.name} moved ${distanceInMeters}m.`);
    }
}

class Snake extends Animal {
    constructor(name: string) { 
        super(name); 
    }
    move(distanceInMeters = 5) {
        console.log("Slithering...");
        super.move(distanceInMeters);
    }
}

class Horse extends Animal {
    constructor(name: string) { 
        super(name); 
    }
    move(distanceInMeters = 45) {
        console.log("Galloping...");
        super.move(distanceInMeters);
    }
}

let sam = new Snake("Sammy the Python");
let tom: Animal = new Horse("Tommy the Palomino");

sam.move();
tom.move(34);

//与前一个例子的不同点是，派生类包含了一个构造函数，它 必须调用 super()，它会执行基类的构造函数。 而且，在构造函数里访问 this的属性之前，我们 一定要调用 super()。 这个是TypeScript强制执行的一条重要规则。

//这个例子演示了如何在子类里可以重写父类的方法。 Snake类和 Horse类都创建了 move方法，它们重写了从Animal继承来的 move方法，使得 move方法根据不同的类而具有不同的功能。 注意，即使 tom被声明为Animal类型，但因为它的值是 Horse，调用 tom.move(34)时，它会调用 Horse里重写的方法：

Slithering...
Sammy the Python moved 5m.
Galloping...
Tommy the Palomino moved 34m.
```

### 1.9.3 成员修饰符

```typescript
//public 公共的
class Animal {
    public name: string;
    public constructor(theName: string) { 
        this.name = theName; 
    }
    public move(distanceInMeters: number) {
        console.log(`${this.name} moved ${distanceInMeters}m.`);
    }
}
```

```typescript
//private 私有的
- 不能被外部访问，只能在类的内部访问使用
- 私有成员不会被继承

class Person {
  public name: string;
  public age: number = 18;
  private type: string = 'human'
  public constructor (name:string, age:number) {
    this.name = name
    this.age = age
  }
}
```

```typescript
//protected 受保护的
- 和 private 类似，但是可以被继承

class Person {
    protected name: string;
    constructor(name: string) { 
        this.name = name; 
    }
}

class Employee extends Person {
    private department: string;

    constructor(name: string, department: string) {
        super(name)
        this.department = department;
    }

    public getElevatorPitch() {
        return `Hello, my name is ${this.name} and I work in ${this.department}.`;
    }
}

let howard = new Employee("Howard", "Sales");
console.log(howard.getElevatorPitch());
console.log(howard.name); // 错误

//注意，我们不能在 Person类外使用 name，但是我们仍然可以通过 Employee类的实例方法访问，因为Employee是由 Person派生而来的。
```

### 1.9.4 getter和setter

```javascript
class Person
{
    private _name:string;

    constructor(name: string)
    {
        this._name = name;
    }

    set name(value:string) {this._name = value;}
    get name() {return this._name;}

    talk()
    {
        alert("Hi, my name is " + this.name + "!");
    }
}
```

### 1.9.5 静态成员

- 不需要实例化访问的成员称之为静态成员，即只能被类访问的成员
- `static` 关键字

```typescript
class Person {
    //静态变量
    static country = "中国";
    //京塔方法
    static sayhello() { 
        console.log("hello")
    }
    constructor () { }
}

let p1 = new Person();  
let p2 = new Person(); 

console.log(Person.country)  //静态变量，直接通过类型来访问
console.log(p1.country) //错误
```

## 1.10 接口

在面向对象编程中，接口是一种规范的定义，它定义了行为和动作规范，起到一种限制和规范的作用。
接口不关心状态数据，也不关心方法的实现细节，它只规定了一些属性和方法，而实现接口的类必须提供具体的信息。

### 1.10.1 接口对类的规范

```typescript
//定义一个人的接口
interface Human {
    name: string;
    age: number;
    say(word: string): void;
}

//让老师类实现Human接口，老师类实现接口的时候必须提供接口的具体信息
class Teacher implements Human{
    name = "老师";
    age = 38;
    say(word: string): void {
        console.log("老师说"+word)
    }
}

//让学生类实现Human接口，学生类实现接口的时候必须提供接口的具体信息
class Student implements Human{
    name = "学生";
    age = 18;
    say(word: string): void {
         console.log("学生说"+word)
    }
}
```

### 1.10.2 接口对对象的规范

TypeScript 中的接口除了可用于对类的一部分行为进行抽象以外，也常用于对对象的形状（Shape）进行描述

```javascript
interface Shape {
    head: string;
    arm: string;
}
interface Person {
    name: string;
    age: number;
    shape: Shape;
    say(word: string): void;
}

let jack: Person = {
    name: 'Jack',
    age: 18,
    shape: {
        head: 'head',
        arm: 'arm'
    },
    say(word: string) {
        console.log(word)
    }
}
jack.say('hi')
```

### 1.10.3 接口可选属性

接口里的属性不全都是必需的。 有些是只在某些条件下存在，或者根本不存在。 可选属性在应用“option bags”模式时很常用，即给函数传入的参数对象中只有部分属性赋值了。

```typescript
interface Person {
    gender: string,
    age?: number
}

let jack: Person = {
    gender: 'Male'
    // 可以不赋值 age 属性，因为是可选的
}
```

### 1.10.4 接口只读属性

一些对象属性只能在对象刚刚创建的时候修改其值。 你可以在属性名前用 `readonly`来指定只读属性:

```typescript
interface Person {
    readonly name: string
}

let jack: Person = {
    name: 'Jack'
}

jack.name = 'Ivan' // 报错: name 是只读的
```

`readonly` vs `const`

- 常量使用 const
- 对象属性使用 readonly

### 1.10.5 函数接口

因为函数也是对象，所以我们也可以通过接口来对函数做“规定”。

```javascript
interface Fn {
    (a: number, b: number): number;
}

let add: Fn = function(a: number, b: number): number {
    return a + b
}

console.log(add(1, 2))
```

### 1.10.6 接口继承

就像 ES6 的 class 一样，接口也可以做继承操作，效果就是会继承父接口的“规定”。

```javascript
interface Animal {
    move(): void;
}

interface Human extends Animal {
    name: string;
    age: number;
}

let jack: Human = {
    age: 18,
    name: 'Jack',
    move() {
        console.log('move')
    }
}
```

## 1.11 命名空间

```typescript
//命名空间就是内部模块，目的就是解决重名问题。


//a.ts  声明命名空间
//TypeScript 的命名空间只对外暴露需要在外部访问的对象，命名空间内的对象通过 export 关键字对外暴露
namespace Utils {
  export interface IPerson {
      name: string;
      age: number;
  }
}

//my.ts  使用命名空间
// reference 引用命名空间(可以加也可以不加)
/// <reference path="a.ts" />

const me: Utils.IPerson = {
  name: 'funlee',
  age: 18
}

console.log(me); // {name: 'funlee', age: 18}
```

## 1.12 模块

模块是在其自身的作用域里执行，并不是在全局作用域，这意味着定义在模块里面的变量、函数和类等在模块外部是不可见的，除非明确地使用 export 导出它们。类似地，我们必须通过 import 导入其他模块导出的变量、函数、类等。

两个模块之间的关系是通过在文件级别上使用 import 和 export 建立的(其实就是ES6的模块化语法)

```typescript
//导出模块
export var num = 123;
export var str = "你好";
export function say(){};

var title = "标题";
export default title;


//引入模块
import title,{num,str,say} from './a'
console.log(title,str,say)
```

## 1.13 声明文件

> d.ts为声明文件  主要用作类型的声明

- 在d.ts使用了declare，表示全局声明类型，需要结合tsconfig.json一起使用才能
  有效果。 (使用方式：类似于命名空间)
- 或者使用export的方式，在普通ts中将d.ts导入(使用方式：类似于模块)

```typescript
//data.d.ts    注意：只有声明没有实现

//声明一个类型
declare type StringFunc = () => string;

//声明一个命名空间
declare namespace API {
  //导出CurrentUser接口类型
  export interface CurrentUser {
    avatar?: string;
    name?: string;
    title?: string;
  }
}
```

## 1.14 例子

写出下列ts代码的含义：

```typescript
//导出一个函数 函数名字是defineConfig，函数参数是config，参数类型是IConfigFromPlugins或者IConfig，返回值是IConfigFromPlugins或者IConfig
export declare function defineConfig(config: IConfigFromPlugins | IConfig): IConfigFromPlugins | IConfig;

//声明一个类型叫OverlayFunc，该类型是一个函数，该函数的返回值是ReactNode
declare type OverlayFunc = () => React.ReactNode;

//导出一个类型，该类型叫SiderTheme，他的值是light或者dark
export type SiderTheme = 'light' | 'dark';

//声明一个常量，名字叫columns，他的类型是ProColumns的数组，数组中的元素是TableListItem
const columns: ProColumns<TableListItem>[] = []

//声明一个常量，名字叫LoginMessage，他的类型是React.FC，React.FC中接收{content: string}类型的数据。LoginMessage的值是一个箭头函数，该函数通过解构赋值或者content作为函数的入参，函数没有返回值
const LoginMessage: React.FC<{
  content: string;
}> = ({ content }) => ()

//type的 | 和 &
type Env1 = 'prod' | 'test' | 'dev';
type Env2 = 'prod' | 'boe' | 'ppe';

type EnvUnion = Env1 | Env2; // 'prod' | 'test' | 'dev' | 'boe' | 'ppe'  取并集
type EnvInter = Env1 & Env2; // 'prod'   取交集


//声明一个类型叫Partial，主要作用就是将T中的每一个键可选
type Partial<T> = {
  [P in keyof T]?: T[P];
};


//声明一个类型叫Pick 主要作用选择T中的符合条件的属性
//https://blog.csdn.net/weixin_34376986/article/details/93167453
type Pick<T, K extends keyof T> = {
    [P in K]: T[P];
};
                 
//判断T是不是继承U，如果是则取never类型，否则取T类型本身
type Exclude<T, U> = T extends U ? never : T;

//判断T是不是继承U，如果是则取T类型，否则取never类型
type Extract<T, U> = T extends U ? T : never;
          
//Omit 主要作用 选择T中除了K之外的其他属性          
type Omit<T, K extends keyof any> = Pick<T, Exclude<keyof T, K>>;

//声明一个常量REACT_APP_ENV，他的值是test  dev  pre 或者false中的任意一个
declare const REACT_APP_ENV: 'test' | 'dev' | 'pre' | false;
```

