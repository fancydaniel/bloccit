require 'rails_helper'


describe Vote do
  describe "validations" do

    before do
       @vote = Vote.new(value: -1)
     end

    describe "value validation" do
      it "only allows -1 or 1 as values" do
        expect (@vote.value).to eq(-1, 1)    # your expectations here
      end
    end

  end
end
