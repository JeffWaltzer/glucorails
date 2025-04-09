class GraphsController < ApplicationController
  def show
    render xml: SvgBuilder.new.render_from_csv
  end

end
