---
title: umi&dva
date: 2020-10-7 09:08:38
cover: https://i.loli.net/2020/11/10/C2ulUhSJYHObRM7.png
categories: React
tags: 
  - umi
  - dva
---

# 1. Umi介绍

## 1.1 Umi是什么

<https://umijs.org/zh-CN/docs>   

一套可插拔的企业级 react 应用框架，由dva作者 sorrycc 完成，它既是一个框架也是一个工具。

Umi 以路由为基础的，同时支持配置式路由和约定式路由，保证路由的功能完备，并以此进行功能扩展。然后配以生命周期完善的插件体系，覆盖从源码到构建产物的每个生命周期，支持各种功能扩展和业务需求。

他在Umi中引入了 UI 工具 antd，打包工具 roadhog，路由 react-router和状态管理器 dva，做到了可插拔机制。通过约定、自动生成和解析代码等方式来辅助开发，减少开发者要写的代码量。

> **它主要具备以下功能：**

- **可扩展**，Umi 实现了完整的生命周期，并使其插件化，Umi 内部功能也全由插件完成。此外还支持插件和插件集，以满足功能和垂直域的分层需求。
-  **开箱即用**，Umi 内置了路由、构建、部署、测试等，仅需一个依赖即可上手开发。并且还提供针对 React 的集成插件集，内涵丰富的功能，可满足日常 80% 的开发需求。
-  **企业级**，经蚂蚁内部 3000+ 项目以及阿里、优酷、网易、飞猪、口碑等公司项目的验证，值得信赖。
- **大量自研**，包含微前端、组件打包、文档工具、请求库、hooks 库、数据流等，满足日常项目的周边需求。
-  **完备路由**，同时支持配置式路由和约定式路由，同时保持功能的完备性，比如动态路由、嵌套路由、权限路由等等。
-  **面向未来**，在满足需求的同时，我们也不会停止对新技术的探索。比如 dll 提速、modern mode、webpack@5、自动化 external、bundler less 等等。

> **为什么不是？[create-react-app](https://github.com/facebook/create-react-app)**

create-react-app 是基于 webpack 的打包层方案，包含 build、dev、lint 等，他在打包层把体验做到了极致，但是不包含路由，不是框架，也不支持配置。所以，如果大家想基于他修改部分配置，或者希望在打包层之外也做技术收敛时，就会遇到困难。

> **什么时候不用 umi？**

如果你，

- 需要支持 IE 8 或更低版本的浏览器
- 需要支持 React 16.8.0 以下的 React
- 需要跑在 Node 10 以下的环境中
- 有很强的 webpack 自定义需求和主观意愿
- 需要选择不同的路由方案

Umi 可能不适合你。

## 1.2 Umi 如何工作

写写 Umi 背后的思考和重要概念。

### 1.2.1 技术收敛

![1601014995473](https://i.loli.net/2020/11/03/B7RONxakU4Zny2L.png)

这张图是给内部框架 Bigfish 画的，套到 Umi 上同样合适。他把大家常用的技术栈进行整理，收敛到一起，让大家只用 Umi 就可以完成 80% 的日常工作。

### 1.2.2 插件和插件集

![1601015019180](https://i.loli.net/2020/11/03/AsTaIDd92cBoxMw.png)

Umi 支持插件和插件集，通过这张图应该很好理解到他们的关系，通过插件集我们把插件收敛依赖然后支持不同的业务类型。

比如@umijs/preset-react就是一个Umi的插件集，里面整合了一些常用功能。

- [plugin-access](https://umijs.org/zh-CN/plugins/plugin-access)，权限管理
- [plugin-analytics](https://umijs.org/zh-CN/plugins/plugin-analytics)，统计管理
- [plugin-antd](https://umijs.org/zh-CN/plugins/plugin-antd)，整合 antd UI 组件
- [plugin-crossorigin](https://umijs.org/zh-CN/plugins/plugin-crossorigin)，通常用于 JS 出错统计
- [plugin-dva](https://umijs.org/zh-CN/plugins/plugin-dva)，整合 dva
- [plugin-helmet](https://umijs.org/zh-CN/plugins/plugin-helmet)，整合 [react-helmet](https://github.com/nfl/react-helmet)，管理 HTML 文档标签（如标题、描述等）
- [plugin-initial-state](https://umijs.org/zh-CN/plugins/plugin-initial-state)，初始化数据管理
- [plugin-layout](https://umijs.org/zh-CN/plugins/plugin-layout)，配置启用 ant-design-pro 的布局
- [plugin-locale](https://umijs.org/zh-CN/plugins/plugin-locale)，国际化能力
- [plugin-model](https://umijs.org/zh-CN/plugins/plugin-model)，基于 hooks 的简易数据流
- [plugin-request](https://umijs.org/zh-CN/plugins/plugin-request)，基于 umi-request 和 umi-hooks 的请求方案

### 1.2.3 配置式路由和约定式路由

Umi 的路由既支持配置式，又支持约定式。配置式是对于现实的低头，也是大部分用户在用的，因为他功能强大；约定式是我们希望走去的方向，因为他简洁优雅。

### 1.2.4 .umi 临时文件

.umi 临时目录是整个 Umi 项目的发动机，你的入口文件、路由等等都在这里，这些是由 umi 内部插件及三方插件生成的。

你通常会在 .umi 下看到以下目录，

```
+ .umi
  + core     # 内部插件生成
  + pluginA  # 外部插件生成
  + presetB  # 外部插件生成
  + umi.ts   # 入口文件
```

临时文件是 Umi 框架中非常重要的一部分，框架或插件会根据你的代码生成临时文件，这些原来需要放在项目里的脏乱差的部分都被藏在了这里。

你可以在这里调试代码，但不要在 .git 仓库里提交他，因为他的临时性，每次启动 umi 时都会被删除并重新生成。

# 2. Umi3的使用

## 2.1  安装Umi创建项目

```jsx
$ yarn global add umi@3.2.23
$ umi -v
3.2.23
```

```jsx
$ mkdir myapp && cd myapp
$ yarn create umi
```

![1573453772780](https://i.loli.net/2020/11/03/3C7eyf5ipj2rVUZ.png)

![1573453795170](https://i.loli.net/2020/11/03/RTlk5Cxa1t4smph.png)

![1601014079199](https://i.loli.net/2020/11/03/vbmaTHMpRI3DtL7.png)

## 2.2 升级到Umi3

```javascript
1. 删除package.json中 dva 和 antd 的依赖 (Umi3中已经包含这两个依赖)

2. 修改package.json中umi的包的版本号
   "umi": "^3.0.0",

3. 删除package.json中 umi-plugin-react 依赖，新增umijs/preset-react 依赖
   "@umijs/preset-react": "^1",
       
4. 修改package.json中的node环境要求
   "node": ">=10.13.0"

5. tsconfig.json中的paths新增如下：
   "@@/*": ["src/.umi/*"]

6. 修改 .umirc.ts文件
    //引入umi中的配置文件的类型 ts中要用
    import { defineConfig } from 'umi';
	let path = require('path');

    // ref: https://umijs.org/config/
    export default defineConfig({
      //路由配置
      routes: [
        {
          path: '/',
          //注意：这边文件的路径是相对于src/.mui中来确定的
          component: '../layouts/index',
          routes: [
            { 
              path: '/', 
              component: '../pages/index' 
            }
          ]
        }
      ],
      //启用antd插件
      //每个插件都会对应一个 id 和一个 key，id 是路径的简写，key 是进一步简化后用于配置的唯一值。
      //比如插件 /node_modules/@umijs/plugin-antd ,id 为 @umijs/plugin-antd，key 为 antd。
      antd: { },
      //启用dva插件
      dva: {
        hmr: true,  //启用dva model的热更新
      },
      //启用loacle插件  配置之后才可以使用useIntl 
      locale: {
        //默认的语言环境
        default: 'zh-CN',
        //antd开启国际化
        antd: true, 
        // default true, when it is true, will use `navigator.language` overwrite default
        baseNavigator: false,
      },
      // 浏览器兼容
      targets: {
        ie: 11
      },
      // 开启文件hash后缀
      hash: true,
      // 启用 Hash 路由
      history: {
        type: 'hash'
      },
      // Theme for antd: https://ant.design/docs/react/customize-theme-cn
      theme: {
        // ...darkTheme,
        // 主要颜色,
        'font-size-base': '34px'
      },
      //配置按需加载   即是否把构建产物进行拆分，在需要的时候下载额外的 JS 再执行。
      dynamicImport: {},
      // 指定react-router的base，部署到根目录时需要配置
      base:'/',
      // 指定webpack的publicPath，指向静态资源文件所在的路径
      publicPath:'./',
      // DefinePlugin 全局常量定义
      define: { },
      // 代理配置
      proxy: {
        // '/api': {
        //   target: 'http://127.0.0.1:10000/',
        //   changeOrigin: true,
        //   pathRewrite: { '^/api': '' }
        // }
      },
      // 别名
      alias: {
        '@': path.resolve(__dirname, 'src')
      }
    })

7. 注释掉 app.ts中的const dva 代码
    /*
    export const dva = {
      config: {
        onError(err: ErrorEvent) {
          err.preventDefault();
          console.error(err.message);
        },
      },
    };
    */

8. 修改pages/index.tsx
    //useIntl 国际化的api
    import { useIntl } from 'umi';

    <a href="https://umijs.org/guide/getting-started.html">
        {useIntl().formatMessage({ id: 'index.start' })}
    </a>
```

## 2.3 运行项目

```jsx
//然后安装依赖
$ yarn

//然后启动应用
$ yarn start
```

几秒钟后，你会看到以下输出，

```jsx
 DONE  Compiled successfully in 212ms

  App running at:
  - Local:   http://localhost:8000/
  - Network: http://{{ YourIP }}:8000/
```

在浏览器里打开 [http://localhost:8000](http://localhost:8000/)，你会看到 umi 的欢迎界面。

![img](https://i.loli.net/2020/11/03/2kvGAwIRglafLX9.png)



## 2.4 目录结构介绍

![1601020141915](https://i.loli.net/2020/11/03/3wlgZrYOmbpd9tB.png)



## 2.5 配置文件介绍

### 2.5.1 .editorconfig 

该文件是配置编辑器的一些设置，这里我修改了一个缩进，indent_size = 4。因为个人比较喜欢4个缩进，看着舒服。

### 2.5.2 .env

该文件是项目环境配置文件，默认的是BROWSER=none，这时候项目启动后，浏览器不会自动打开。

### 2.5.3 .eslintrc 

多人开发时候，一套良好的代码规范是非常必要的。这里配置了一份基础eslint文件，供参考。

```jsx
{
  "env": {
    "es6": true,
    "node": true,
    "browser": true,
    "mocha": true
  },
  "extends": [
    "eslint:recommended",
    "react-app"
  ],
  "rules": {
    "strict": "error",
    //"indent": ["error", 4, { "SwitchCase": 1 }],
    "eqeqeq": "error",
    "no-lone-blocks": "error",
    "no-lonely-if": "error",
    "no-multi-spaces": "error",
    "no-multiple-empty-lines": [
      "error",
      {
        "max": 2
      }
    ],
    "no-param-reassign": "error",
    "no-spaced-func": "error",
    "no-use-before-define": "warn",
    "no-unused-vars": "warn",
    "no-with": "error",
    "default-case": "error",
    "key-spacing": [
      "error",
      {
        "beforeColon": false,
        "afterColon": true
      }
    ],
    "comma-spacing": [
      "error",
      {
        "before": false,
        "after": true
      }
    ],
    "generator-star-spacing": [
      "error",
      {
        "before": true,
        "after": false
      }
    ],
    "semi": [
      "warn",
      "always",
      {
        "omitLastInOneLineBlock": true
      }
    ],
    "no-restricted-globals": "off",
    "array-callback-return": "off",
    "no-console": [
      "warn",
      {
        "allow": [
          "info",
          "warn",
          "error",
          "time",
          "timeEnd"
        ]
      }
    ],
    "react/react-in-jsx-scope": "warn"
  }
}
```

### 2.5.3 .umirc

.umirc为Umi项目的配置文件，.umirc.js 和 config/config.js二选一

### 2.5.4 tsconfig.json

typescript的配置文件，可以配置ts编译的一些特征

https://www.jianshu.com/p/78dcb09dac2c

```javascript
//tsconfig.json 对象类型的索引签名隐式具有"any"类型 报错
"suppressImplicitAnyIndexErrors":true,
```

```javascript
{
  "compilerOptions": {
    /* Basic Options */
    "target": "es5" /* target用于指定编译之后的版本目标: 'ES3' (default), 'ES5', 'ES2015', 'ES2016', 'ES2017', 'ES2018', 'ES2019' or 'ESNEXT'. */,
    "module": "commonjs" /* 用来指定要使用的模块标准: 'none', 'commonjs', 'amd', 'system', 'umd', 'es2015', or 'ESNext'. */,
    "lib": ["es6", "dom"] /* lib用于指定要包含在编译中的库文件 */,
    "allowJs": true,                       /* allowJs设置的值为true或false，用来指定是否允许编译js文件，默认是false，即不编译js文件 */
    "checkJs": true,                       /* checkJs的值为true或false，用来指定是否检查和报告js文件中的错误，默认是false */
    "jsx": "preserve",                     /* 指定jsx代码用于的开发环境: 'preserve', 'react-native', or 'react'. */
    "declaration": true,                   /* declaration的值为true或false，用来指定是否在编译的时候生成相应的".d.ts"声明文件。如果设为true，编译每个ts文件之后会生成一个js文件和一个声明文件。但是declaration和allowJs不能同时设为true */
    "declarationMap": true,                /* 值为true或false，指定是否为声明文件.d.ts生成map文件 */
    "sourceMap": true,                     /* sourceMap的值为true或false，用来指定编译时是否生成.map文件 */
    "outFile": "./",                       /* outFile用于指定将输出文件合并为一个文件，它的值为一个文件路径名。比如设置为"./dist/main.js"，则输出的文件为一个main.js文件。但是要注意，只有设置module的值为amd和system模块时才支持这个配置 */
    "outDir": "./",                        /* outDir用来指定输出文件夹，值为一个文件夹路径字符串，输出的文件都将放置在这个文件夹 */
    "rootDir": "./",                       /* 用来指定编译文件的根目录，编译器会在根目录查找入口文件，如果编译器发现以rootDir的值作为根目录查找入口文件并不会把所有文件加载进去的话会报错，但是不会停止编译 */
    "composite": true,                     /* 是否编译构建引用项目  */
    "incremental": true,                   /* Enable incremental compilation */
    "tsBuildInfoFile": "./",               /* Specify file to store incremental compilation information */
    "removeComments": true,                /* removeComments的值为true或false，用于指定是否将编译后的文件中的注释删掉，设为true的话即删掉注释，默认为false */
    "noEmit": true,                        /* 不生成编译文件，这个一般比较少用 */
    "importHelpers": true,                 /* importHelpers的值为true或false，指定是否引入tslib里的辅助工具函数，默认为false */
    "downlevelIteration": true,            /* 当target为'ES5' or 'ES3'时，为'for-of', spread, and destructuring'中的迭代器提供完全支持 */
    "isolatedModules": true,               /* isolatedModules的值为true或false，指定是否将每个文件作为单独的模块，默认为true，它不可以和declaration同时设定 */

    /* Strict Type-Checking Options */
    "strict": true /* strict的值为true或false，用于指定是否启动所有类型检查，如果设为true则会同时开启下面这几个严格类型检查，默认为false */,
    "noImplicitAny": true,                 /* noImplicitAny的值为true或false，如果我们没有为一些值设置明确的类型，编译器会默认认为这个值为any，如果noImplicitAny的值为true的话。则没有明确的类型会报错。默认值为false */
    "strictNullChecks": true,              /* strictNullChecks为true时，null和undefined值不能赋给非这两种类型的值，别的类型也不能赋给他们，除了any类型。还有个例外就是undefined可以赋值给void类型 */
    "strictFunctionTypes": true,           /* strictFunctionTypes的值为true或false，用于指定是否使用函数参数双向协变检查 */
    "strictBindCallApply": true,           /* 设为true后会对bind、call和apply绑定的方法的参数的检测是严格检测的 */
    "strictPropertyInitialization": true,  /* 设为true后会检查类的非undefined属性是否已经在构造函数里初始化，如果要开启这项，需要同时开启strictNullChecks，默认为false */
   "noImplicitThis": true,                /* 当this表达式的值为any类型的时候，生成一个错误 */
    "alwaysStrict": true,                  /* alwaysStrict的值为true或false，指定始终以严格模式检查每个模块，并且在编译之后的js文件中加入"use strict"字符串，用来告诉浏览器该js为严格模式 */

    /* Additional Checks */
    "noUnusedLocals": true,                /* 用于检查是否有定义了但是没有使用的变量，对于这一点的检测，使用eslint可以在你书写代码的时候做提示，你可以配合使用。它的默认值为false */
    "noUnusedParameters": true,            /* 用于检查是否有在函数体中没有使用的参数，这个也可以配合eslint来做检查，默认为false */
    "noImplicitReturns": true,             /* 用于检查函数是否有返回值，设为true后，如果函数没有返回值则会提示，默认为false */
    "noFallthroughCasesInSwitch": true,    /* 用于检查switch中是否有case没有使用break跳出switch，默认为false */

    /* Module Resolution Options */
    "moduleResolution": "node",            /* 用于选择模块解析策略，有'node'和'classic'两种类型' */
    "baseUrl": "./",                       /* baseUrl用于设置解析非相对模块名称的基本目录，相对模块不会受baseUrl的影响 */
    "paths": {},                           /* 用于设置模块名称到基于baseUrl的路径映射 */
    "rootDirs": [],                        /* rootDirs可以指定一个路径列表，在构建时编译器会将这个路径列表中的路径的内容都放到一个文件夹中 */
    "typeRoots": [],                       /* typeRoots用来指定声明文件或文件夹的路径列表，如果指定了此项，则只有在这里列出的声明文件才会被加载 */
    "types": [],                           /* types用来指定需要包含的模块，只有在这里列出的模块的声明文件才会被加载进来 */
    "allowSyntheticDefaultImports": true,  /* 用来指定允许从没有默认导出的模块中默认导入 */
    "esModuleInterop": true /* 通过为导入内容创建命名空间，实现CommonJS和ES模块之间的互操作性 */,
    "preserveSymlinks": true,              /* 不把符号链接解析为其真实路径，具体可以了解下webpack和nodejs的symlink相关知识 */

    /* Source Map Options */
    "sourceRoot": "",                      /* sourceRoot用于指定调试器应该找到TypeScript文件而不是源文件位置，这个值会被写进.map文件里 */
    "mapRoot": "",                         /* mapRoot用于指定调试器找到映射文件而非生成文件的位置，指定map文件的根路径，该选项会影响.map文件中的sources属性 */
    "inlineSourceMap": true,               /* 指定是否将map文件的内容和js文件编译在同一个js文件中，如果设为true，则map的内容会以//# sourceMappingURL=然后拼接base64字符串的形式插入在js文件底部 */
    "inlineSources": true,                 /* 用于指定是否进一步将.ts文件的内容也包含到输入文件中 */

    /* Experimental Options */
    "experimentalDecorators": true /* 用于指定是否启用实验性的装饰器特性 */
    "emitDecoratorMetadata": true,         /* 用于指定是否为装饰器提供元数据支持，关于元数据，也是ES6的新标准，可以通过Reflect提供的静态方法获取元数据，如果需要使用Reflect的一些方法，需要引入ES2015.Reflect这个库 */
  }
  "files": [], // files可以配置一个数组列表，里面包含指定文件的相对或绝对路径，编译器在编译的时候只会编译包含在files中列出的文件，如果不指定，则取决于有没有设置include选项，如果没有include选项，则默认会编译根目录以及所有子目录中的文件。这里列出的路径必须是指定文件，而不是某个文件夹，而且不能使用* ? **/ 等通配符
  "include": [],  // include也可以指定要编译的路径列表，但是和files的区别在于，这里的路径可以是文件夹，也可以是文件，可以使用相对和绝对路径，而且可以使用通配符，比如"./src"即表示要编译src文件夹下的所有文件以及子文件夹的文件
  "exclude": [],  // exclude表示要排除的、不编译的文件，它也可以指定一个列表，规则和include一样，可以是文件或文件夹，可以是相对路径或绝对路径，可以使用通配符
  "extends": "",   // extends可以通过指定一个其他的tsconfig.json文件路径，来继承这个配置文件里的配置，继承来的文件的配置会覆盖当前文件定义的配置。TS在3.2版本开始，支持继承一个来自Node.js包的tsconfig.json配置文件
  "compileOnSave": true,  // compileOnSave的值是true或false，如果设为true，在我们编辑了项目中的文件保存的时候，编辑器会根据tsconfig.json中的配置重新生成文件，不过这个要编辑器支持
  "references": [],  // 一个对象数组，指定要引用的项目
}
```

## 2.6 路由和页面跳转

### 2.6.1 新建路由

```javascript
//1.敲入命令如下
$   umi g page product/index --typescript --less

   create src/pages/product/index.js
   create src/pages/product/index.less
✔  success

//2.修改 .umirc.ts文件中路由配置
  routes: [
    {
      path: '/',
      //注意：路径如果是相对路径，会从 src/pages 开始找起。如果指向 src 目录的文件，可以用 @，也可以用 ../。比如 component: '@/layouts/basic'
      //注意：这里不会生成exact:true的配置
      component: '../layouts/index',
      routes: [
        {
          path: '/product/index',
          component: '../pages/product/index',
        },
        { 
          path: '/', 
          component: '../pages/index' 
        }
      ]
    }
  ],

//3.在src目录下创建typings.d.ts 文件 
//模块声明文件：不写在引入less的时候ts会警告
declare module 'slash2';
declare module '*.css';
declare module '*.less';
declare module '*.scss';
declare module '*.sass';
declare module '*.svg';
declare module '*.png';
declare module '*.jpg';
declare module '*.jpeg';
declare module '*.gif';
declare module '*.bmp';
declare module '*.tiff';
declare module 'omit.js';
```

### 2.6.2 约定式路由

除配置式路由外，Umi 也支持约定式路由。约定式路由也叫文件路由，就是不需要手写配置，文件系统即路由，通过目录和文件及其命名分析出路由配置。

**如果没有 routes 配置，Umi 会进入约定式路由模式**，然后分析 `src/pages` 目录拿到路由配置。

比如以下文件结构：

```
.
  └── pages
    ├── index.tsx
    └── users.tsx
```

会得到以下路由配置，

```
[
  { exact: true, path: '/', component: '@/pages/index' },
  { exact: true, path: '/users', component: '@/pages/users' },
]
```

需要注意的是，满足以下任意规则的文件不会被注册为路由，

- 以 `.` 或 `_` 开头的文件或目录
- 以 `d.ts` 结尾的类型定义文件
- 以 `test.ts`、`spec.ts`、`e2e.ts` 结尾的测试文件（适用于 `.js`、`.jsx` 和 `.tsx` 文件）
- `components` 和 `component` 目录
- `utils` 和 `util` 目录
- 不是 `.js`、`.jsx`、`.ts` 或 `.tsx` 文件
- 文件内容不包含 JSX 元素



**所以当我们把.umirc.js中的routes配置注释掉的时候，访问路径<http://localhost:8000/#/product>能够正常展示页面。**

### 2.6.3 路由配置

```javascript
component: '@/layouts/index'         //配置页面模板，不同的路由可以配置不同的layout
{ path: '/one', exact: true }        //严格匹配，location 是否和 path 完全对应上

//配置子路由
routes: [
        { path: '/list', component: 'list' },
        { path: '/admin', component: 'admin' },
],

//重定向
{
    path: '*',
    redirect: '/'
}


 /**
   * 路由配置注意点：
   * 1.{path:"",component:"",routes:[{path:"",component:""}]}
   *   第一层的配置一般用来配置页面布局文件，我们不需要给它加exact:true，否则会导致routes里面的规则不能够被加载
   *   routes里面的规则用来配置具体路由,我们也不需要给它加exact:true，因为会默认生成
   * 2.一般我们不会这样写 {path:"/product",component:"@/pages/index"}，还是会在每一个页面的上层套一个布局文件。
   *   如果我们这样写，那么会和第一种写法冲突，因为我们在访问localhost:8000/product的时候也会匹配localhost:8000/，从而导致/product路径不能匹配
   * 3.使用路径的时候，如果是相对路径，则参照pages目录来的。如果想要引用layout文件的中的组件，可以使用@符号，@ 符号表示src目录
   *
   * */
```

### 2.6.4 路由跳转和传参

```javascript
import { Link } from 'umi';
export default () => (
  <div>
    <Link to="/users">Users Page</Link>
  </div>
);
```

```javascript
import { history } from 'umi';
// 跳转到指定路由
history.push('/list');
// 带参数跳转到指定路由
history.push('/list?a=b');
history.push({
  pathname: '/list',
  state: {
    a: 'b',
  },
});
// 跳转到上一个路由
history.goBack();
```

```javascript
//路由组件可通过 props 获取到以下属性，

match，当前路由和 url match 后的对象，包含 params、path、url 和 isExact 属性
location，表示应用当前出于哪个位置，包含 pathname、search、query 等属性
history，同 api history 接口
route，当前路由配置，包含 path、exact、component、routes 等
routes，全部路由信息
```

### 2.6.5 动态路由参数  

```typescript
//1.新建productDetail/index/[id].tsx

import React from 'react';
import styles from './productDetail.less';

//要从props中获取location history match等参数，需要引入RouteComponentProps类型
import { RouteComponentProps } from 'react-router-dom';

interface RouterInfo {
  id: string;
}

export default (props: RouteComponentProps<RouterInfo>) => {
  return (
    <div>
      <h1 className={styles.title}>Page productDetail/index ---{props.match.params.id}</h1>
    </div>
  );
};

//2.修改.umirc.ts
routes: [
    {
      path: '/',
      //注意：这边文件的路径是相对于src/.mui中来确定的
      component: '../layouts/index',
      routes: [
        {
          path: '/product/index',
          component: '../pages/product/index',
        },
        { 
          path: '/productDetail/:id', 
          component: '../pages/productDetail/index/[id]' 
        },
        { 
          path: '/', 
          component: '../pages/index' 
        }
      ]
    }
  ]
```

## 2.7 样式和资源文件

### 2.7.1 全局样式

Umi 中约定 `src/global.css` 为全局样式，如果存在此文件，会被自动引入到入口文件最前面。

比如用于覆盖样式，

```css
.ant-select-selection {
  max-height: 51px;
  overflow: auto;
}
```

### 2.7.2 CSS Modules

Umi 会自动识别 CSS Modules 的使用，你把他当做 CSS Modules 用时才是 CSS Modules。

比如：

```javascript
// CSS Modules
import styles from './foo.css';

// 非 CSS Modules
import './foo.css';
```

### 2.7.3 CSS 预处理器

Umi 内置支持 less，不支持 sass 和 stylus，但如果有需求，可以通过 chainWebpack 配置或者 Umi 插件的形式支持。

### 2.7.4 ts中使用图片

通过 require 引用相对路径的图片。

比如：

```javascript
export default () => <img src={require('./foo.png')} />
```

支持别名，比如通过 `@` 指向 src 目录：

```javascript
export default () => <img src={require('@/foo.png')} />
```

### 2.7.5 CSS 里使用图片

通过相对路径引用。

比如，

```javascript
.logo {
  background: url(./foo.png);
}
```

CSS 里也支持别名，但需要在前面加 `~` 前缀，

```javascript
.logo {
  background: url(~@/foo.png);
}
```

注意：

1. 这是 webpack 的规则，如果切到其他打包工具，可能会有变化
2. less 中同样适用

### 2.7.6 Base64 编译

通过相对路径引入图片的时候，如果图片小于 10K，会被编译为 Base64，否则会被构建为独立的图片文件。

10K 这个阈值可以通过 [inlineLimit 配置](https://umijs.org/zh-CN/config#inlinelimit)修改。

## 2.8 国际化

@umijs/plugin-locale是umi中的一个国际化插件，用于解决 i18n 问题。

### 2.8.1 开启国际化

```javascript
//在.umirc.ts中配置locale之后即开启该插件
  locale: {
    //默认的语言环境
    default: 'zh-CN',
    //antd开启国际化
    antd: true, 
    // default true, when it is true, will use `navigator.language` overwrite default
    baseNavigator: false,
  },
```

### 2.8.2 约定式多语言支持

比如以下目录，项目就拥有了 `zh-CN` 与 `en-US` 国际化语言切换(文件名必须要符合规范)：

```
+ src
  + locales
    - zh-CN.ts
    - en-US.ts
  + pages
```

### 2.8.3 主要API

```typescript
# getAllLocales 获取当前获得所有国际化文件的列表，默认会在 locales 文件夹下寻找类似 en-US.(js|json|ts) 文件。
import { getAllLocales } from 'umi';
console.log(getAllLocales()); // [en-US,zh-CN,...]

# getLocale 将获得当前选择的语言。
import { getLocale } from 'umi';
console.log(getLocale()); // en-US | zh-CN

# useIntl 是最常用的 api,它可以获得 formatMessage 等 api 来进行具体的值绑定。
import { useIntl } from 'umi';
<a>
	{useIntl().formatMessage({ id: 'index.start' })}
</a>

# setLocale 设置切换语言，默认会刷新页面，可以通过设置第二个参数为 false ，来实现无刷新动态切换。
import { setLocale } from 'umi';
// 刷新页面
setLocale('zh-TW', true);
// 不刷新页面
setLocale('zh-TW', false);
```

# 3.flux和redux

## 3.1 Flux

Flux 是一种架构思想，专门解决软件的结构问题。它跟[MVC 架构](http://www.ruanyifeng.com/blog/2007/11/mvc.html)是同一类东西，但是更加[简单和清晰](http://www.infoq.com/news/2014/05/facebook-mvc-flux)。

首先，Flux将一个应用分成四个部分。

> - **View**： 视图层
> - **Action**（动作）：表示数据从应用程序发送到store的有效信息负载。它是 store 数据的**唯一**来源。一般来说你会通过 Dispatcher派发器将 action 传到 store。
> - **Dispatcher**（派发器）：用来接收Actions、执行回调函数
> - **Store**（数据层）：用来存放应用的状态，一旦发生变动，就提醒Views要更新页面

**Flux 的最大特点，就是数据的"单向流动"。**

> 1. 用户访问 View
> 2. 用户在View中Dispatcher一个Action，要求 Store 进行相应的更新
> 3. Store 更新后，发出一个"change"事件
> 4. View 收到"change"事件后，更新页面

![1553222968163](https://i.loli.net/2020/11/03/9EjkK1pgADicL3e.png)

![1553223019430](https://i.loli.net/2020/11/03/mC1Oh5XYtkM3uLi.png)

## 3.2 Redux

http://cn.redux.js.org/

我们把Flux看做一个框架的理念的话，Redux是Flux的一种实现。Redux是SPA单页面应用程序中多个组件之间共享数据的一种方式。

Flux的基本原则是“单向数据流”，Redux在此基础上强调三个基本原则：

> 1.唯一数据源 ：唯一数据源指的是应用的状态数据应该只存储在唯一的一个Store上。
> 2.保持状态只读 ： 保持状态只读，就是说不能去直接修改状态，要修改Store的状态，必须要通过派发一个action对象完成。
> 3.数据改变只能通过纯函数完成 ：这里所说的纯函数就是把Reducer，Reducer描述了state状态如何修改。Redux这个名字的前三个字母Red代表的就是Reducer，其实Redux名字的含义就是Reducer+Flux。

![](https://i.loli.net/2020/11/03/tbZQaYjVL4PmpC3.png)

## 3.3 dva

### 3.3.1 dva介绍

dva由阿里架构师 sorrycc 带领 team 完成的一套前端框架，dva 是一个基于 [redux](https://github.com/reduxjs/redux) 和 [redux-saga](https://github.com/redux-saga/redux-saga) (异步处理)的数据流方案，然后为了简化开发体验，dva 还额外内置了 [react-router](https://github.com/ReactTraining/react-router) 和 [fetch](https://github.com/github/fetch)，所以也可以理解为一个轻量级的应用框架。

> **特性**

- **易学易用**，仅有 6 个 api，对 redux 用户尤其友好，[配合 umi 使用](https://umijs.org/guide/with-dva.html)后更是降低为 0 API
- **elm 概念**，通过 reducers, effects 和 subscriptions 组织 model。elm是专注web前端的纯函数式语言。
- **插件机制**，比如 [dva-loading](https://github.com/dvajs/dva/tree/master/packages/dva-loading) 可以自动处理 loading 状态，不用一遍遍地写 showLoading 和 hideLoading
- **支持 HMR**，基于 [babel-plugin-dva-hmr](https://github.com/dvajs/babel-plugin-dva-hmr) 实现 components、routes 和 models 的 HMR

### 3.3.2 dva的数据流



![1601034916207](https://i.loli.net/2020/11/03/Y7vxJKX52LFrBSV.png)

用户在 **视图层** 会触发(dispatch)一些动作(action)，这些动作会传递到我们的Model.js 这个文件当中，根据action的名字，找到对用的方法(effect 或者 reducer) ，然后更新state，视图重新渲染。

### 3.3.3 dva核心概念

#### a) model

其中，model 是 DVA 中最重要的概念，基本的属性如下：

- namespace：model 的命名空间，只能用字符串。一个大型应用可能包含多个 model，通过namespace区分。
- state：当前 model 状态的初始值，表示当前状态。
- reducers：用于处理同步操作，可以修改 state，由 action 触发。
- effects：用于处理异步操作（例如：与服务端交互）和业务逻辑，也是由 action 触发。但是，它不可以修改 state，要通过触发 action 调用 reducer 实现对 state 的间接操作。

#### b) connect

连接dva model和react组件，目的是为了让组件获取model中的数据和驱动model改变的方法。

#### c) dispatch

dispatch 函数就是和 dva model 打交道的唯一途径， dispatch 函数接受一个 action对象 作为入参。action对象需要有type字段

#### d) action

action：一个对象，是 reducers 及 effects 的触发器，通过dispatch来触发，action对象需要有type字段

## 3.4 dva实战

### 3.4.1 改造项目结构 

![1601195437274](https://i.loli.net/2020/11/03/lXVsRnyqxHe4iIa.png)

### 3.4.2 mock

#### a) mock介绍

Mock 是高效、易用、功能强大的 api 管理平台,旨在为开发、产品、测试人员提供更优雅的接口管理服务。可以帮助开发者轻松创建、发布、维护 API。主要用于项目的开发测试阶段。

<https://github.com/nuysoft/Mock/wiki>

```javascript
#1. 安装mockjs
yarn add mockjs --dev

#2. 修改.umirc.ts  开启mock
  mock: {}

#3. mock基本使用  
// 在项目mock文件夹下新建user.ts  代码如下
import { Request, Response } from 'express';
import Mock from 'mockjs';

export default {
  //测试mock   mock语法介绍 todos.....
  '/api/test': { id: 1, username: 'kenny', sex: 6 },

  'GET /api/hi': (req: Request, res: Response) => {
    res.json({
      id: 1,
      username: 'jaja',
    });
  },
    
  'GET /api/mock': Mock.mock({
    success: true,
    //随机生成一段中文
    message: '@cparagraph',
    // 属性 list 的值是一个数组，其中含有 1 到 5 个元素
    'list|1-5': [
      {
        // 属性 sid 是一个自增数，起始值为 1，每次增 1
        'sid|+1': 1,
        // 属性 userId 是一个5位的随机码
        'userId|5': '',
      },
    ],
  }),
};
```

#### b) mock/user.js使用mock提供接口数据 

```jsx
import { Request, Response } from 'express';
import Mock from 'mockjs';

interface UserType {
  id: number;
  name: string;
  email: string;
  website: string;
}

const users: UserType[] = [
  { id: 1, name: 'zhangsan', email: 'zhangsan@qq.com', website: 'xx.com' },
  { id: 2, name: 'lisi', email: 'lisi@qq.com', website: 'll.com' },
];

export default {
  //查询所有用户
  'GET /api/users': (req: Request, res: Response) => {
    // 获取参数信息
    var page = req.query.page;
    var data = { list: users, total: 105, page: page };
    res.json(data);
  },

  // GET POST 可省略
  '/api/users/:id': (req: Request, res: Response) => {
    const id = parseInt(req.params.id);
    const u = users.find((item) => {
      if (item.id === id) {
        return item;
      }
    });
    res.json(u);
  },
  
  //根据id删除用户
  '/api/users/delete/:id': (req: Request, res: Response) => {
    const id = parseInt(req.params.id);
    const index = users.findIndex((item) => {
      if (item.id == id) {
        return true;
      }
    });
    users.splice(index, 1);
    res.json({
      status: 200,
      message: '删除成功',
    });
  },

  // 支持自定义函数，API 参考 express@4
  'POST /api/users/create': (req: Request, res: Response) => {
    res.end('OK');
  },
};
```

### 3.4.3 请求的封装 

#### a) fetch和umi-request

**fetch**是es6中推出的一种可替代ajax获取/提交数据的技术，有些高级浏览器已经可以使用window.fecth使用了。相比于使用jQuery.ajax更轻量，而且它支持Promise，更加符合现在的编程习惯。但是，一定记住fetch不是ajax的进一步封装，而是原生js，没有使用XMLHttpRequest对象。

**[umi-request](https://link.zhihu.com/?target=https%3A//github.com/umijs/umi-request)** 是基于 fetch 封装的开源 http 请求库，旨在为开发者提供一个统一的 API 调用方式，同时简化使用方式，提供了请求层常用的功能：

- URL 参数自动序列化
- POST 数据提交方式简化
- Response 返回处理简化
- 请求超时处理
- 请求缓存支持
- GBK 编码处理
- 统一的错误处理方式
- 请求取消支持
- Node 环境 http 请求
- 拦截器机制
- 洋葱中间件机制

**umi-request和fetch和axios区别**

![](https://i.loli.net/2020/11/03/8LAOuYdHnJVBwzb.png)

#### b) app.ts运行时配置

运行时配置文件，可以在这里扩展运行时的能力，比如修改路由、修改 render 方法等。

Umi约定 `src/app.tsx` 为运行时配置。比如我们可以再在 `src/app.ts` 中配置一些运行时的配置项来实现部分自定义需求。示例配置如下：

```typescript
//通知组件
import { notification } from 'antd';
//RequestConfig 请求的配置类型
import { RequestConfig } from 'umi';
import { ResponseError } from 'umi-request';


/**
 * 请求出错后的异常处理程序
 */
const errorHandler = (error: ResponseError) => {
  notification.error({
    description: '您的网络发生异常，无法连接服务器',
    message: '网络异常',
  });
  throw error;
};

//导出请求对象
export const request: RequestConfig = {
  errorHandler,
  requestInterceptors: [
    (url, options) => {
      console.log('请求拦截器');
      return {
        url,
        options,
      };
    },
  ],
  responseInterceptors: [
    (response, options) => {
      console.log('响应拦截器')
      return response;
    },
  ],
};
```

#### c) 封装service

```jsx
//pages/user/services/index.ts
import { request } from 'umi';

export function queryUserList({ page = 1 }) {
  return request(`/api/users?page=${page}`);
}
```

### 3.4.4 新建页面 发送请求

```javascript
//1.创建页面
umi g page user/index --typescript --less

//2.配置路由  .umirc.ts
routes: [
    {
        path: '/',
        //注意：这边文件的路径是相对于src/.mui中来确定的
        component: '../layouts/index',
        routes: [
            { 
                path: '/', 
                component: '../pages/index' 
            },
            { 
                path: '/user', 
                component: '../pages/user/index' 
            }
        ]
    }
],

//3.pages/user/index.tsx
import React, { useEffect } from 'react';
import styles from './index.less';
import { queryUserList } from './services';

export default () => {
  //componentDidMount
  useEffect(() => {
    getUsers();
  }, []);

  //发送请求获取数据
  const getUsers = async () => {
    let result = await queryUserList({ page: 1 });
    console.log(result);
  };

  return (
    <div>
      <h1 className={styles.title}>Page user/index</h1>
    </div>
  );
};
```

### 3.4.5 编写dva model

dva 通过 `model` 的概念把一个领域的模型管理起来，包含同步更新 state 的 reducers，处理异步逻辑的 effects，订阅数据源的 subscriptions 。

好处在于可以统一管理模型数据和把模型数据共享到组件中。

```jsx
// user/models/index.ts

//Effect 异步操作     Reducer  纯函数      Subscription 订阅更新
import { Effect, Reducer, Subscription, Action } from 'umi';
//查询用户的接口
import { queryUserList } from '../services';

export interface UserItem {
  id: number;
  name: string;
  email: string;
  website: string;
}

//声明用户模块state的数据类型  ?表示可有可无
export interface UserModelState {
  list?: UserItem[];
  total?: number;
  page?: number;
}

//声明用户model的数据类型
export interface UserModelType {
  //名称空间
  namespace: 'user';
  //state数据
  state: UserModelState;
  //异步方法
  effects: {
    fetchUserList: Effect;
    removeUserById?: Effect;
  };
  //纯函数
  reducers: {
    save: Reducer<UserModelState>;
    removeById?: Reducer<UserModelState>;
  };
  //订阅更新
  subscriptions?: { setup: Subscription };
}

//声明UserModel
const UserModel: UserModelType = {
  namespace: 'user',
  state: {
    list: [], //所有用户信息的数组
    total: 0, //总用户个数
    page: 0, //当前页码
  },
  //纯函数  操作state
  reducers: {
    save(state, { payload }) {
      const { list, total, page } = payload;
      // 复制数组，将list, total, page内容放到到state
      return { ...state, list, total, page };
    }
  },
  //用于处理异步操作和业务逻辑，不直接修改 state，简单的来说，就是获取从服务端获取数据，并且发起一个 action 交给 reducer。其中它用到了redux-saga，里面有几个常用的函数
  effects: {
    // * 表示生成器函数，该函数会返回一个迭代器
    // 参数 payload 表示有效负载的数据，在外部通过dispatch传递
    // put:  用于触发action  yield put({ type: 'todos/add', payload: 'Learn Dva'});
    // call:用于调用异步逻辑，支持Promise，第一个参数是你要调用的函数，第二个参数开始是你要传递的参。const result = yield call(fetch, '/todos');
    // select:用于从state里获取数据。const todos = yield select(state => state.todos);
    *fetchUserList({ payload: { page = 1 } }, { call, put }) {
      const { list, total } = yield call(queryUserList, { page });
      yield put({
        type: 'save',
        payload: {
          list: list,
          total: parseInt(total, 10),
          page: parseInt(page, 10),
        },
      });
    }
  }
};
export default UserModel;
```

### 3.4.6 编写页面

到这里，我们已经单独完成了 model 和 页面，那么他们如何串联起来呢?

dva 提供了 `connect` 方法。如果你熟悉 redux，这个 connect 来自 react-redux。

```typescript
//pages/user/index.tsx

import React, { FC, useEffect } from 'react';

//ConnectProps connect高阶函数的属性类型
//Loading 数据加载状态类型
//connect 高阶函数，主要作用将model和当前组件连接起来
import { ConnectProps, Loading, connect } from 'umi';
//users这个namespace的数据类型
import { UserModelState } from './models';

//声明当前页面的属性类型
interface PageProps extends ConnectProps {
  user: UserModelState;
  loading: boolean;
}

//当前组件对象
//参数users表示模型层数据
//参数dispatch表示redux派发器
//参数loading表示数据加载状态
const UserPage: FC<PageProps> = ({ user, dispatch, loading }) => {
  const { list,total } = user;
  useEffect(() => {
    //dispatch一个action来触发对应的reducer
    dispatch &&
      dispatch({
        type: 'user/fetchUserList',
        //payload 有效负载 ，dispatch传递参数的时候
        payload: {
          page: 1,
        },
      });
  }, []);
  return <div>Hello {JSON.stringify(list)}</div>;
};

//connect 作用：将model和当前组件连接起来
//参数 users 表示users这个namespace中的数据
//参数 loading 表示users namespace中的数据是否加载完毕
export default connect(({ user, loading }: { user: UserModelState; loading: Loading }) => ({
  user,
  loading: loading.models.user, //表示users这个namespace的数据是否已经加载完毕
}))(UserPage);
```

### 3.4.7 使用订阅更新设置dva数据

```javascript
//pages/user/models/index.ts

.........
//订阅更新
subscriptions: {
    setup({ dispatch, history }) {
        //监听url的变化，当访问路径是/user的时候触发fetchUserList这个effects
        return history.listen(({ pathname }) => {
            if (pathname === '/user') {
                dispatch({
                    type: 'fetchUserList',
                    payload: {
                        page: 1,
                    }
                });
            }
        });
    },
}

//注释掉pages/user/index.tsx    发送请求的代码
```

### 3.4.8 使用ant design编写页面

```javascript
import React, { FC,useEffect,useState } from 'react';
import { Table, Pagination, Popconfirm, Button } from 'antd';
import { ConnectProps, Loading, connect } from 'umi';
import { UserModelState,UserItem } from './models';

interface PageProps extends ConnectProps {
  user: UserModelState;
  loading: boolean;
}

const UserPage: FC<PageProps> = ({ user, dispatch, loading }) => {
  const { list, total, page } = user;

  function onChangeUserPagination(page: number) {
    dispatch &&
      dispatch({
        type: 'user/fetchUserList',
        payload: {
          page: page,
        },
      });
  }

  useEffect(() => {
    //dispatch一个action来触发对应的reducer
    dispatch &&
      dispatch({
        type: 'user/fetchUserList',
        //payload 有效负载 ，dispatch传递参数的时候
        payload: {
          page: 1,
        },
      });
  }, []);


  const toggle = ()=>{
    setPopShow(true)
  }

  const columns = [
    {
      title: '用户名',
      dataIndex: 'name',
      key: 'name',
    },
    {
      title: '电子邮件',
      dataIndex: 'email',
      key: 'email',
    },
    {
      title: '个人网站',
      dataIndex: 'website',
      key: 'website',
    },
    {
      title: '操作',
      key: 'operation',
      render: (item: UserItem) => (
        <span>
          <Button>编辑</Button>
          <Popconfirm visible={popShow} title="Confirm to delete?">
            <Button>删除</Button>
          </Popconfirm>
        </span>
      ),
    },
  ];
  return (
    <div>
      <div>
        <Table
          loading={loading}  //表格的加载状态
          columns={columns}  //表格列信息
          dataSource={list}  //表格数据源
          rowKey={(record:UserItem) => record.id}  //表格每一行数据的key
          pagination={false}   //不显示表格默认的分页器
        />
        <Pagination
          className="ant-table-pagination"
          total={total} // 数据总数
          current={page} // 当前页数
          onChange={onChangeUserPagination}  //改变页码的点击事件
          pageSize={10}   //每一页的数量
        />
      </div>
    </div>
  );
};

export default connect(({ user, loading }: { user: UserModelState; loading: Loading }) => ({
  user,
  loading: loading.models.user,
}))(UserPage);
```

### 3.4.9 完成删除功能

```typescript
//pages/user/services/index.tsx 新增请求
export function deleteUserById(id: number) {
  return request(`/api/users/delete/${id}`);
}


//pages/user/models/index.tsx reducer和effect
import { queryUserList, deleteUserById } from '../services';

//reducer中新增下面方法
//state的list可能是undefined，造成类型不匹配，所以这里要 state = {list:[]} 给list一个默认值
removeById(state, { payload }) {
    const { id } = payload;
    var filterList =
        state &&
        state.list &&
        state.list.filter((item) => {
            if (item.id !== id) {
                return item;
            }
        });
    return { ...state, ...{ list: filterList } };
},
    
//action中新增下面方法
//根据id删除指定用户  发送请求
*removeUserById({ payload: { id } }, { call, put }) {
    const result = yield call(deleteUserById, id);
    yield put({
        type: 'removeById',
        payload: {
            id: id,
        },
    });
},
    

# 页面新增删除事件
<Popconfirm visible={popShow} title="Confirm to delete?" onConfirm={()=>deleteHandler(item.id)}>
       <Button onClick={()=>{toggle()}}>删除</Button>
</Popconfirm>
                 
//控制pop弹框是否显示
const [popShow,setPopShow] = useState(false)
   
//这边点击删除按钮后一定要将pop关闭，否则会报内存泄漏
const deleteHandler = (id:number)=>{   
    setPopShow(false)
    dispatch &&
        dispatch({
        type: 'user/removeUserById',
        payload: {
            id,
        },
    });
}

const toggle = ()=>{
    setPopShow(true)
}
```

