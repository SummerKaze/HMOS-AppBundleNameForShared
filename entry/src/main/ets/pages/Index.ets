import { common, OpenLinkOptions } from '@kit.AbilityKit';

@Entry
@Component
struct Index {
  // 打开应用商店
  openAppStore(): void {
    let context = this.getUIContext().getHostContext() as common.UIAbilityContext;
    let link: string = "https://appgallery.huawei.com/app/detail?id=com.huawei.hmos.vmall";
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
    Scroll() {
      Column({ space: 20 }) {
        Text('请从应用商城中以分享的方式打开此应用以获取包名')
          .fontSize(30)
          .fontWeight(FontWeight.Bold)
          .fontColor('#6CF')

        Text('教程如下图:')
          .fontSize(30)
          .fontWeight(FontWeight.Bold)

        Image($r('app.media.course'))
          .width('90%')

        Image($r('app.media.paste'))
          .width('90%')

        Image($r('app.media.search'))
          .width('90%')

        // TODO: 拉取应用市场
        /*Button() {
          Text('打开应用商城')
            .fontSize(25)
            .fontColor($r('sys.color.comp_background_list_card'))
            .fontWeight(FontWeight.Bold)
        }
        .type(ButtonType.Capsule)
        .margin({ top: 20 })
        .backgroundColor('#6CF')
        .width('40%')
        .height('5%')
        .onClick(() => {
          this.openAppStore()
        })*/
      }
      .width('100%')
    }
    .padding(10)
  }
}