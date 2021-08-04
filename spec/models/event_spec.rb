require "rails_helper"

RSpec.describe Event, type: :model do
  describe "validations" do
    describe "name" do
      it "should be present" do
        expect(build(:event, name: "foo")).to be_valid
        expect(build(:event, name: ""   )).to be_invalid
        expect(build(:event, name: nil  )).to be_invalid
      end
    end

    describe "start_at" do
      it "should be present" do
        expect(build(:event, start_at: "2021-01-01")).to be_valid
        expect(build(:event, start_at: ""          )).to be_invalid
        expect(build(:event, start_at: nil         )).to be_invalid
      end
    end
  end
end
