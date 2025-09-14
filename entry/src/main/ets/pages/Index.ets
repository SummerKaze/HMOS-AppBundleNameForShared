import { common, OpenLinkOptions, Want } from '@kit.AbilityKit';
import { hilog } from '@kit.PerformanceAnalysisKit';

@Entry
@Component
struct Index {
  @State headerOpacity: number = 0.0; // 头部透明度动画
  @State cardScale: number = 0.9; // 卡片缩放动画
  @State cardOpacity: number = 0.0; // 卡片透明度动画
  @State stepsOpacity: number = 0.0; // 步骤透明度动画
  @State buttonTranslateY: number = 50; // 按钮移动动画
  @State buttonOpacity: number = 0.0; // 按钮透明度动画
  @State scrollOffset: number = 0; // 滚动偏移量
  @State isHeaderBlurred: boolean = false; // 头部毛玻璃效果状态
  @State easterEggClickCount: number = 0; // 彩蛋点击计数
  @State showSignature: boolean = false; // 是否显示署名
  @StorageProp('topAreaHeight')
  topAreaHeight: number = 0
  @StorageProp('bottomAreaHeight')
  bottomAreaHeight: number = 0
  // 滚动控制器
  private scroller: Scroller = new Scroller()

  /**
   * 组件即将出现时启动入场动画
   */
  aboutToAppear(): void {
    this.startEntranceAnimation();
  }

  /**
   * 启动分层入场动画，提升用户体验
   */
  private startEntranceAnimation(): void {
    // 头部渐入动画
    animateTo({
      duration: 800,
      curve: Curve.EaseOut
    }, () => {
      this.headerOpacity = 1.0;
    });

    // 主卡片弹入动画
    setTimeout(() => {
      animateTo({
        duration: 600,
        curve: Curve.EaseOut
      }, () => {
        this.cardOpacity = 1.0;
        this.cardScale = 1.0;
      });
    }, 200);

    // 步骤卡片渐入动画
    setTimeout(() => {
      animateTo({
        duration: 500,
        curve: Curve.EaseOut
      }, () => {
        this.stepsOpacity = 1.0;
      });
    }, 600);

    // 按钮上移渐入动画
    setTimeout(() => {
      animateTo({
        duration: 400,
        curve: Curve.EaseOut
      }, () => {
        this.buttonOpacity = 1.0;
        this.buttonTranslateY = 0;
      });
    }, 1000);
  }

  /**
   * 打开华为应用市场中的浏览器详情
   */
  openAppStore(): void {
    let context = this.getUIContext().getHostContext() as common.UIAbilityContext;

    let link: string = "https://appgallery.huawei.com/app/detail?id=com.huawei.hmos.browser";
    let openLinkOptions: OpenLinkOptions = {
      // 匹配的abilities选项是否需要通过App Linking域名校验，匹配到唯一配置过的应用ability
      appLinkingOnly: true
    };
    context.openLink(link, openLinkOptions)
  }

  /**
   * 处理彩蛋点击事件
   */
  private handleEasterEggClick(): void {
    this.easterEggClickCount++;
    if (this.easterEggClickCount >= 5) {
      this.showSignature = true;
      this.easterEggClickCount = 0;
    }
  }

  /**
   * 滚动事件处理
   */
  private onScrollEvent(xOffset: number, yOffset: number): void {
    this.scrollOffset = yOffset;
    // 当滚动超过50px时启用毛玻璃效果
    this.isHeaderBlurred = yOffset > 50;
  }

  build() {
    Column() {
      // 头部区域 - 采用鸿蒙设计规范的简约渐变头部
      Column() {
        Column() {
          Text('应用包名获取器')
            .fontSize(28)
            .fontWeight(600)
            .fontColor('#FFFFFF')
            .letterSpacing(0.3)

          Text('Package Name Extractor')
            .fontSize(14)
            .fontColor('#E8F4FD')
            .margin({ top: 6 })
            .letterSpacing(0.1)
            .opacity(0.9)

          // 打开应用详情按钮
          Button() {
            Row({ space: 8 }) {
              Text('打开系统浏览器的应用商场详情')
                .fontSize(16)
                .fontWeight(500)
                .fontColor('#0A59F7')
            }
          }
          .type(ButtonType.Normal)
          .padding({
            left: 16,
            right: 16
          })
          .height(40)
          .backgroundColor('#FFFFFF')
          .borderRadius(20)
          .margin({ top: 16 })
          .shadow({
            radius: 8,
            color: '#20000000',
            offsetX: 0,
            offsetY: 2
          })
          .stateEffect(true)
          .opacity(this.buttonOpacity)
          .translate({ y: this.buttonTranslateY })
          .onClick(() => {
            this.openAppStore()
          })
        }
        .alignItems(HorizontalAlign.Center)
      }
      .width('100%')
      .height(220)
      .linearGradient({
        angle: 135,
        colors: [
          ['#0A59F7', 0.0], // 鸿蒙主题蓝
          ['#1976D2', 0.6], // 深蓝
          ['#42A5F5', 1.0]// 浅蓝
        ]
      })
      .justifyContent(FlexAlign.Center)
      .opacity(this.headerOpacity)
      // 添加毛玻璃效果
      .backdropBlur(this.isHeaderBlurred ? 20 : 0)
      .transition(TransitionEffect.OPACITY.animation({ duration: 300 }))

      Scroll(this.scroller) {
        Column({ space: 20 }) {
          // 功能简介卡片 - 简化设计
          Column({ space: 12 }) {
            Text('功能简介')
              .fontSize(18)
              .fontWeight(600)
              .fontColor('#1A1A1A')
              .alignSelf(ItemAlign.Start)

            Text('从华为应用商城分享链接中快速提取应用包名，支持系统分享接入，一键复制到剪贴板。')
              .fontSize(15)
              .fontColor('#666666')
              .lineHeight(22)
              .textAlign(TextAlign.Start)
          }
          .width('100%')
          .padding(16)
          .backgroundColor('#FFFFFF')
          .borderRadius(12)
          .shadow({
            radius: 6,
            color: '#15000000',
            offsetX: 0,
            offsetY: 1
          })
          .opacity(this.cardOpacity)
          .scale({ x: this.cardScale, y: this.cardScale })

          // 使用步骤卡片 - 简化设计
          Column({ space: 12 }) {
            Text('使用步骤')
              .fontSize(18)
              .fontWeight(600)
              .fontColor('#1A1A1A')
              .alignSelf(ItemAlign.Start)

            Column({ space: 10 }) {
              // 步骤1 - 简化设计
              Row({ space: 12 }) {
                Column() {
                  Text('1')
                    .fontSize(14)
                    .fontWeight(600)
                    .fontColor('#FFFFFF')
                }
                .width(28)
                .height(28)
                .backgroundColor('#0A59F7')
                .borderRadius(14)
                .justifyContent(FlexAlign.Center)

                Column({ space: 2 }) {
                  Text('打开华为应用商城')
                    .fontSize(15)
                    .fontWeight(500)
                    .fontColor('#1A1A1A')
                  Text('找到您需要获取包名的应用')
                    .fontSize(13)
                    .fontColor('#666666')
                }
                .alignItems(HorizontalAlign.Start)
                .layoutWeight(1)
              }
              .width('100%')
              .alignItems(VerticalAlign.Top)

              // 步骤2 - 简化设计
              Row({ space: 12 }) {
                Column() {
                  Text('2')
                    .fontSize(14)
                    .fontWeight(600)
                    .fontColor('#FFFFFF')
                }
                .width(28)
                .height(28)
                .backgroundColor('#0A59F7')
                .borderRadius(14)
                .justifyContent(FlexAlign.Center)

                Column({ space: 2 }) {
                  Text('点击分享按钮')
                    .fontSize(15)
                    .fontWeight(500)
                    .fontColor('#1A1A1A')
                  Text('选择"包名解析/AppBundleNameForShared"')
                    .fontSize(13)
                    .fontColor('#666666')
                }
                .alignItems(HorizontalAlign.Start)
                .layoutWeight(1)
              }
              .width('100%')
              .alignItems(VerticalAlign.Top)

              // 步骤3 - 简化设计
              Row({ space: 12 }) {
                Column() {
                  Text('3')
                    .fontSize(14)
                    .fontWeight(600)
                    .fontColor('#FFFFFF')
                }
                .width(28)
                .height(28)
                .backgroundColor('#0A59F7')
                .borderRadius(14)
                .justifyContent(FlexAlign.Center)

                Column({ space: 2 }) {
                  Text('自动提取包名')
                    .fontSize(15)
                    .fontWeight(500)
                    .fontColor('#1A1A1A')
                  Text('包名信息自动显示，点击即可复制')
                    .fontSize(13)
                    .fontColor('#666666')
                }
                .alignItems(HorizontalAlign.Start)
                .layoutWeight(1)
              }
              .width('100%')
              .alignItems(VerticalAlign.Top)
            }
          }
          .width('100%')
          .padding(16)
          .backgroundColor('#FFFFFF')
          .borderRadius(12)
          .shadow({
            radius: 6,
            color: '#15000000',
            offsetX: 0,
            offsetY: 1
          })
          .opacity(this.stepsOpacity)

          // 彩蛋区域
          if (this.showSignature) {
            Column({ space: 8 }) {
              Text('🎉 彩蛋发现！')
                .fontSize(16)
                .fontWeight(600)
                .fontColor('#0A59F7')
                .alignSelf(ItemAlign.Center)

              Text('Made with ❤️ for HarmonyOS by SummerKaze')
                .fontSize(14)
                .fontColor('#666666')
                .textAlign(TextAlign.Center)

              Button('隐藏')
                .type(ButtonType.Normal)
                .backgroundColor('#F0F0F0')
                .fontColor('#666666')
                .fontSize(12)
                .height(32)
                .borderRadius(16)
                .margin({ top: 8 })
                .onClick(() => {
                  this.showSignature = false;
                })
            }
            .width('100%')
            .padding(16)
            .backgroundColor('#FFFFFF')
            .borderRadius(12)
            .shadow({
              radius: 6,
              color: '#15000000',
              offsetX: 0,
              offsetY: 1
            })
            .transition(TransitionEffect.OPACITY.combine(TransitionEffect.scale({ x: 0, y: 0 })
              .animation({ duration: 300 })))
          }

          // 底部空间
          Column()
            .height(40)
        }
        .width('100%')
        .padding({ left: 16, right: 16, top: 20 })
      }
      .layoutWeight(1)
      .scrollBar(BarState.Off)
      .onScroll((xOffset: number, yOffset: number) => {
        this.onScrollEvent(xOffset, yOffset);
      })

      // 彩蛋触发区域 - 底部隐藏点击区域
      Column() {
        Text('')
          .fontSize(8)
          .fontColor('transparent')
      }
      .width('100%')
      .height(40)
      .justifyContent(FlexAlign.Center)
      .onClick(() => {
        this.handleEasterEggClick();
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F5F5F5')
  }
}