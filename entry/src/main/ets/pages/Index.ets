import { common, OpenLinkOptions } from '@kit.AbilityKit';

@Entry
@Component
struct Index {
  @State cardOpacity: number = 0.0; // 卡片透明度动画
  @State titleTranslateY: number = -30; // 标题移动动画
  @State imageScale: number = 0.8; // 图片缩放动画
  @State buttonOpacity: number = 0.0; // 按钮透明度动画
  @StorageProp('topAreaHeight')
  topAreaHeight: number = 0
  @StorageProp('bottomAreaHeight')
  bottomAreaHeight: number = 0

  /**
   * 组件即将出现时启动入场动画
   */
  aboutToAppear(): void {
    this.startEntranceAnimation();
  }

  /**
   * 启动入场动画
   */
  private startEntranceAnimation(): void {
    // 标题和卡片入场动画
    animateTo({
      duration: 600,
      curve: Curve.EaseOut
    }, () => {
      this.cardOpacity = 1.0;
      this.titleTranslateY = 0;
    });

    // 图片缩放动画
    setTimeout(() => {
      animateTo({
        duration: 800,
        curve: Curve.EaseInOut
      }, () => {
        this.imageScale = 1.0;
      });
    }, 200);

    // 按钮渐显动画
    setTimeout(() => {
      animateTo({
        duration: 400,
        curve: Curve.EaseOut
      }, () => {
        this.buttonOpacity = 1.0;
      });
    }, 800);
  }

  /**
   * 打开应用商店
   */
  openAppStore(): void {
    let context = this.getUIContext().getHostContext() as common.UIAbilityContext;
    let link: string = "https://appgallery.huawei.com/app/detail?id=org.xbgroup.clashbox";
    let openLinkOptions: OpenLinkOptions = {
      // 匹配的abilities选项是否需要通过App Linking域名校验，匹配到唯一配置过的应用ability
      appLinkingOnly: true
    };
    context.openLink(link, openLinkOptions)

    // let want: Want = {
    //   bundleName: 'com.huawei.appmarket',
    //   abilityName: 'com.huawei.appmarket.MainAbility',
    //   action: 'viewAction',
    // };
    //
    // context.startAbility(want)
  }

  build() {
    Stack() {
      Scroll() {
        Column({ space: 0 }) {
          // 页面标题区域
          Column() {
            Text('应用包名获取器')
              .fontSize(36)
              .fontWeight(FontWeight.Bold)
              .fontColor(Color.White)
              .textShadow({
                radius: 2,
                offsetX: 0,
                offsetY: 2,
                color: '#40000000'
              })
              .translate({ y: this.titleTranslateY })
              .opacity(this.cardOpacity)

            Text('Package Name Extractor')
              .fontSize(18)
              .fontColor('#E0FFFFFF')
              .margin({ top: 8 })
              .opacity(this.cardOpacity)

            Text('📱 使用教程')
              .fontSize(24)
              .fontWeight(FontWeight.Medium)
              .fontColor('#F0FFFFFF')
              .margin({ top: 30 })
              .opacity(this.cardOpacity)
          }
          .margin({ top: 50, bottom: 30 })

          // 主要内容卡片
          Column({ space: 25 }) {
            // 操作提示卡片
            Column() {
              Text('📝 操作步骤')
                .fontSize(22)
                .fontWeight(FontWeight.Bold)
                .fontColor('#333333')
                .margin({ bottom: 15 })

              Text('请从应用商城中以分享的方式打开此应用以获取包名')
                .fontSize(18)
                .fontWeight(FontWeight.Medium)
                .textAlign(TextAlign.Center)
                .fontColor('#666666')
                .lineHeight(26)
                .padding({ left: 16, right: 16 })
            }
            .width('100%')
            .padding(20)
            .backgroundColor(Color.White)
            .borderRadius(16)
            .shadow({
              radius: 15,
              color: '#20000000',
              offsetX: 0,
              offsetY: 8
            })

            // 教程图片区域
            Column({ space: 20 }) {
              Text('📖 详细教程')
                .fontSize(20)
                .fontWeight(FontWeight.Bold)
                .fontColor('#333333')
                .margin({ bottom: 10 })

              // 教程图片1
              Column() {
                Text('步骤一：分享应用')
                  .fontSize(16)
                  .fontWeight(FontWeight.Medium)
                  .fontColor('#666666')
                  .margin({ bottom: 12 })

                Image($r('app.media.course'))
                  .width('100%')
                  .borderRadius(12)
                  .scale({ x: this.imageScale, y: this.imageScale })
                  .shadow({
                    radius: 8,
                    color: '#20000000',
                    offsetX: 0,
                    offsetY: 4
                  })
              }
              .width('100%')
              .padding(16)
              .backgroundColor('#F8F9FA')
              .borderRadius(12)

              // 教程图片2
              Column() {
                Text('步骤二：选择分享方式')
                  .fontSize(16)
                  .fontWeight(FontWeight.Medium)
                  .fontColor('#666666')
                  .margin({ bottom: 12 })

                Image($r('app.media.paste'))
                  .width('100%')
                  .borderRadius(12)
                  .scale({ x: this.imageScale, y: this.imageScale })
                  .shadow({
                    radius: 8,
                    color: '#20000000',
                    offsetX: 0,
                    offsetY: 4
                  })
              }
              .width('100%')
              .padding(16)
              .backgroundColor('#F8F9FA')
              .borderRadius(12)

              // 教程图片3
              Column() {
                Text('步骤三：查看包名结果')
                  .fontSize(16)
                  .fontWeight(FontWeight.Medium)
                  .fontColor('#666666')
                  .margin({ bottom: 12 })

                Image($r('app.media.search'))
                  .width('100%')
                  .borderRadius(12)
                  .scale({ x: this.imageScale, y: this.imageScale })
                  .shadow({
                    radius: 8,
                    color: '#20000000',
                    offsetX: 0,
                    offsetY: 4
                  })
              }
              .width('100%')
              .padding(16)
              .backgroundColor('#F8F9FA')
              .borderRadius(12)
            }
            .width('100%')
            .padding(20)
            .backgroundColor(Color.White)
            .borderRadius(16)
            .shadow({
              radius: 15,
              color: '#20000000',
              offsetX: 0,
              offsetY: 8
            })

            // 快捷操作按钮
            Button() {
              Row() {
                Text('🛒')
                  .fontSize(22)
                  .margin({ right: 8 })
                Text('打开ClashBox应用商城详情（需港区账号）')
                  .fontSize(18)
                  .fontWeight(FontWeight.Bold)
                  .fontColor(Color.White)
              }
            }
            .type(ButtonType.Normal)
            .borderRadius(25)
            .width('70%')
            .height(50)
                         .linearGradient({
               angle: 90,
               colors: [
                 ['#66ccff', 0.0],  // 主题蓝色
                 ['#4da6ff', 1.0]   // 深蓝色
               ]
             })
            .shadow({
              radius: 10,
              color: '#40000000',
              offsetX: 0,
              offsetY: 4
            })
            .opacity(this.buttonOpacity)
            .onClick(() => {
              this.openAppStore()
            })

          }
          .width('100%')
          .padding({ left: 20, right: 20 })
          .opacity(this.cardOpacity)
          .scale({ x: this.cardOpacity, y: this.cardOpacity })

          // 底部空间
          Column()
            .height(50)

          // 底部品牌信息
          Text('Made with ❤️ for HarmonyOS by SummerKaze')
            .fontSize(14)
            .fontColor('#C0FFFFFF')
            .margin({ bottom: 30 })
            .opacity(this.cardOpacity)

        }
        .width('100%')
      }
      .width('100%')
      .height('100%')
      .scrollBar(BarState.Off)
    }
    .linearGradient({
      angle: 135,
      colors: [
        ['#4a90e2', 0.0],  // 深蓝色
        ['#66ccff', 0.5],  // 主题蓝色
        ['#87ceeb', 1.0]   // 天空蓝
      ]
    })
    .width('100%')
    .height('100%')
  }
}