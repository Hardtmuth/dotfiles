style: """
  // Change bar height
  bar-height = 16px

  // Align contents left or right
  widget-align = left

  // Opposite of align
  if (widget-align == left)
    widget-align-anti = right
  else
    widget-align-anti = left

  // Position this where you want
  top 42vw
  left 1.5vw

  // Statistics text settings
  color #f1f1f1
  font-family Helvetica Neue
  background rgba(#000, .3)
  padding 10px 10px 10px
  border-radius 5px

  .container
    width: 275px

  td
    color: rgba(#f1f1f1, .8)

  .widget-title
    font-size 12px
    text-transform uppercase

  .label
    font-size 12px
"""


render: -> """
  <div class="container">
    <div class="widget-title">
      <div class="widget-name">Shortcut Helper</div>
    </div>
    <hr>
    <table class="stats-container" width="100%">
      <tr>
        <td class="label">change window focus:</td>
        <td class="label">⌥  H / J / K / L </td>
      </tr>
      <tr>
        <td class="label">swap windows:</td>
        <td class="label">⇧ ⌥  H / J / K / L</td>
      </tr>
      <tr>
        <td class="label">resize windows:</td>
        <td class="label">⌃ ⌥  H / J / K / L</td>
      </tr>
      <tr>
        <td class="label">move window to space:</td>
        <td class="label">⇧ ⌥ 1...7</td>
      </tr>
      <tr>
        <td class="label">toggle window float:</td>
        <td class="label">⇧ ⌥  T</td>
      </tr>
      <tr>
        <td class="label">rotate layout clockwise:</td>
        <td class="label">⇧ ⌥ R</td>
      </tr>
      <tr>
        <td class="label">flip along x/y-axis:</td>
        <td class="label">⇧ ⌥ X / Y</td>
      </tr>

      <tr>
        <td class="label">focus between displays:</td>
        <td class="label">⌥  S / G</td>
      </tr>
      <tr>
        <td class="label">move window to display:</td>
        <td class="label">⇧ ⌥  S / G</td>
      </tr>
    </table>
  </div>
"""