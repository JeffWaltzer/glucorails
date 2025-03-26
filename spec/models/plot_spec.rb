describe Plot do
  it 'generates SVG' do
    plot = Plot.new([[12, 20], [15, 30], [20, 50]])

    hash = Hash.from_xml((plot.to_svg))

    expect(hash).to eq(
                      {
                        "svg" => {
                          "width" => "100%",
                          "height" => "100%",
                          "xmlns" => "http://www.w3.org/2000/svg",
                          "title" => "\nLayer 1\n",
                          "path" => {
                            "d" => "m 12 20 l 15 30 l 20 50",
                            "stroke" => "black",
                            "stroke_width" => "5"
                          }
                        }
                      }
                    )
  end
end