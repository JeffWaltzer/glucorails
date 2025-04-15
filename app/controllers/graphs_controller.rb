class GraphsController < ApplicationController
  def show
    # TODO: fix to use csv instead of 'junk'
    render xml: SvgBuilder.new("junk").render_from_csv
  end
end
