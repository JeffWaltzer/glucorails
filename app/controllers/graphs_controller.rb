class GraphsController < ApplicationController
  def show
    fake_data = [
      [ DateTime.parse("2025-02-14T03:56+07:00"),  98 ],
      [ DateTime.parse("2025-02-14T04:01+07:00"), 190 ],
      [ DateTime.parse("2025-02-14T04:06+07:00"), 150 ],
      [ DateTime.parse("2025-02-14T04:07+07:00"), 200 ]
    ]

    render xml: SvgBuilder.new(fake_data).render_from_csv
  end
end
