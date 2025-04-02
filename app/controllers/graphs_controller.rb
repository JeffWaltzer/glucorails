class GraphsController < ApplicationController
  def show
    vg = Victor::SVG.new viewBox: '0 0 100 100',
                        width: 640,
                        height: 480
    vg.g do
      vg.title "Layer 1"
      vg.path d: "m127,301l58,-69l121,-25l96,-39l68,229",
              stroke: "#000000",
              stroke_width: 5
    end

    render xml: vg.render
  end
end


#     <<~SVG
#     <?xml version="1.0"?>
#     <svg width="640" height="480" xmlns="http://www.w3.org/2000/svg" xmlns:svg="http://www.w3.org/2000/svg">
#      <!-- Created with SVG-edit - https://github.com/SVG-Edit/svgedit-->
#      <g class="layer">
#       <title>Layer 1</title>
#       <path d="m127,301l58,-69l121,-25l96,-39l68,229" fill="none" fill-opacity="null" id="svg_3" stroke="#000000" stroke-dasharray="null" stroke-linecap="null" stroke-linejoin="null" stroke-opacity="null" stroke-width="5"/>
#      </g>
#     </svg>
# SVG

