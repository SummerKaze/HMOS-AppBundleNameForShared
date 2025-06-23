import { AbilityConstant, ConfigurationConstant, UIAbility, Want } from '@kit.AbilityKit';
import { hilog } from '@kit.PerformanceAnalysisKit';
import { window } from '@kit.ArkUI';
import { FullScreen } from '../utils';

const DOMAIN = 0x0000;

interface Storage {
  ShareUIAbilityWant: Want
}

export default class EntryAbility extends UIAbility {
  private storageWant: Want = {}

  onCreate(want: Want, launchParam: AbilityConstant.LaunchParam): void {
    this.context.getApplicationContext().setColorMode(ConfigurationConstant.ColorMode.COLOR_MODE_NOT_SET);
    hilog.info(DOMAIN, 'testTag', '%{public}s', 'Ability onCreate');
    this.storageWant = want;
    AppStorage.setOrCreate<Context>('context', this.context)
  }

  onNewWant(want: Want, launchParam: AbilityConstant.LaunchParam): void {
  }

  onDestroy(): void {
    hilog.info(DOMAIN, 'testTag', '%{public}s', 'Ability onDestroy');
  }

  async onWindowStageCreate(windowStage: window.WindowStage): Promise<void> {
    let para: Storage = { ShareUIAbilityWant: this.storageWant };
    let storage = new LocalStorage(para);
    FullScreen.enable()
    windowStage.loadContent('pages/Index', storage);
  }

  onWindowStageDestroy(): void {
    // Main window is destroyed, release UI related resources
    hilog.info(DOMAIN, 'testTag', '%{public}s', 'Ability onWindowStageDestroy');
  }

  onForeground(): void {
    // Ability has brought to foreground
    hilog.info(DOMAIN, 'testTag', '%{public}s', 'Ability onForeground');
  }

  onBackground(): void {
    // Ability has back to background
    hilog.info(DOMAIN, 'testTag', '%{public}s', 'Ability onBackground');
  }
}