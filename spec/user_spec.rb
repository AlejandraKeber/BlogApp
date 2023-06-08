require 'rails_helper'

RSpec.describe User, type: :model do
  subject { User.new(name: 'Test User', photo: 'www.testimage.com', bio: 'User generated for test') }

  before { subject.save }

  it 'Name should be present' do
    subject.Name = nil
    expect(subject).to_not be_valid
  end

  it 'PostsCounter should be greater than or equal to 0' do
    subject.PostsCounter = -1
    expect(subject).to_not be_valid
  end

  it 'PostsCounter should be greater than or equal to 0' do
    subject.PostsCounter = 15
    expect(subject).to be_valid
  end

  it 'Return last three posts for user' do
    expect(subject.recent_posts).to eq([])
  end
end
