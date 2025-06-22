import { common, OpenLinkOptions, Want } from '@kit.AbilityKit';
import { systemShare } from '@kit.ShareKit';
import { uniformTypeDescriptor as utd } from '@kit.ArkData';
import { UrlUtils } from '../utils/UrlUtils';
import { promptAction } from '@kit.ArkUI';
import { pasteboard } from '@kit.BasicServicesKit';

// 获取共享的storage实例
// Obtaining a Shared Storage Instance
let storage = LocalStorage.getShared();

@Entry(storage)
@Component
struct SystemShare {
  @State message: string = '';
  private want: Want | undefined = storage.get<Want>('ShareUIAbilityWant');

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
    })
  }

  // 打开应用商店
  openAppStore(): void {
    let context = this.getUIContext().getHostContext() as common.UIAbilityContext;
    let link: string = "https://appgallery.huawei.com/app/detail?id=com.huawei.hmos.vmall";
    let openLinkOptions: OpenLinkOptions = {
      // 匹配的abilities选项是否需要通过App Linking域名校验，匹配到唯一配置过的应用ability
      appLinkingOnly: true
    };
    context.openLink(link, openLinkOptions)
  }

  // 复制包名
  async copyText(): Promise<void> {
    // 创建一条纯文本类型的剪贴板内容对象
    let pasteData = pasteboard.createData(pasteboard.MIMETYPE_TEXT_PLAIN, this.message);
    // 将数据写入系统剪贴板
    let systemPasteboard = pasteboard.getSystemPasteboard();
    await systemPasteboard.setData(pasteData);

    promptAction.showToast({
      message: '包名已复制到剪贴板'
    })
  }

  build() {
    Row() {
      Column() {
        if (this.message) {
          Text(this.message)
            .fontSize(20)
            .fontWeight(FontWeight.Bold)
        } else {
          Text('请从应用商城中以分享的方式打开此应用以获取包名')
            .fontSize(40)
            .fontWeight(FontWeight.Bold)
        }

        if (this.message) {
          Button() {
            Text(this.message ? '复制包名' : '打开应用商店')
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
            this.message ? this.copyText() : this.openAppStore()
          })
        }
      }
      .width('100%')
    }
    .height('100%')
  }
}