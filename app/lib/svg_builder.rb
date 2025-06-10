class SvgBuilder
  def initialize(data)
    @data = SvgPoints.new(data)
  end

  def render_from_csv
    svg_canvas = Victor::SVG.new viewBox: [ 0, 0, 1000, 1000 ],
                                preserveAspectRatio: :none,
                                 height: '100%',
                                 width: '100%'

    if @data.empty?
      empty_graph(svg_canvas)
    else
      graph_with_data(svg_canvas)
    end

    svg_canvas.render
  end

  private

  def empty_graph(svg_canvas)
    svg_canvas.text "No data"
  end

  def graph_with_data(svg_canvas)
    viewbox = [
      x_min,
      y_min,
      width,
      height
    ].join(" ")

    svg_canvas.line id: 'x-axis', x1: 0, x2: 1000, y1: 500 , y2: 500, stroke: :black
    svg_canvas.line id: 'y-axis', x1: 1, x2: 1, y1: 0 , y2: 500, stroke: :black

    (0..10).each do |index|
      svg_canvas.line class: 'x-tick',
                      x1: 100*(index),
                      x2: 100*(index),
                      y1: 500 ,
                      y2: 490,
                      stroke: :black
    end

    (0..10).each do |index|
      svg_canvas.line class: 'y-tick',
                      x1: 0,
                      x2: 10,
                      y1: 50*(index),
                      y2: 50*(index),
                      stroke: :black

      y = ((y_max-y_min)*index/10.0 + y_min)/100.0

      svg_canvas.text y.round,
                      x: 12,
                      y: 50*(10-index)+5,
                      class: 'y-tick-label'

    end

    (0..10).each do |index|
      label =Time.at( ((x_max-x_min)*index/10.0 + x_min + @data.min_x ))
      svg_canvas.text label.strftime('%m/%d'),
                      x: 100*(index) - 17,
                      y: 485,
                      class: 'x-tick-label'
    end


    svg_canvas.svg viewBox: viewbox,
                   preserveAspectRatio: :none,
                   width: "100%",
                   height: "50%" do
      svg_canvas.polyline points: @data.points,
                          fill: :none,
                          stroke: :black,
                          stroke_width: "1em"
    end
  end

  def x_min
    0
  end

  def y_min
    @data.map(&:second).min
  end

  def x_max
    @data.map(&:first).map(&:to_i).max
  end

  def y_max
    @data.map(&:second).max
  end

  def width
    x_max - x_min
  end

  def height
    y_max - y_min
  end
end
