export function scrollToFirstTile() {
  const firstTile = document.getElementById("first-tile");
  if (firstTile) {
    firstTile.scrollIntoView({ behavior: "smooth" });
  }
}
