---
title: openharmony基础知识学习
date: 2023-03-22 20:11:02
cover: https://cdn.jsdelivr.net/gh/rainlotus97/images/data/2023-03-22/aniya.png
categories: 鸿蒙
tags: 
  - ets

---

# 一、认识常见组件

## 1.Cloumn
```javascript
// 沿垂直方向布局的容器。
Column(value?: {space?: string | number}){
}
//space:纵向布局元素垂直方向间距,默认值为0，设负值不生效。
//支持alignItems、justifyContent属性
//alignItems：设置子组件在水平方向上的对齐格式。
//justifyContent：设置子组件在垂直方向上的对齐格式。
```
## 2.Flex
```javascript
//以弹性方式布局子组件的容器组件
Flex(value?: { direction?: FlexDirection, wrap?: FlexWrap, justifyContent?: FlexAlign, alignItems?: ItemAlign, alignContent?: FlexAlign })

//[具体参数文档](https://docs.openharmony.cn/pages/v3.2Beta/zh-cn/application-dev/reference/arkui-ts/ts-container-flex.md/)
```
## 3.List
```javascript
//列表包含一系列相同宽度的列表项。适合连续、多行呈现同类数据，例如图片和文本。
List(value?:{space?: number | string, initialIndex?: number, scroller?: Scroller})
//space:列表项间距
//initialIndex:设置当前List初次加载时视口起始位置显示的item的索引值。如果设置的值超过了当前List最后一个item的索引值，则设置不生效。
//scroller:可滚动组件的控制器。用于与可滚动组件进行绑定。
```
## 4.Navigator
```javascript
//路由容器组件，提供路由跳转能力。
Navigator(value?: {target: string, type?: NavigationType})
//NavigationType：Push/Replace/Back
```
## 5.Refresh
```javascript
//可以进行页面下拉操作并显示刷新动效的容器组件。
Refresh(value: { refreshing: boolean, offset?: number | string , friction?: number | string })

// xxx.ets
@Entry
@Component
struct RefreshExample {
  @State isRefreshing: boolean = false
  @State counter: number = 0

  build() {
    Column() {
      Refresh({ refreshing: $$this.isRefreshing, offset: 120, friction: 100 }) {
        Text('Pull Down and refresh: ' + this.counter)
          .fontSize(30)
          .margin(10)
      }
      .onStateChange((refreshStatus: RefreshStatus) => {
        console.info('Refresh onStatueChange state is ' + refreshStatus)
      })
      .onRefreshing(() => {
        setTimeout(() => {
          this.counter++
          this.isRefreshing = false
        }, 1000)
        console.log('onRefreshing test')
      })
    }
  }
}
//ArkTS支持通过$$双向绑定变量，通常应用于状态值频繁改变的变量 
// 当前$$支持基础类型变量，以及@State、@Link和@Prop装饰的变量。
// 当前$$仅支持bindPopup属性方法的show参数，Radio组件的checked属性，Refresh组件的refreshing参数。
//$$绑定的变量变化时，仅渲染刷新当前组件，提高渲染速度。
```
## 6.Row
```javascript
//沿水平方向布局容器。
Row(value?:{space?: number | string })
//alignItems:设置子组件在垂直方向上的对齐格式
//justifyContent:设置子组件在水平方向上的对齐格式
```
## 7.Swiper
```javascript
// 滑块视图容器，提供子组件滑动轮播显示的能力。
Swiper(controller?: SwiperController)

// xxx.ets
class MyDataSource implements IDataSource {
  private list: number[] = []
  private listener: DataChangeListener

  constructor(list: number[]) {
    this.list = list
  }

  totalCount(): number {
    return this.list.length
  }

  getData(index: number): any {
    return this.list[index]
  }

  registerDataChangeListener(listener: DataChangeListener): void {
    this.listener = listener
  }

  unregisterDataChangeListener() {
  }
}

@Entry
@Component
struct SwiperExample {
  private swiperController: SwiperController = new SwiperController()
  private data: MyDataSource = new MyDataSource([])

  aboutToAppear(): void {
    let list = []
    for (var i = 1; i <= 10; i++) {
      list.push(i.toString());
    }
    this.data = new MyDataSource(list)
  }

  build() {
    Column({ space: 5 }) {
      Swiper(this.swiperController) {
        LazyForEach(this.data, (item: string) => {
          Text(item).width('90%').height(160).backgroundColor(0xAFEEEE).textAlign(TextAlign.Center).fontSize(30)
        }, item => item)
      }
      .cachedCount(2)
      .index(1)
      .autoPlay(true)
      .interval(4000)
      .indicator(true)
      .loop(true)
      .duration(1000)
      .itemSpace(0)
      .curve(Curve.Linear)
      .onChange((index: number) => {
        console.info(index.toString())
      })

      Row({ space: 12 }) {
        Button('showNext')
          .onClick(() => {
            this.swiperController.showNext()
          })
        Button('showPrevious')
          .onClick(() => {
            this.swiperController.showPrevious()
          })
      }.margin(5)
    }.width('100%')
    .margin({ top: 5 })
  }
}

```
## 8.Tabs
```javascript
//通过页签进行内容视图切换的容器组件，每个页签对应一个内容视图。
Tabs(value?: {barPosition?: BarPosition, index?: number, controller?: TabsController})

// xxx.ets

@Entry
@Component
struct TabsExample {
  @State fontColor: string = '#182431'
  @State selectedFontColor: string = '#007DFF'
  @State currentIndex: number = 0
  @State tabArr: Array<object> = [
    { bgColor: '#00CB87', color: 'green' },
    { bgColor: '#007DFF', color: 'blue' },
    { bgColor: '#FFBF00', color: 'yellow'}, 
    { bgColor: '#E67C92', color: 'pink' }]
  private controller: TabsController = new TabsController()
//  @Builder装饰器定义了一个如何渲染自定义组件的方法。此装饰器提供了一个修饰方法，其目的是和build函数一致。@Builder装饰器装饰的方法的语法规范与build函数也保持一致。
  @Builder TabBuilder(index: number, name: string) {
    Column() {
      Text(name)
        .fontColor(this.currentIndex === index ? this.selectedFontColor : this.fontColor)
        .fontSize(16)
        .fontWeight(this.currentIndex === index ? 500 : 400)
        .lineHeight(22)
        .margin({ top: 17, bottom: 7 })
      Divider()
        .strokeWidth(2)
        .color('#007DFF')
        .opacity(this.currentIndex === index ? 1 : 0)
    }.width('100%')
  }

  build() {
    Column() {
      Tabs({ barPosition: BarPosition.Start, controller: this.controller }) {
        ForEach(this.tabArr,({bgColor,color},index)=>{
          TabContent() {
            Column().width('100%').height('100%').backgroundColor(bgColor)
          }.tabBar(this.TabBuilder(index, color))
        })
      }
      .vertical(false)
      .barMode(BarMode.Fixed)
      .barWidth(360)
      .barHeight(56)
      .animationDuration(0)
      .onChange((index: number) => {
        this.currentIndex = index
      })
      .width(360)
      .height(296)
      .margin({ top: 52 })
      .backgroundColor('#F1F3F5')
    }.width('100%')
  }
}

```
## 9.CheckboxGroup与Checkbox
```javascript
// xxx.ets
@Entry
@Component
struct CheckboxExample {
  build() {
    Scroll() {
      Column() {
        // 全选按钮
        Flex({ justifyContent: FlexAlign.Start, alignItems: ItemAlign.Center }) {
          CheckboxGroup({ group: 'checkboxGroup' })
            .selectedColor('#007DFF')
            .onChange((itemName: CheckboxGroupResult) => {
              console.info("checkbox group content" + JSON.stringify(itemName))
            })
          Text('Select All').fontSize(14).lineHeight(20).fontColor('#182431').fontWeight(500)
        }

        // 选项1
        Flex({ justifyContent: FlexAlign.Start, alignItems: ItemAlign.Center }) {
          Checkbox({ name: 'checkbox1', group: 'checkboxGroup' })
            .selectedColor('#007DFF')
            .onChange((value: boolean) => {
              console.info('Checkbox1 change is' + value)
            })
          Text('Checkbox1').fontSize(14).lineHeight(20).fontColor('#182431').fontWeight(500)
        }.margin({ left: 36 })

        // 选项2
        Flex({ justifyContent: FlexAlign.Start, alignItems: ItemAlign.Center }) {
          Checkbox({ name: 'checkbox2', group: 'checkboxGroup' })
            .selectedColor('#007DFF')
            .onChange((value: boolean) => {
              console.info('Checkbox2 change is' + value)
            })
          Text('Checkbox2').fontSize(14).lineHeight(20).fontColor('#182431').fontWeight(500)
        }.margin({ left: 36 })

        // 选项3
        Flex({ justifyContent: FlexAlign.Start, alignItems: ItemAlign.Center }) {
          Checkbox({ name: 'checkbox3', group: 'checkboxGroup' })
            .selectedColor('#007DFF')
            .onChange((value: boolean) => {
              console.info('Checkbox3 change is' + value)
            })
          Text('Checkbox3').fontSize(14).lineHeight(20).fontColor('#182431').fontWeight(500)
        }.margin({ left: 36 })
      }
    }
  }
}

```
# 二、页面循环与判断
## 1.utils文件
```javascript
// utils/utils.ets
export class FoodData {
  name: string;

  constructor(name: string) {
    this.name = name;
  }
}

@Component
export struct FoodList {
  private foodItems: FoodData[]

  build() {
    Column() { //块级元素，可近似认为div标签
      List() {  //类似html中的ul
        ForEach(this.foodItems, (item,idx) =>{
          if (idx<2){
            ListItem() { // 类似html中的li
              Text(item.name) //文本内容,对文字具体操作，可包裹span标签使用
                .fontSize(30)
                .fontColor('white')
                .fontWeight('bold')

            }.onClick((e:any)=>{
              console.log(item.name)
            })
          }
        })
      }
      .backgroundColor(Color.Pink)
      .margin('20')
    }
  }
}
```
## 2.引入utils文件
```javascript
import { FoodData, FoodList } from "../utils/utils";
```
# 三、路由跳转
```javascript
import router from '@ohos.router';

 let options = {
      url: 'pages/second',
      params: {
        text: '这是第一页的值',
        data: {
          array: [12, 45, 78]
        },
      }
    }
router.pushUrl(options)
// router.back()

```
# 四、AppStorage
```javascript
// firstPage
@Entry
@Component
struct FirstPage {
  @StorageLink('varA') aFirstPage: number = 1 
  @StorageProp('varB') bFirstPage: number = 2 // 单向数据流
  private label: string = 'count'

  build() {
    Column() {
      Navigator({ target: 'pages/TempPage', type: NavigationType.Push }) {
        Text("Now is FirstPage, Click here and go to SecondPage. \n type:Push")
          .textOverflow({overflow:TextOverflow.Ellipsis})
          .maxLines(1)
          .fontSize(20)
      }
      .margin({ right: 24, left: 32 })

      Row({ space: 20 }) {
        Button(`${this.label}: ${this.aFirstPage}`)
          .onClick(() => {
            AppStorage.Set<number>('varA', AppStorage.Get<number>('varA') + 1) //这里
          })
        Button(`${this.label}: ${this.bFirstPage}`)
          .onClick(() => {
            AppStorage.Set<Number>('varB',this.bFirstPage + 1)
          }).backgroundColor('red')
      }
      Column(){
        Image($r('app.media.icon')).borderRadius(200)
      }.width(200).height(200).borderRadius(200).border({width:2 ,color:'black'})

    }.width('100%').height('100%').margin(0)
    .borderColor(Color.Black)
  }
}

// TempPage
@Entry
@Component
struct SecondPage {
  @StorageLink('varA') aSecondPage: number = 1 
// 组件通过使用@StorageLink(key)装饰的状态变量，将与AppStorage建立双向数据绑定
  private label: string = 'count'

  build() {
    Column(){
      Navigator({ target: 'pages/firstPage' ,type: NavigationType.Push}) {
        Text("Now is SecondPage, Click here and go to FirstPage. \n type:Push")
          .fontSize(20)
      }
      .margin({ right: 24, left: 32 })
      Row({ space: 20 }) {
        Button(`${this.label}: ${this.aSecondPage}`)
          .onClick(() => {
            AppStorage.Set<number>('varA', AppStorage.Get<number>('varA') + 1) //设值
          })
        Button(`${this.label}: ${AppStorage.Get('varB')}`) // 取值
          .onClick(() => {
          }).backgroundColor('red')
      }
    }
  }
}
```
# 五、@Link与@Prop
```javascript
// third.ets
@CustomDialog
struct CustomDialogExample {
  @Link textValue: string // 双向绑定
  @Link inputValue2: string // 双向绑定
  @Prop receiveValue:string // 单向绑定
  controller: CustomDialogController
  cancel: () => void
  confirm: () => void

  build() {
    Column() {
      Text('Change text').fontSize(20).margin({ top: 10, bottom: 10 })
      TextInput({ placeholder: '请输入文字', text: this.textValue }).height(60).width('90%')
        .onChange((value: string) => {
          this.textValue = value
        })
      Text(this.receiveValue).fontSize(16).margin({ bottom: 10 })
      Flex({ justifyContent: FlexAlign.SpaceAround }) {
        Button('cancel')
          .onClick(() => {
            this.controller.close()
            this.cancel()
          }).backgroundColor(0xffffff).fontColor(Color.Black)
        Button('confirm')
          .onClick(() => {
            this.inputValue2 = this.textValue
            this.receiveValue = this.textValue
            this.controller.close()
            this.confirm()
          }).backgroundColor(0xffffff).fontColor(Color.Red)
      }.margin({ bottom: 10 })
    }
  }
}

@Entry
@Component
struct CustomDialogUser {
  @State textValue: string = ''
  @State inputValue: string = 'click me'
  @State receiveValue: string = 'click me'
  dialogController: CustomDialogController = new CustomDialogController({
    builder: CustomDialogExample({
      cancel: this.onCancel,
      confirm: this.onAccept,
      //针对@Link属性的变量，赋值时需要使用$变量名，使用this.变量名会报错。
      textValue: $textValue,
      inputValue2: $inputValue,
      //@Prop属性的变量使用this.变量名即可
      receiveValue:this.receiveValue
    }),
    cancel: this.existApp,
    autoCancel: true,
    alignment: DialogAlignment.Default,
    offset: { dx: 0, dy: -20 },
    gridCount: 4,
    customStyle: false
  })

  onCancel() {
    console.info('Callback when the first button is clicked')
  }

  onAccept() {
    console.info('Callback when the second button is clicked')
  }

  existApp() {
    console.info('Click the callback in the blank area')
  }

  build() {
    Column() {
      Button(this.inputValue)
        .onClick(() => {
          this.dialogController.open()
        }).backgroundColor(0x317aff)
    }.width('100%').margin({ top: 50 })
  }
}

```
# 六、@Consume和@Provide
```javascript
//Provide作为数据的提供方，可以更新其子孙节点的数据，并触发页面渲染。Consume在感知到Provide数据的更新后，会触发当前view的重新渲染。
//这里的使用类似于state和link。父组件中Provide提供数据，子组件中Consume使用，且是双向绑定，一方改变后，另一方也会改变。

// provider.ets

import { CompB } from './consumer'
@Entry
@Component
struct CompA {
  @Provide("reviewVote") reviewVotes : number = 0;

  build() {
    Column() {
      CompB()
      Button() {
        Text(`${this.reviewVotes}`)
          .fontSize(30)
      }.width(100).backgroundColor(Color.Yellow)
      .onClick(() => {
        this.reviewVotes += 1;
      })
    }
  }
}

// consumer.ets
@Component
export struct CompB {
  @Consume("reviewVote") reviewVotes : number;
  build() {
    Column() {
      Button() {
        Text(`${this.reviewVotes}`)
          .fontSize(30)
      }.width(100).backgroundColor('red')
      .onClick(() => {
        this.reviewVotes += 1;
      })
    }
  }
}
```
# 七、@Watch
```javascript
//应用可以注册回调函数。当一个被@State, @Prop, @Link, @ObjectLink, @Provide, @Consume, @StorageProp, 以及 @StorageLink中任意一个装饰器修饰的变量改变时，均可触发此回调。@Watch中的变量一定要使用（“”）进行包装。
//这个比较简单，通俗点说就相当于给变量绑了个监听函数，每次该变量改变后，都将执行此函数,即回调函数。

@Entry
@Component
struct CompA {
  @State @Watch("onBasketUpdated") shopBasket : Array<number> = [ 7, 12, 47, 3 ];  //将onBasketUpdated注册为回调函数，当变量shopBasket发生改变时，将自动触发该回调函数
  @State totalPurchase : number = 0;

  updateTotal() : number {
    const sum=this.shopBasket.reduce((prev,next)=>prev+next,0)
    // calculate new total shop basket value and apply discount if over 100RMB
    this.totalPurchase = sum;
    return this.totalPurchase;
  }
  // @Watch cb
  onBasketUpdated(propName: string) : void {
    this.updateTotal();
    console.log(this[propName])
  }
  build() {
    Column() {
      Button("add to basket").onClick(() => { this.shopBasket.push(Math.round(100 * Math.random())) }) //这里shopBasket改变，触发onBasketUpdated函数，从而更新this.totalPurchase的值
      Text(`${this.totalPurchase}`)
        .fontSize(30)
    }
  }
}
```