export interface Work {
  slug: number;
  title: string;
  description: string;
  size: string;
}

export interface Group {
  slug: number;
  title: string;
  description: string;
  image: string;
  prefix?: string;
  suffix?: string;
}

export interface Sale {
  slug: number;
  title: string;
  description: string;
  size: string;
}
