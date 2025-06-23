import { window } from '@kit.ArkUI'

export class FullScreen { // 开启沉浸式
  static async enable() {
    try { // 获取上下文对象
      const context = AppStorage.get<Context>('context')
      if (context) {
        // 获取最后一个窗口实例
        const win = await window.getLastWindow(context)
        // 获取上方安全区高度
        const topArea = win.getWindowAvoidArea(window.AvoidAreaType.TYPE_SYSTEM)
        // 这里获取到的是px单位需要进行转换
        AppStorage.setOrCreate('topAreaHeight', px2vp(topArea.topRect.height))
        // 获取下方安全区高度
        const bottomArea = win.getWindowAvoidArea(window.AvoidAreaType.TYPE_NAVIGATION_INDICATOR)
        AppStorage.setOrCreate('bottomAreaHeight', px2vp(bottomArea.bottomRect.height))
        // 开启沉浸式
        win.setWindowLayoutFullScreen(true)
      }
    } catch (e) {
      console.error('enable fullScreen failed, error: ', JSON.stringify(e))
    }
  }

  // 关闭沉浸式
  static async disable() {
    try { // 获取上下文对象
      const context = AppStorage.get<Context>('context')
      if (context) {
        // 获取最后一个窗口实例
        const win = await window.getLastWindow(context)
        // 开启沉浸式
        win.setWindowLayoutFullScreen(false)
        // 清空上方安全区高度
        AppStorage.setOrCreate('topAreaHeight', 0)
        // 清空下方安全区高度
        AppStorage.setOrCreate('bottomAreaHeight', 0)
      }
    } catch (e) {
      console.error('disable fullScreen failed, error: ', JSON.stringify(e))
    }
  }
}