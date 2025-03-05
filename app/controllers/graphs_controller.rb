class GraphsController < ApplicationController
  def show
    render html: Victor::SVG.new.render.html_safe
  end
end
