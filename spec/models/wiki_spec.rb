require 'rails_helper'

RSpec.describe Wiki, type: :model do
  let(:title) { RandomData.random_sentence }
  let(:body) { RandomData.random_paragraph }

  describe "attributes" do
    it "has title and body" do
      expect(wiki).to have_attributes(title: title, body: body)
    end
  end
end
