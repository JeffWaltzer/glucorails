class Plot
  def initialize(points)
  end

  def to_svg
    svg= Victor::SVG.new
    svg.title "Layer 1"
    svg.path d: "m 12 20 l 15 30 l 20 50",
             stroke: "black",
             stroke_width: 5
    svg.render
  end

end