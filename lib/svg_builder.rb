
class SvgBuilder
  def initialize(data)
  end

  def render_from_csv
    vg = Victor::SVG.new viewBox: '0 0 100 100',
                         width: 640,
                         height: 480
    vg.g do
      vg.path d: "m127,301l58,-69l121,-25l96,-39l68,229",
              stroke: "#000000",
              stroke_width: 5
    end
    vg.render
  end
end

