import { common, Want } from '@kit.AbilityKit';
import { systemShare } from '@kit.ShareKit';
import { uniformTypeDescriptor as utd } from '@kit.ArkData';
import { UrlUtils } from '../utils';
import { promptAction } from '@kit.ArkUI';
import { pasteboard } from '@kit.BasicServicesKit';

// 获取共享的storage实例
let storage = LocalStorage.getShared();

@Entry(storage)
@Component
struct SystemShare {
  @State message: string = '';
  @State buttonScale: number = 1.0; // 按钮缩放动画
  @State cardOpacity: number = 0.0; // 卡片透明度动画
  @State titleTranslateY: number = -50; // 标题移动动画
  @State packageNameRotate: number = 0; // 包名旋转动画
  private want: Want | undefined = storage.get<Want>('ShareUIAbilityWant');
  private context = this.getUIContext().getHostContext() as common.UIAbilityContext;
  @StorageProp('topAreaHeight')
  topAreaHeight: number = 0
  @StorageProp('bottomAreaHeight')
  bottomAreaHeight: number = 0

  /**
   * 组件即将出现时的生命周期函数
   * 获取共享数据并启动入场动画
   */
  aboutToAppear(): void {
    systemShare.getSharedData(this.want).then((data: systemShare.SharedData) => {
      let records: systemShare.SharedRecord[] = data.getRecords();
      records.forEach(async (record: systemShare.SharedRecord) => {
        switch (record.utd) {
          // 文本类型
          case utd.UniformDataType.TEXT:
            record.content && (this.message = UrlUtils.extractPackageName(record.content));
            break;
        // 超链接类型
          case utd.UniformDataType.HYPERLINK:
            record.content && (this.message = UrlUtils.extractPackageName(record.content));
            break;
          default:
            break;
        }
      });

      // 启动入场动画
      this.startEntranceAnimation();
    })
  }

  /**
   * 启动入场动画
   */
  private startEntranceAnimation(): void {
    animateTo({
      duration: 800,
      curve: Curve.EaseOut
    }, () => {
      this.cardOpacity = 1.0;
      this.titleTranslateY = 0;
    });

    // 包名旋转动画
    setTimeout(() => {
      animateTo({
        duration: 600,
        curve: Curve.EaseInOut
      }, () => {
        this.packageNameRotate = 360;
      });
    }, 300);
  }

  onBackPress(): boolean | void {
    this.context.terminateSelf();
  }

  /**
   * 复制包名到剪贴板
   */
  async copyText(): Promise<void> {
    // 按钮点击动画
    animateTo({
      duration: 100,
      curve: Curve.EaseInOut
    }, () => {
      this.buttonScale = 0.9;
    });

    setTimeout(() => {
      animateTo({
        duration: 100,
        curve: Curve.EaseInOut
      }, () => {
        this.buttonScale = 1.0;
      });
    }, 100);

    // 创建一条纯文本类型的剪贴板内容对象
    let pasteData = pasteboard.createData(pasteboard.MIMETYPE_TEXT_PLAIN, this.message);
    // 将数据写入系统剪贴板
    let systemPasteboard = pasteboard.getSystemPasteboard();
    await systemPasteboard.setData(pasteData);

    promptAction.showToast({
      message: '包名已复制到剪贴板',
      duration: 2000
    })

    // 关闭应用
    setTimeout(() => {
      this.context.terminateSelf();
    }, 500)
  }

  build() {
    Stack() {
      Column() {
        // 标题部分
        Column() {
          Text('应用包名获取器')
            .fontSize(32)
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
            .fontSize(16)
            .fontColor('#E0FFFFFF')
            .margin({ top: 8 })
            .opacity(this.cardOpacity)
        }
        .margin({ top: 60, bottom: 40 })

        // 主要内容卡片
        Column() {
          if (this.message) {
            // 成功获取包名的展示
            Column() {
              Text('📦')
                .fontSize(60)
                .margin({ bottom: 20 })
                .rotate({ angle: this.packageNameRotate })

              Text('包名信息')
                .fontSize(18)
                .fontColor('#666666')
                .margin({ bottom: 10 })

              Text(this.message)
                .fontSize(20)
                .fontWeight(FontWeight.Medium)
                .textAlign(TextAlign.Center)
                .fontColor('#333333')
                .padding(16)
                .backgroundColor('#F5F5F5')
                .borderRadius(12)
                .width('100%')
                .copyOption(CopyOptions.InApp)

              Button() {
                Row() {
                  Text('📋')
                    .fontSize(20)
                    .margin({ right: 8 })
                  Text('复制包名')
                    .fontSize(18)
                    .fontWeight(FontWeight.Bold)
                    .fontColor(Color.White)
                }
              }
              .type(ButtonType.Normal)
              .borderRadius(25)
              .margin({ top: 30 })
              .width('60%')
              .height(50)
              .scale({ x: this.buttonScale, y: this.buttonScale })
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
              .onClick(() => {
                this.copyText()
              })
            }
            .animation({
              duration: 300,
              curve: Curve.EaseInOut
            })

          } else {
            // 等待获取包名的提示
            Column() {
              Text('🔍')
                .fontSize(80)
                .margin({ bottom: 30 })

              Text('请从应用商城中以分享的方式打开此应用')
                .fontSize(18)
                .fontWeight(FontWeight.Medium)
                .textAlign(TextAlign.Center)
                .fontColor('#666666')
                .lineHeight(28)

              Text('以获取应用包名信息')
                .fontSize(18)
                .fontWeight(FontWeight.Medium)
                .textAlign(TextAlign.Center)
                .fontColor('#666666')
                .margin({ top: 8 })

              // 加载动画点
              Row() {
                ForEach([0, 1, 2], (index: number) => {
                  Circle()
                    .width(8)
                    .height(8)
                    .fill('#66ccff')  // 主题蓝色
                    .margin({ left: index > 0 ? 8 : 0 })
                })
              }
              .margin({ top: 30 })
              .animation({
                duration: 1500,
                curve: Curve.EaseInOut,
                iterations: -1
              })
            }
          }
        }
        .padding(30)
        .backgroundColor(Color.White)
        .borderRadius(20)
        .margin({ left: 20, right: 20 })
        .shadow({
          radius: 20,
          color: '#30000000',
          offsetX: 0,
          offsetY: 10
        })
        .opacity(this.cardOpacity)
        .scale({ x: this.cardOpacity, y: this.cardOpacity })

        Blank()

        // 底部提示
        Text('Made with ❤️ for HarmonyOS by SummerKaze')
          .fontSize(14)
          .fontColor('#C0FFFFFF')
          .margin({ bottom: 40 })
          .opacity(this.cardOpacity)

      }
      .width('100%')
      .height('100%')
      .justifyContent(FlexAlign.Start)
    }
    .width('100%')
    .height('100%')
    .linearGradient({
      angle: 135,
      colors: [
        ['#4a90e2', 0.0],  // 深蓝色
        ['#66ccff', 0.5],  // 主题蓝色
        ['#87ceeb', 1.0]   // 天空蓝
      ]
    })
  }
}