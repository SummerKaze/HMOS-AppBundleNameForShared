/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2024-2024. All rights reserved.
 */

const TAG = 'HuaweiShare';

const loggerMap: Map<string, Logger> = new Map();

class Logger {
  private static readonly singleton = new Logger();

  private constructor(tag?: string) {
    this._tag = tag;
  }

  private _tag: string | undefined = undefined;

  private get tag(): string {
    return this._tag ? this._tag : '';
  }

  private static getOrCreate(tag: string): Logger {
    let loggerInstance = loggerMap.get(tag);
    if (!loggerInstance) {
      loggerInstance = new Logger(tag);
      loggerMap.set(tag, loggerInstance);
    }
    return loggerInstance;
  }

  static getLogger(tag?: string): Logger {
    return tag ? Logger.getOrCreate(tag) : Logger.singleton;
  }

  info(...args: any[]): void {
    console.info(`${TAG}-${this.tag}: ${args.join(' ')}`);
  }

  debug(...args: any[]): void {
    console.debug(`${TAG}-${this.tag}: ${args.join(' ')}`);
  }

  warn(...args: any[]): void {
    console.warn(`${TAG}-${this.tag}: ${args.join(' ')}`);
  }

  error(...args: any[]): void {
    console.error(`${TAG}-${this.tag}: ${args.join(' ')}`);
  }
}

export default Logger;