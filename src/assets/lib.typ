#import "@preview/touying:0.5.5": *

#let slide(
  config: (:),
  repeat: auto,
  setting: body => body,
  composer: auto,
  ..bodies,
) = touying-slide-wrapper(self => {
  let header(self) = {
    // text(utils.call-or-display(self, self.store.header))
    set text(size: 1.3em)
    place(
      left,
      dx: 1.5em,
      dy: 1.5em,
      utils.call-or-display(
        self,
        utils.call-or-display(self, self.store.header),
      ),
    )
  }
  let footer(self) = {
    set text(size: 0.8em)
    place(
      right,
      dx: -2em,
      utils.slide-counter.display() + " of " + utils.last-slide-number,
    )
  }
  let self = utils.merge-dicts(
    self,
    config-page(
      header: header,
      footer: footer,
    ),
  )
  touying-slide(
    self: self,
    config: config,
    repeat: repeat,
    setting: setting,
    composer: composer,
    ..bodies,
  )
})


/// Outline slide for the presentation.
#let cover-slide(leading: 50pt) = touying-slide-wrapper(self => {
  set text(size: 28pt)
  set par(leading: leading)

  let body = {
    grid(
      columns: (1fr, 1fr),
      rows: 1fr,
      gutter: 3em,
      align(
        center + horizon,
        {
          set par(leading: 20pt)
          context {
            text(self.info.title)
            v(1em)
            text(size: 20pt, weight: "regular", self.info.author)
            if self.info.institution != none {
              v(0.1em)
              text(size: 20pt, weight: "regular", self.info.institution)
            }
            if self.info.date != none {
              v(0.1em)
              text(
                size: 14pt,
                utils.display-info-date(self),
              )
            }
          }
        },
      ),
      align(
        left + horizon,
        {
          set par(leading: leading)
          set text(size: 24pt)
          components.custom-progressive-outline(
            level: none,
            depth: 1,

            numbered: (true,),
          )
        },
      ),
    )
  }
  self = utils.merge-dicts(
    self,
    config-common(freeze-slide-counter: true),
    config-page(margin: 0em),
  )
  touying-slide(self: self, body)
})


#let focus-slide(body) = touying-slide-wrapper(self => {
  self = utils.merge-dicts(
    self,
    config-common(freeze-slide-counter: true),
  )
  touying-slide(self: self, align(horizon + center, body))
})


#let escher-theme(
  aspect-ratio: "16-9",
  header: self => utils.display-current-heading(depth: self.slide-level),
  footer: context utils.slide-counter.display(),
  ..args,
  body,
) = {
  set text(size: 20pt)
  // set heading(numbering: "1 |")
  show heading.where(level: 1): set heading(numbering: "1 |")
  show heading.where(level: 2): set heading(numbering: "1.1 |")

  show: touying-slides.with(
    config-page(
      paper: "presentation-" + aspect-ratio,
      margin: (x: 4em, top: 4.5em, bottom: 3em),
    ),
    config-common(
      slide-fn: slide,
      datetime-format: "[month repr:long] [day padding:none], [year]",
    ),
    config-methods(
      init: (self: none, body) => {
        show strong: self.methods.alert.with(self: self)
        body
      },
      alert: utils.alert-with-primary-color,
    ),
    // save the variables for later use
    config-store(
      align: align,
      header: header,
      footer: footer,
    ),
    ..args,
  )

  // Global style ////////////////////////////////////////////////
  set text(font: "New Computer Modern")
  set par(leading: 1.5em)
  set align(horizon)
  set list(marker: "▶")
  /////////////////////////////////////////////////////////////////

  body
}
