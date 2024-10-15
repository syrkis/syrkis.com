// syrkis.com/src/utils/scrollTo.ts
export function scrollTo(selector: string) {
  const element = document.querySelector(selector);
  if (element) {
    element.scrollIntoView({ behavior: "smooth" });
  }
}
