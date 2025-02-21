require 'victor'

class GraphController < ApplicationController
  def show
    @graph = Victor::SVG.new viewBox: '0 0 10000 10000', style: {background: :lightgreen}
    @graph.rect x: 1000, y: 1000, width: 6000, height: 6000, fill: :white
  end
end
