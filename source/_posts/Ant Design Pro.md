---
title: Ant Design Pro
date: 2020-07-22 14:45:59
cover: https://i.loli.net/2020/07/22/mfSNjIg8VqBd9eJ.png
categories: React
tags:
  - Ant Design Pro
---

# 1.Ant Design Pro介绍

Ant Design Pro 是一个企业级中后台前端/设计解决方案

> 特性

- **优雅美观**：基于 Ant Design 体系精心设计
- **常见设计模式**：提炼自中后台应用的典型页面和场景
- **最新技术栈**：使用 React/dva/antd 等前端前沿技术开发
- **响应式**：针对不同屏幕大小设计
- **主题**：可配置的主题满足多样化的品牌诉求
- **国际化**：内建业界通用的国际化方案
- **最佳实践**：良好的工程实践助您持续产出高质量代码
- **Mock 数据**：实用的本地数据调试方案
- **UI 测试**：自动化测试保障前端产品质量


![](https://i.loli.net/2020/11/03/dCVM1AmtL3OrY4P.png)

创建项目：

yarn create umi myprotest

yarn install

yarn start



注意：这里创建项目的时候选择V5版本

​	    Pro V4+antd@4 版本权限验证不好用。**Pro V4+antd@4 可以查看完整版的ant design pro项目**。

​	    Pro V4+antd@3 版本有区块不好用

# 2.目录结构和配置介绍

## 2.1 目录结构

![](https://i.loli.net/2020/11/03/PN8yAJ3OzcvteQM.png)

## 2.2 配置文件

### 2.2.1 config.ts 

该文件类似.umirc.ts文件

```javascript
//引入umi中的配置文件的类型 ts中要用
import { defineConfig } from 'umi';
//引入默认的配置文件
import defaultSettings from './defaultSettings';
//代理配置文件
import proxy from './proxy';
let path = require('path');
//当前开发环境\发布环境
const { REACT_APP_ENV } = process.env;

//导出配置对象
export default defineConfig({
  //文件名支持hash命名
  hash: true,  
  //启用dva插件
  //每个插件都会对应一个 id 和一个 key，id 是路径的简写，key 是进一步简化后用于配置的唯一值。
  //比如插件 /node_modules/@umijs/plugin-antd ,id 为 @umijs/plugin-antd，key 为 antd。
  antd: {},
  //启用dva插件
  dva: {
    hmr: true,  //热更新
  },
  //启用layout布局插件  ant design pro中需要使用
  layout: {
    name: 'Ant Design Pro',
    locale: true,     //国际化
    siderWidth: 208,  //侧边栏宽度
  },
  //启用locale国际化插件 配置之后才可以使用useIntl 
  locale: {
    //默认的语言环境
    default: 'zh-CN',
    //antd开启国际化
    antd: true, 
    // default true, when it is true, will use `navigator.language` overwrite default
    baseNavigator: false,
  },
  //配置按需加载   即是否把构建产物进行拆分，在需要的时候下载额外的 JS 再执行。
  dynamicImport: {
    loading: '@/components/PageLoading/index',
  },
  //兼容ie11
  targets: {
    ie: 11,
  },
  // umi routes: https://umijs.org/docs/routing
  //路由配置
  routes: [
    {
      path: '/user',
      //不使用默认的页面布局模板，如果此属性不写就会使用默认页面布局模板(app.tsx中声明的layout)
      layout: false,
      //子路由
      routes: [
        {
          name: 'login',
          path: '/user/login',
          component: './user/login',
        },
      ],
    },
    {
      path: '/welcome',
      name: 'welcome',
      // access: 'canUser',  //只有user登录可以访问  在access.ts中有声明
      icon: 'smile',      //指定icon图标  可以使用ant design中的图标
      component: './Welcome',
    },
    {
      path: '/admin',
      name: 'admin',
      icon: 'crown',
      access: 'canAdmin',  //只有admin登录可以访问  在access.ts中有声明
      component: './Admin',
      routes: [
        {
          path: '/admin/sub-page',
          name: 'sub-page',
          icon: 'smile',
          component: './Welcome',
        },
      ],
    },
    {
      name: 'list.table-list',
      icon: 'table',
      path: '/list',
      component: './ListTableList',
    },
    {
      path: '/',
      redirect: '/welcome',
    },
    {
      component: './404',
    },
  ],
  // Theme for antd: https://ant.design/docs/react/customize-theme-cn
  theme: {
    // ...darkTheme,
    // 主要颜色,
    'primary-color': defaultSettings.primaryColor,
    //主题颜色配置
    // 'font-size-base': '14px',
    // 'badge-font-size': '12px',
    // 'btn-font-size-lg': '@font-size-base',
    // 'menu-dark-bg': '#00182E',
    // 'menu-dark-submenu-bg': '#000B14',
    // 'layout-sider-background': '#00182E',
    // 'layout-body-background': '#f0f2f5',
  },
  // @ts-ignore
  title: false,
  ignoreMomentLocale: true,
  //代理
  proxy: proxy[REACT_APP_ENV || 'dev'],
  manifest: {
    basePath: '/',
  },
  //别名
  alias: {
    '@': path.resolve(__dirname, 'src')
  }
});
```

### 2.2.2 defaultSettings.ts

页面样式的配置文件

```javascript
import { Settings as LayoutSettings } from '@ant-design/pro-layout';

export default {
  navTheme: 'dark',         //主题颜色   dark light
  primaryColor: '#1890ff',   //主要颜色
  layout: 'mix',             //布局方式  slide
  contentWidth: 'Fluid',     //内容宽度
  fixedHeader: false,        //固定头
  fixSiderbar: true,         //固定左侧内容
  colorWeak: false,          //弱视
  menu: {
    locale: true,            //菜单国际化
  },
  title: 'Ant Design Pro',   //标题
  pwa: false,
  iconfontUrl: '',           //icon图标地址
} as LayoutSettings & {
  pwa: boolean;
};
```

### 2.2.3 proxy.ts

该文件主要是代理的配置文件，仅在开发环境有效

### 2.2.4 app.tsx

app.tsx为运行时配置文件，导出的信息会使用对应的插件在运行时配置到程序中

## 2.3 配置详解

### 2.3.1 路由和菜单

ant design pro会根据配置的路由自动生成对应的菜单

```javascript
// umi routes: https://umijs.org/docs/routing
// hideChildrenInMenu 用于隐藏不需要在菜单中展示的子路由。用法可以查看 分步表单 的配置。
// hideInMenu 可以在菜单中不展示这个路由，包括子路由。

//路由配置
routes: [
    {
        path: '/user',
        //不使用默认的页面布局模板，如果此属性不写就会使用默认页面布局模板(app.tsx中声明的layout)
        layout: false,
        //子路由
        routes: [
            {
                name: 'login',
                path: '/user/login',
                component: './user/login',
            },
        ],
    },
    {
        path: '/welcome',
        name: 'welcome',
        // access: 'canUser',  //只有user登录可以访问  在access.ts中有声明
        icon: 'smile',      //指定icon图标  可以使用ant design中的图标
        component: './Welcome',
    },
    {
        path: '/admin',
        name: 'admin',
        icon: 'crown',
        access: 'canAdmin',  //只有admin登录可以访问  在access.ts中有声明
        component: './Admin',
        routes: [
            {
                path: '/admin/sub-page',
                name: 'sub-page',
                icon: 'smile',
                component: './Welcome',
            },
        ],
    },
    {
        name: 'list.table-list',
        icon: 'table',
        path: '/list',
        component: './ListTableList',
    },
    {
        path: '/',
        redirect: '/welcome',
    },
    {
        component: './404',
    },
],
```

### 2.3.2 权限

```typescript
1.当要设定某些菜单只有部分用户可见的时候，可以在菜单配置中写 access: 'canAdmin'

2.canAdmin的信息在src/access.ts中声明，该文件中导出的access函数会用插件@umijs/plugin-access进行运行时配置，函数返回的结果要是下面类型
 *  返回结果:
 *  {
 *     canAdmin:true,
 *     canUser:false
 *  }

3.useAccess：可以在页面根据不同的登录用户显示不同的信息
   import { useAccess, Access } from 'umi';
   const access = useAccess();      //此处为当前返回的结果数据
   
   if (access.canReadFoo) {
    // 如果可以读取 Foo，则...
   } 
   <Access
     accessible={access.canReadFoo}
     fallback={<div>Can not read foo content.</div>}
          >
          Foo content.
    </Access>
```

### 2.3.3 布局

```javascript
当某个路由不需要布局文件的时候，只需要在config.ts的路由配置中设定layout: false即可，如果没有写这个，则会使用默认的布局文件

默认的布局文件在app.tsx中layout中声明，会使用@umijs/plugin-layout进行运行时配置
```

### 2.3.4 InitialState

在app.tsx中导出getInitialState方法，会使用@umijs/plugin-initial-state插件进行运行时配置，该方法会在整个应用最开始执行，返回值会作为全局共享的数据。(每次刷新页面的之后都会执行)

```javascript
#1. app.tsx使用getInitialState提供全局共享数据
/**@umijs/plugin-initial-state  会启用这个插件
* getInitialState会在整个应用最开始执行，返回值会作为全局共享的数据
* 其他组件中可以使用useModel来获取这份数据 (类似生产者消费者模式)
*/
export async function getInitialState(): Promise<{
  currentUser?: API.CurrentUser;
  settings?: LayoutSettings;
}> {
  // 如果是登录页面，不执行
  if (history.location.pathname !== '/user/login') {
    try {
      const currentUser = await queryCurrent();
      return {
        currentUser,
        settings: defaultSettings,
      };
    } catch (error) {
      history.push('/user/login');
    }
  }
  return {
    settings: defaultSettings,
  };
}

#2.在其他组件中可以通过useModel获取上面暴露的数据
import { useModel } from 'umi';
//initialState是getInitialState方法的返回值
//loading是数据加载状态
//refresh可以重新执行getInitialState方法
const { initialState,loading,refresh } = useModel('@@initialState');   
```

### 2.3.5 国际化

```javascript
#1.src/locales 是国际化的配置文件

#2.SelectLang是语言选择组件
import { SelectLang } from 'umi';

#3.useIntl国际化库
import { useIntl,FormattedMessage } from 'umi';

//useIntl().formatMessage  使用formatMessage这个api进行国际化
useIntl().formatMessage({
    id: 'menu.home',
    defaultMessage: 'Home',
}),

//使用FormattedMessage组件进行国际化
<button><FormattedMessage id="menu.admin" /></button>
```

# 3.知识点介绍

## 3.1 封装组件介绍

Footer 网页底部组件的封装

HeaderDropdown 鼠标移动的下拉组件的封装

PageLoading  页面加载组件的封装   需要在config.ts中配置

```typescript
//PageLoading  pro-layout封装的一个简单的加载页面
import { PageLoading } from '@ant-design/pro-layout';

// loading components from code split
// https://umijs.org/plugin/umi-plugin-react.html#dynamicimport
export default PageLoading;
```

```typescript
//配置按需加载   即是否把构建产物进行拆分，在需要的时候下载额外的 JS 再执行。
dynamicImport: {
    loading: '@/components/PageLoading/index',
},
```

RightContent  登录后右上侧组件的封装(包含搜索、用户头像、语言选择等信息)

## 3.2  procomponents

<https://procomponents.ant.design/components/layout#api>

### 3.2.1 高级布局ProLayout 

#### a) BasicLayout&&BasicLayoutProps

BasicLayout 基础页面布局，包含了头部导航，侧边栏和通知栏等等。

ProLayout 与 umi 配合使用会有最好的效果，umi 会把 config.ts 中的路由帮我们自动注入到配置的 layout 中，这样我们就可以免去手写菜单的烦恼。

BasicLayoutProps基本页面布局的属性

```typescript
/**
 * app.tsx :  这边没有直接使用BasicLayout，而是写一个箭头函数返回BasicLayoutProps的实现，原因在于此处要根据initialState处理页面切换。
 * @umijs/plugin-layout
 * 默认登录后的页面布局模板 (此处权限验证的代码已经封装，看不到了，在老版本的项目中可以看到源代码)
 */
export const layout = ({
  initialState,
}: {
  initialState: { settings?: LayoutSettings; currentUser?: API.CurrentUser };
}): BasicLayoutProps => {
  return {
    //渲染顶部右侧内容
    rightContentRender: () => <RightContent />,
    //关闭 content的 margin
    disableContentMargin: false,
    //渲染网页底部页面
    footerRender: () => <Footer />,
    //当切换页面的时候触发的事件
    onPageChange: () => {
      // 如果没有登录，重定向到 login
      if (!initialState?.currentUser?.userid && history.location.pathname !== '/user/login') {
        history.push('/user/login');
      }
    },
    //渲染路径导航(代码为后来新增)
    breadcrumbRender: (routers = []) => [
      {
        path: '/',
        breadcrumbName: useIntl().formatMessage({
          id: 'menu.home',
          defaultMessage: 'Home',
        }),
      },
      ...routers,
    ],
    //路径导航相关(代码为后来新增)
    itemRender: (route, params, routes, paths) => {
      const first = routes.indexOf(route) === 0;
      return first ? (
        <Link to={paths.join('/')}>{route.breadcrumbName}</Link>
      ) : (
        <span>{route.breadcrumbName}</span>
      );
    },
    //渲染menu菜单头的方法(代码为后来新增)
    menuHeaderRender: () => <div>测试菜单</div>,
    //渲染菜单数据(此处可以修改返回的菜单数据从而实现渲染服务器返回的菜单信息)
    //menuData 为confit.ts中配置的菜单信息
    menuDataRender: (menuData) => {
      return menuData;
      /*
      return [
        {
          path: '/user',
          layout: false,
          //子路由
          routes: [
            {
              name: 'login',
              path: '/user/login',
              component: './user/login',
            },
          ],
        },
        {
          path: '/welcome',
          name: 'welcome',
          icon: <QuestionCircleOutlined />,
          component: './Welcome',
        },
      ];
      */
    },
    //传入配置参数
    ...initialState?.settings,
  };
};
```

#### b) PageContainer

正文内容组件，封装了 ant design 的 PageHeader 组件，增加了 tabList 和 content。 根据当前的路由填入 title 和 breadcrumb。

```typescript
  //content 指定页面内容
  //title 指定页面标题
  //pageHeaderRender 重新渲染页面头
  //footer 网页尾部内容
  //tabList 切换的tab列表
  <PageContainer
    content=" 这个页面只有 admin 权限才能查看"
    title="管理员页面头部信息"
    pageHeaderRender={(props) => {
      return <div>测试</div>;
    }}
    footer={[<div>页面尾巴</div>]}
    tabList={
       [{key:"张三",tab:<div>张三</div>},{key:"李四",tab:<div>李四</div>}]
    }
  >
    <p>正文内容</p>
  </PageContainer>
```

#### c) DefaultFooter

网页默认的底部组件

```typescript
<DefaultFooter
    copyright="2019 蚂蚁金服体验技术部出品"
    links={[
      {
        key: 'Ant Design Pro',
        title: 'Ant Design Pro',
        href: 'https://pro.ant.design',
        blankTarget: true,
      },
      {
        key: 'github',
        title: <GithubOutlined />,
        href: 'https://github.com/ant-design/ant-design-pro',
        blankTarget: true,
      },
      {
        key: 'Ant Design',
        title: 'Ant Design',
        href: 'https://ant.design',
        blankTarget: true,
      },
    ]}
/>
```

#### d) PageLoading

加载页面组件，需要在config.ts中配置。配置之后加载页面就默认会用该组件

```typescript
//配置按需加载   即是否把构建产物进行拆分，在需要的时候下载额外的 JS 再执行。
dynamicImport: {
    loading: '@/components/PageLoading/index',
},
```

#### e) FooterToolbar

底部工具栏组件

```typescript
<FooterToolbar
    extra={
        <div>
        已选择项&nbsp;&nbsp;
        <span>服务调用次数总计万</span>
        </div>
    }
    >
        {/**批量删除按钮 */}
    <Button>批量删除</Button>
    {/**批量审批按钮 */}
    <Button type="primary">批量审批</Button>
</FooterToolbar>
```

### 3.2.2  高级表格ProTable

#### a) ProColumns

高级列，会嵌套在高级表格中使用

```typescript
//定义高级列(会嵌套在高级表格中)
  const columns: ProColumns<TableListItem>[] = [
    {
      title: '规则名称', //页面显示的标题
      dataIndex: 'name', //对应数据源中的字段
      tip: '规则名称是唯一的 key', //tip提示信息
      formItemProps: {
        //校验规则
        rules: [
          {
            required: true,
            message: '规则名称为必填项',
          },
        ],
      },
      //渲染列的方法 : dom为页面元素,entity为数据源
      render: (dom, entity) => {
        return <a onClick={() => setRow(entity)}>{dom}</a>;
      },
    },
    {
      title: '描述',
      dataIndex: 'desc',
      //input的type类型
      valueType: 'textarea',
    },
    {
      title: '服务调用次数',
      dataIndex: 'callNo',
      sorter: true,
      //新建表单和查询的展开表单中不显示当前信息
      hideInForm: true,
      //渲染文字的方法
      renderText: (val: string) => `${val} 万`,
    },
    {
      title: '状态',
      dataIndex: 'status',
      //新建表单和查询的展开表单中不显示当前信息
      hideInForm: true,
      //枚举值
      valueEnum: {
        0: { text: '关闭', status: 'Default' },
        1: { text: '运行中', status: 'Processing' },
        2: { text: '已上线', status: 'Success' },
        3: { text: '异常', status: 'Error' },
      },
    },
    {
      title: '上次调度时间',
      dataIndex: 'updatedAt',
      sorter: true,
      // input的type类型
      valueType: 'dateTime',
      // 新建表单查询的展开表单中不显示当前信息
      // hideInForm: true,
      // 自定义渲染内容(会在新增表单和查询的展开表单中显示,要看到这个属性的结果需要把hideInForm: true去掉)
      renderFormItem: (item, { defaultRender, ...rest }, form) => {
        //获取当前数据的状态信息
        const status = form.getFieldValue('status');
        if (`${status}` === '0') {
          return false;
        }
        if (`${status}` === '3') {
          return <Input {...rest} placeholder="请输入异常原因！" />;
        }
        return defaultRender(item);
      },
    },
    {
      title: '操作',
      dataIndex: 'option',
      valueType: 'option',
      //渲染操作栏的方法
      render: (_, record) => (
        <>
          {/**配置按钮 */}
          <a
            onClick={() => {
              //点击配置按钮让更新表单可见
              handleUpdateModalVisible(true);
              //点击配置按钮设置更新表单的数据
              setStepFormValues(record);
            }}
          >
            配置
          </a>
          <Divider type="vertical" />
          {/**订阅警报按钮 */}
          <a href="">订阅警报</a>
        </>
      ),
    },
  ];
```

#### b) ProTable&ActionType

ProTable 高级表格

ActionType  记录高级表格的常用事件  (reload reset reloadAndRest等事件)

```typescript
import ProTable, { ProColumns, ActionType } from '@ant-design/pro-table';

//actionRef 记录高级表格的常用事件  (reload reset reloadAndRest等事件)
const actionRef = useRef<ActionType>();

<ProTable<TableListItem>
        headerTitle="查询表格" //表格标题
        actionRef={actionRef} //表格事件的引用
        rowKey="key" //表格每一行的key，这边为数据源中每一条数据的key
        search={{
          labelWidth: 120, //搜索lable的宽度   如果不想显示搜索栏，设置成false即可
        }}
        //渲染工具栏(新建按钮)
        toolBarRender={() => [
          //点击新建按钮，让新建表单可见
          <Button type="primary">新建</Button>,
        ]}
        //设置表格数据 (columns配置的sorter没有用，这边入参的sorter为空，要实现排序，手动storter写死)
        request={(params, sorter, filter) => 
        }
        //指定表格列
        columns={columns}
        //选中每一行(打钩)，记录下选中的数据
        rowSelection={{
        }}
/>
```

### 3.2.3 高级描述ProDescriptions

```typescript
import ProDescriptions from '@ant-design/pro-descriptions';

<ProDescriptions<TableListItem>
    //几列显示
    column={2}
    //标题 如果row存在则取name，如果row不存在则不取name，避免row不存在的时候报错
    title={row?.name}
    //设置ProDescriptions的数据
    request={async () => ({
        data: row || {},
    })}
    //传参，参数改变的时候会触发页面刷新
    params={{
        id: row?.name,
    }}
    //设置ProDescriptions的列数据
    columns={columns}
/>
```

## 3.3 登录页面及流程

### 3.3.1 登录页面及子组件

user/login/index.tsx   登录页面

user/login/components/login/index.tsx  封装的login组件，同时把Tab、Submit、Username、Password、Mobile、Captcha等组件挂在到当前index.tsx中

LoginContext.tsx  上下文对象，主要通过上下文在user/login/components/login/index.tsx中给子组件共享和暴露数据

LoginItem.tsx    登录项，主要在这里通过map.tsx中的配置动态创建登录子组件，包括Username、Password、Mobile、Captcha等

LoginSumit.tsx  提交登录表单的组件

LoginTab.tsx  登录切换Tab组件

### 3.3.2 登录流程

1. 提交登录表单

2. 调用fakeAccountLogin这个service发送登录请求

3. 登录成功之后跳回回调地址 

   注意：这边使用window.location.href="xx"，会刷新页面，从而触发app.tsx中的getInitialState方法重新执行

4. 根据当前url从路由配置中找寻相应的规则，然后根据getInitialState中的CurrentUser做权限验证，呈现登录后的用户菜单和页面

## 3.4 列表页流程

### 3.4.1 列表页面及子组件

pages/ListTableList/index.tsx   列表页面

pages/ListTableList/service.ts  列表页面的请求文件

pages/ListTableList/data.d.ts   列表页面的类型声明文件

pages/ListTableList/components/createForm.tsx  创建表单的组件

pages/ListTableList/components/updateForm.tsx  更新表单的组件

### 3.4.2 列表流程

#### a) 列表页面展示、查询、分页

```typescript
//设置表格数据 (columns配置的sorter没有用，这边入参的sorter为空，要实现排序，手动storter写死)
request={(params, sorter, filter) =>
         queryRule({ ...params, sorter: { callNo: 'ascend' }, filter })
}
```

#### b) 规则新增

```typescript
//1.点击新建按钮，让新建表单模态框可见
<Button type="primary" onClick={() => handleModalVisible(true)}>
    <PlusOutlined /> 新建
</Button>,


//2.点击新建表单的提交表单按钮，发送请求，然后让新建表单不可见，然后让外边的表单刷新页面
<CreateForm onCancel={() => handleModalVisible(false)} modalVisible={createModalVisible}>
        {/**嵌套一个ProTable */}
        <ProTable<TableListItem, TableListItem>
          //点击提交按钮 发送请求 让外部的ProTable刷新表格
          onSubmit={async (value) => {
            const success = await handleAdd(value);
            if (success) {
              handleModalVisible(false);
              if (actionRef.current) {
                actionRef.current.reload();
              }
            }
          }}
          //每一行的索引
          rowKey="key"
          //表格的类型
          type="form"
          //指定表格的列  此时columns中配置的hideInForm生效了
          columns={columns}
        />
</CreateForm>
```

#### c) 规则更新

```typescript
//1.点击配置按钮，让配置表单可见，并设置配置表单的数据
handleUpdateModalVisible(true);
//点击配置按钮设置更新表单的数据
setStepFormValues(record);

//2.点击配置表单的提交按钮，发送请求，然后让配置表单不可见，然后让外边的表单刷新页面
<UpdateForm
          //提交表单 发送请求 让外部的ProTable刷新表格
          onSubmit={async (value) => {
            const success = await handleUpdate(value);
            if (success) {
              handleUpdateModalVisible(false);
              setStepFormValues({});
              if (actionRef.current) {
                actionRef.current.reload();
              }
            }
          }}
          //取消更新表单
          onCancel={() => {
            handleUpdateModalVisible(false);
            setStepFormValues({});
          }}
          //更新表单的显示隐藏状态
          updateModalVisible={updateModalVisible}
          //更新表单的数据
          values={stepFormValues}
/>
```

#### d) 规则选中

```typescript
//1.选中规则，保存选中的数据到selectedRows数组
rowSelection={{
    onChange: (_, selectedRows) => setSelectedRows(selectedRows),
}}

//2.如果选中行的长度>0，则让底部FooterToolbar显示出来
//点击批量删除，发送请求，设置选中的selectedRows数组为空(让FooterToolbar不可见)，同时让外边的表单刷新页面
{selectedRowsState?.length > 0 && (
        <FooterToolbar
          extra={
            <div>
              已选择 <a style={{ fontWeight: 600 }}>{selectedRowsState.length}</a> 项&nbsp;&nbsp;
              <span>
                服务调用次数总计 {selectedRowsState.reduce((pre, item) => pre + item.callNo, 0)} 万
              </span>
            </div>
          }
        >
          {/**批量删除按钮 */}
          <Button
            onClick={async () => {
              await handleRemove(selectedRowsState);
              setSelectedRows([]);
              actionRef.current?.reloadAndRest?.();
            }}
          >
            批量删除
          </Button>
           {/**批量审批按钮 */}
          <Button type="primary">批量审批</Button>
        </FooterToolbar>
)}
```

#### e) 查看规则名称

```typescript
//1.点击规则名称记录当前点击的规则数据(row)
<a onClick={() => setRow(entity)}>{dom}</a>

//2.当前记录的规则有数据的时候，让抽屉可见，并使用ProDescriptions展示数据
// 点击抽屉组件的关闭按钮的时候，让row数据置空(此时Drawer会隐藏)
<Drawer
        width={500}
        //当row数据存在的时候让抽屉组件显示
        visible={!!row}
        //关闭抽屉组件的时候触发的方法
        onClose={() => {
          setRow(undefined);
        }}
        //是否显示抽屉组件的关闭按钮
        closable={false}
      > 
        {/**如果row中有信息则显示规则的详细信息 */}
        {row?.name && (
          <ProDescriptions<TableListItem>
            //几列显示
            column={2}
            //标题 如果row存在则取name，如果row不存在则不取name，避免row不存在的时候报错
            title={row?.name}
            //设置ProDescriptions的数据
            request={async () => ({
              data: row || {},
            })}
            //传参，参数改变的时候会触发reload
            params={{
              id: row?.name,
            }}
            //设置ProDescriptions的列数据
            columns={columns}
          />
        )}
</Drawer>
```

# 4. ant design pro区块 

https://pro.ant.design/docs/block-cn

区块是研发资产的一种，它是一系列快速搭建页面的代码片段，它可以帮助你快速的在项目中初始化好一个页面，帮助你更快速的开发代码。当前的区块都是页面级别的区块，你可以理解为它是一些项目中经常会用到的典型页面的模板，使用区块其实相当于从已有的项目中复制一些页面的代码到你当前的项目中。

- 以前开发一个页面：创建 JS -> 创建 CSS -> 创建 Model -> 创建 service -> 写页面组件。
- 现在开发一个页面：下载区块 -> 基于区块初始化好的页面组件修改代码。

在 Pro 中资产被分为了两种，区块和模板。区块可以类比为一个组件，而模板代表一个页面。区块现在支持所有 antd 中的 demo，可以更加快速的将 demo 导入到项目中去。

# 5.vue-antd-admin

<https://github.com/iczer/vue-antd-admin>