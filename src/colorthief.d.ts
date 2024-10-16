declare module "colorthief" {
  export default class ColorThief {
    getColor(img: HTMLImageElement | string): Promise<[number, number, number]>;
    getPalette(img: HTMLImageElement | string, colorCount?: number): Promise<[number, number, number][]>;
  }
}
