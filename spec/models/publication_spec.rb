require 'rails_helper'

describe Publication, type: :model do
  it 'should not publish without message' do
    Publication.create(message: '')

    expect(Publication.all.count).to eq 0
  end
end
