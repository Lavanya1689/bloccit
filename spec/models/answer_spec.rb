require 'rails_helper'

RSpec.describe Answer, type: :model do
  let(:question){
    Question.create!(title: "New Question Title", body: "New Question Body", resolved: true)
  }
  let(:answer){
    Answer.create!(body: "New Answer body", question: question)
  }

  describe "attributes" do
    it "has new attributes" do
      expect(answer).to have_attributes(body: "New Answer body", question: question)
    end
  end
end
