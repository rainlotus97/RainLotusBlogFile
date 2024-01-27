---
title: github和gitee配置和使用
date: 2020-02-21 09:55:35
tags: github gitee
cover: https://i.loli.net/2020/07/31/1I3sEXdbuFDV5WK.jpg
---
# github和gitee的配置与使用

## 一、配置SSH公钥免密登录

由于需要同时配置两个网站的公钥，为了避免冲突，执行如下操作即可：

- 第一步，先分别获取两个网站的公钥，并命名为不同的名称做于分辨

  ```bash
   ssh-keygen -t rsa -C "s0704127x@163.com" -f "github_id_rsa"
   ssh-keygen -t rsa -C "2642446152@qq.com" -f "gitee_id_rsa"
  ```

  ![ssh公钥](https://i.loli.net/2020/07/30/TfX7Pgh4zUcJ2W9.png)

- 第二步，将获取的公钥分别在各自官网配置。其中github对应的key为github_id_rsa.pub，而gitee的key则是gitee_id_rsa.pub。分别用记事本打开，copy一份去配置即可。

  以下则以github为例，成功的结果图如下：

  ![ssh公钥](https://i.loli.net/2020/07/30/cHeB1JoO7sYZl4k.png)

- 第三步，在.ssh目录下添加一个config脚本文件，并将下方代码复制进去，以用于避免两个网站的地址冲突。

  ```bash
  # gitee
  Host gitee.com
  HostName gitee.com
  PreferredAuthentications publickey
  IdentityFile ~/.ssh/gitee_id_rsa
  
  # github
  Host github.com
  HostName github.com
  PreferredAuthentications publickey
  IdentityFile ~/.ssh/github_id_rsa
  ```

- 第四步，也是最关键的一步，通过下方命令检查有没有连接成功。

  ```bash
  ssh -T git@gitee.com
  ssh -T git@github.com
  ```

  以下为实测成功图，如果和下方相似，基本上你也是连接成功的。

  ![](https://i.loli.net/2020/07/30/DHGWvZ2wcnVOL5F.png)

  ![](https://i.loli.net/2020/07/30/WGPuDaFC3emU9jh.png)

   **做完以上步骤，说明SSH免密配置你已经成功完成了！**

## 二、github和gitee新建仓库的步骤

### 1.github的网页仓库添加

##### 第一步，去官网注册github账号，记住自己账号密码，以上！

##### 第二步，点击页面右上角的**+**号，选择第一个New repository来创建，具体如图下所示：

![](https://i.loli.net/2020/07/30/2ADJmVlQxKiPZyf.png)		

##### 第三步，看到如下界面：

![](https://i.loli.net/2020/07/30/kUiS6RAmb9JVYOv.png)

重点处已有箭头标识，在此再次解释一下。仓库名称(Repository name)尽量英文名称，Description(描述)这是个可选项，用于识别仓库干什么的。底下还有Public和Private两个选项，是用来私人用还是共享用的，不做强求，但往往默认会共享的，看你心情咯~

最后创建仓库，没了~~~

##### 第四步，来到了最关键的一步了，先看下图：

![](https://i.loli.net/2020/07/30/kltXAJsLrI65mOy.png)

第一行有个HTTPS/SSH 后面还跟着一串链接，这是我们用来让本地和github建立链接的桥梁，不过有个需要注意的是，HTTPS不好的一点是，接下来我们建立连接的时候会需要要求输入用户名和密码。说不定哪一天抽风了，我们一时记不住密码，就~~嘿嘿~

所以我们使用SSH登录，方便，更关键的是：不用他我之前写的岂不是白费了？？言归正传，以下放出切换到有SSH链接的图片：

![](https://i.loli.net/2020/07/30/x9by8LRu1TG7DpZ.png)

##### **以下才是真正的重点：**

看第二块和第三块区域，第二块是告诉我们第一次在本地建立仓库的操作，第三块则是对我们本地已有的仓库和刚刚创建好的这个仓库建立连接。

我们是第一次操作，就看第二块区域就好。我们只要在本地选择好一个文件夹，然后在当前文件夹下右键使用git bash here，随后将它的每一行代码一个个敲就能完成本地仓库和github仓库的连接了！

我根据上图以及个人收获，总结出下方重要代码块，你一步步操作即可：

```bash
touch README.md    //此命令较之github官方更为简单，就是用来在本地创建一个空md文件

git init           //对本地文件夹初始化，使其变成可建立连接的本地仓库

git add README.md   //将README.md文档添加到暂存区

git commit -m "first commit"  //对添加的文件添加备注，引号内可以随便写

git remote add origin git@github.com:******/CodeServer.git 
//第一次操作，这步至关重要，就是让你当前文件夹(本地仓库)和github的个人仓库建立联系

git push -u origin master 	  
//最后将之前添加备注的提交文件推送到github仓库的master分支之下
```

```bash
touch README.md 
git init 
git add README.md
git commit -m "first commit"
git remote add origin git@github.com:*****/CodeServer.git
git push -u origin master 
```

以上代码专门拿出来方便你copy使用，记住 git@github.com:***/CodeServer.git这个是我的SSH链接地址，你需要换成自己的。而且，以上操作1仅限第一次使用，之后上传代码则无需上述那么多繁杂步骤了！

以下放出我的成功截图：

![](https://i.loli.net/2020/07/30/FXq8yQA6B4i3vbU.png)

##### 第五步，平时上传本地仓库的操作

```bash
git add .
git commit -m "第二次提交"
git push origin master
```

只需要这三条命令就可以将本地文件推送到github的个人仓库了！

最后再顺便聊一下，官方网站上仓库的下载方法吧

1. 直接下载

   ![](https://i.loli.net/2020/07/30/ijEUM8w7TAdyobs.png)

   直接下载就是点击Download ZIP即可

2. 用命令下载

   上图会有链接，copy一下，我这个是SSH的链接，你也可以选择HTTPS的。我建议你可以把这个地址记录在本地，忘记了打开它复制一下就好了。

   在git bash here中输入以下代码即可下载了。

   ```bash
   git clone git@github.com:*****/CodeServer.git
   ```

##### 第六步，错误总结

![](https://i.loli.net/2020/07/30/s19lgxIwcDrO2XT.png)

有时候你可能会与到上图黄字部分的报错，而你执行的操作则是push -u origin master这一步推送操作而已。这个时候你只需要执行下方代码即可完美解决这个问题：

```bash
git pull --rebase origin master
```

## 2.gitee的网页仓库添加

gitee是国产的类似于github的网站，操作流程和github十分相似，建立仓库，初始化本地仓库的操作都是一样的，就连本地化初始仓库、建立连接等操作所用的命令也是一模一样。没啥好说的了，不过我们可以谈谈另外一件事。

**github下载慢**

这个问题可以解决吗？

可以，要么VPN(有时候还不管用),外国云服务器下载(超级快，几十兆每秒，就是你还需要再下回到本地，但是依旧比直接在官网下载的快)。我知道的最后一个方法，就是讲github的项目导入到gitee上，再从gitee上下载下来就好了！(速度也就比github上好看些，免费！)

## 三、gitee和github的同步刷新

gitee比较坑的地方就是，对github导入的库不能同步刷新，必须在官网手动刷新很麻烦。这个时候可以尝试同步刷新的方法！

1. 在项目目录找到`.git`隐藏文件夹，如果在项目目录找不到`.git`隐藏文件夹，文件夹右上角打开`查看`然后找到`隐藏的项目`并勾选即可 

2. 用记事本打开`config`文件，把Gitee(码云)(或者github，看你缺啥)的仓库地址填进去即可。

   ```bash
   [core]
   	repositoryformatversion = 0
   	filemode = false
   	bare = false
   	logallrefupdates = true
   	symlinks = false
   	ignorecase = true
   [remote "origin"]
   	url = git@github.com:rainlotus97/CodeServer.git
   	url = git@gitee.com:rainlotus97/CodeServer2.git   //这是后添加的
   	fetch = +refs/heads/*:refs/remotes/origin/*
   [branch "master"]
   	remote = origin
   	merge = refs/heads/master
   
   ```

    最后重新`push`即可，如果Gitee(码云)仓库有过提交，使用此方法第一次提交请使用`强行提交`，避免抱错 

   ```bash
   git push -f origin master
   ```

   