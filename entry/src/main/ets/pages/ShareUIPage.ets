import { common, Want } from '@kit.AbilityKit';
import { systemShare } from '@kit.ShareKit';
import { uniformTypeDescriptor as utd } from '@kit.ArkData';
import { UrlUtils } from '../utils';
import { promptAction } from '@kit.ArkUI';
import { pasteboard } from '@kit.BasicServicesKit';
import { BusinessError } from '@kit.BasicServicesKit';

// 获取共享的storage实例
let storage = LocalStorage.getShared();

@Entry(storage)
@Component
struct SystemShare {
  @State message: string = '';
  @State isLoading: boolean = true; // 加载状态
  @State buttonScale: number = 1.0; // 按钮缩放动画
  @State contentOpacity: number = 0.0; // 内容透明度动画
  @State headerOpacity: number = 0.0; // 头部透明度动画
  @State resultScale: number = 0.8; // 结果区域缩放动画
  @State loadingRotate: number = 0; // 加载旋转动画
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
    // 启动头部动画
    this.startHeaderAnimation();

    try {
      systemShare.getSharedData(this.want).then((data: systemShare.SharedData) => {
        try {
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
        } catch (error) {
          console.error('解析共享数据时发生错误:', error);
        }

        // 数据处理完成，停止加载动画并显示结果
        this.finishLoading();
      }).catch((error: BusinessError) => {
        console.error('获取共享数据失败:', error);
        this.finishLoading();
      });
    } catch (error) {
      console.error('启动共享数据获取失败:', error);
      this.finishLoading();
    }
  }

  /**
   * 启动头部入场动画
   */
  private startHeaderAnimation(): void {
    animateTo({
      duration: 600,
      curve: Curve.EaseOut
    }, () => {
      this.headerOpacity = 1.0;
    });

    // 启动加载旋转动画
    this.startLoadingAnimation();
  }

  /**
   * 启动加载旋转动画
   */
  private startLoadingAnimation(): void {
    animateTo({
      duration: 2000,
      curve: Curve.Linear,
      iterations: -1
    }, () => {
      this.loadingRotate = 360;
    });
  }

  /**
   * 完成加载并显示结果
   */
  private finishLoading(): void {
    setTimeout(() => {
      this.isLoading = false;
      animateTo({
        duration: 500,
        curve: Curve.EaseOut
      }, () => {
        this.contentOpacity = 1.0;
        this.resultScale = 1.0;
      });
    }, 800); // 给用户一点时间看到加载过程
  }

  onBackPress(): boolean | void {
    this.context.terminateSelf();
  }

  /**
   * 复制包名到剪贴板
   */
  async copyText(): Promise<void> {
    try {
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
    } catch (error) {
      console.error('复制到剪贴板失败:', error);
      promptAction.showToast({
        message: '复制失败，请重试',
        duration: 2000
      })
    }
  }

  build() {
    Column() {
      // 头部区域
      Column() {
        Column() {
          Text('应用包名获取器')
            .fontSize(28)
            .fontWeight(700)
            .fontColor('#FFFFFF')
            .letterSpacing(0.5)

          Text('Package Name Extractor')
            .fontSize(14)
            .fontColor('#E8F4FD')
            .margin({ top: 4 })
        }
        .alignItems(HorizontalAlign.Center)
      }
      .width('100%')
      .height(180)
      .linearGradient({
        angle: 135,
        colors: [
          ['#0A59F7', 0.0],  // 鸿蒙主题蓝
          ['#1976D2', 0.6],  // 深蓝
          ['#42A5F5', 1.0]   // 浅蓝
        ]
      })
      .justifyContent(FlexAlign.Center)
      .opacity(this.headerOpacity)

      // 主内容区域
      Column() {
        if (this.isLoading) {
          // 加载状态
          Column() {
            Column() {
              Text('⚡')
                .fontSize(48)
                .rotate({ angle: this.loadingRotate })

              Text('正在解析包名信息')
                .fontSize(18)
                .fontWeight(500)
                .fontColor('#333333')
                .margin({ top: 16 })

              Text('请稍候...')
                .fontSize(14)
                .fontColor('#999999')
                .margin({ top: 8 })

              // 进度指示器
              Row() {
                ForEach([0, 1, 2], (index: number) => {
                  Circle()
                    .width(6)
                    .height(6)
                    .fill('#0A59F7')
                    .margin({ left: index > 0 ? 8 : 0 })
                    .animation({
                      duration: 800,
                      delay: index * 200,
                      curve: Curve.EaseInOut,
                      iterations: -1
                    })
                })
              }
              .margin({ top: 24 })
            }
            .width('100%')
            .padding(40)
            .backgroundColor('#FFFFFF')
            .borderRadius(20)
            .shadow({
              radius: 12,
              color: '#15000000',
              offsetX: 0,
              offsetY: 4
            })
          }
          .width('100%')
          .padding({ left: 24, right: 24 })
          .justifyContent(FlexAlign.Center)
          .layoutWeight(1)

        } else {
          // 结果展示状态
          if (this.message) {
            // 成功获取包名
            Column() {
              Column({ space: 20 }) {
                // 成功图标
                Column() {
                  Text('✅')
                    .fontSize(56)
                }
                .width(80)
                .height(80)
                .backgroundColor('#E8F5E8')
                .borderRadius(40)
                .justifyContent(FlexAlign.Center)

                Column({ space: 12 }) {
                  Text('包名解析成功')
                    .fontSize(20)
                    .fontWeight(600)
                    .fontColor('#1A1A1A')

                  Text('已成功提取应用包名信息')
                    .fontSize(14)
                    .fontColor('#666666')
                }

                // 包名展示区域
                Column() {
                  Text('包名信息')
                    .fontSize(14)
                    .fontColor('#999999')
                    .margin({ bottom: 8 })

                  Text(this.message)
                    .fontSize(16)
                    .fontWeight(500)
                    .fontColor('#333333')
                    .textAlign(TextAlign.Center)
                    .padding(16)
                    .backgroundColor('#F8F9FA')
                    .borderRadius(12)
                    .border({ width: 1, color: '#E0E0E0' })
                    .width('100%')
                    .copyOption(CopyOptions.InApp)
                }
                .width('100%')

                // 操作按钮
                Button() {
                  Row({ space: 8 }) {
                    Text('📋')
                      .fontSize(18)
                    Text('复制包名')
                      .fontSize(16)
                      .fontWeight(500)
                      .fontColor('#FFFFFF')
                  }
                }
                .type(ButtonType.Normal)
                .width('70%')
                .height(44)
                .backgroundColor('#0A59F7')
                .borderRadius(22)
                .margin({ top: 8 })
                .scale({ x: this.buttonScale, y: this.buttonScale })
                .shadow({
                  radius: 8,
                  color: '#400A59F7',
                  offsetX: 0,
                  offsetY: 3
                })
                .stateEffect(true)
                .onClick(() => {
                  this.copyText()
                })
              }
              .width('100%')
              .padding(24)
              .backgroundColor('#FFFFFF')
              .borderRadius(20)
              .shadow({
                radius: 12,
                color: '#15000000',
                offsetX: 0,
                offsetY: 4
              })
              .opacity(this.contentOpacity)
              .scale({ x: this.resultScale, y: this.resultScale })
            }
            .width('100%')
            .padding({ left: 24, right: 24 })
            .justifyContent(FlexAlign.Center)
            .layoutWeight(1)

          } else {
            // 未获取到包名
            Column() {
              Column({ space: 20 }) {
                // 警告图标
                Column() {
                  Text('⚠️')
                    .fontSize(56)
                }
                .width(80)
                .height(80)
                .backgroundColor('#FFF3E0')
                .borderRadius(40)
                .justifyContent(FlexAlign.Center)

                Column({ space: 12 }) {
                  Text('未能获取包名')
                    .fontSize(20)
                    .fontWeight(600)
                    .fontColor('#1A1A1A')

                  Text('请确保从华为应用商城分享正确的应用链接')
                    .fontSize(14)
                    .fontColor('#666666')
                    .textAlign(TextAlign.Center)
                    .lineHeight(20)
                }

                // 返回按钮
                Button() {
                  Text('返回重试')
                    .fontSize(16)
                    .fontWeight(500)
                    .fontColor('#FFFFFF')
                }
                .type(ButtonType.Normal)
                .width('60%')
                .height(44)
                .backgroundColor('#FF9800')
                .borderRadius(22)
                .margin({ top: 16 })
                .stateEffect(true)
                .onClick(() => {
                  this.context.terminateSelf()
                })
              }
              .width('100%')
              .padding(24)
              .backgroundColor('#FFFFFF')
              .borderRadius(20)
              .shadow({
                radius: 12,
                color: '#15000000',
                offsetX: 0,
                offsetY: 4
              })
              .opacity(this.contentOpacity)
              .scale({ x: this.resultScale, y: this.resultScale })
            }
            .width('100%')
            .padding({ left: 24, right: 24 })
            .justifyContent(FlexAlign.Center)
            .layoutWeight(1)
          }
        }

        // 底部品牌信息
        Text('Made with ❤️ for HarmonyOS by SummerKaze')
          .fontSize(12)
          .fontColor('#999999')
          .padding({ bottom: 32 })
      }
      .layoutWeight(1)
      .width('100%')
      .backgroundColor('#F5F5F5')
    }
    .width('100%')
    .height('100%')
  }
}