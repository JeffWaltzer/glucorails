require 'rails_helper'

RSpec.describe SvgComponents::Base do
  describe '#scale_to_x' do
    it '50 for 0' do
      expect(SvgComponents::Base.scale_to_x(0)).to eq 50
    end

    it '1000 for 10' do
      expect(SvgComponents::Base.scale_to_x(10)).to eq 1000
    end

    it '525 for 5' do
      expect(SvgComponents::Base.scale_to_x(5)).to eq 525
    end

  end
end
