export interface Series {
  slug: string;
  title: string;
  prefix?: string;
  suffix?: string;
  description: string;
  image: string;
  editions: number;
  date: string;
  material?: string;
}

export interface Print {
  slug: string;
  title: string;
  description: string;
  image: string;
  series: string;
}
