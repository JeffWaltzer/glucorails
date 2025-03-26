describe Plot do
  xit 'generates SVG' do
    plot = Plot.new([[12,20],[15,30],[20,50]])
    expect(plot.to_svg).to eq <<-SVG
        <?xml version="1.0"?>
        <svg width="640" height="480" xmlns="http://www.w3.org/2000/svg" xmlns:svg="http://www.w3.org/2000/svg">
         <g class="layer">
          <title>Layer 1</title>
          <path d="m 12 20 l 15 30 l 20 50" fill="none" fill-opacity="null" id="svg_3" stroke="#000000" stroke-dasharray="null" stroke-linecap="null" stroke-linejoin="null" stroke-opacity="null" stroke-width="5"/>
         </g>
        </svg>
    SVG
  end
end