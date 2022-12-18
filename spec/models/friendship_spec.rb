# == Schema Information
#
# Table name: friendships
#
#  id         :bigint           not null, primary key
#  status     :integer          default("pending"), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  friend_id  :bigint           not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_friendships_on_friend_id              (friend_id)
#  index_friendships_on_friend_id_and_user_id  (friend_id,user_id) UNIQUE
#  index_friendships_on_user_id                (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (friend_id => users.id)
#  fk_rails_...  (user_id => users.id)
#
require 'rails_helper'

RSpec.describe Friendship, type: :model do
  let!(:friendship) { create(:friendship) }

  describe 'associations' do
    it { should belong_to(:user) }
    it { should belong_to(:friend).class_name('User') }
  end
  
  describe 'validations' do
    it { should validate_presence_of(:user) }
    it { should validate_presence_of(:friend) }
    it { should validate_uniqueness_of(:friend).scoped_to(:user_id) }
  end

  describe 'enum' do
    let!(:statuses) { { pending: 0, accepted: 1 } } 
    it { should define_enum_for(:status).with_values(statuses) }
  end

  describe 'callbacks' do
    it 'creates inverse friendship after creation' do
      expect(friendship).to receive(:create_inverse_friendship)
      friendship.run_callbacks(:create)
    end

    it 'destroys inverse friendship after destroying' do
      expect(friendship).to receive(:destroy_inverse_friendship)
      friendship.destroy
    end

    it 'updates status of the inverse friendship after updating' do
      expect(friendship).to receive(:update_inverse_status)
      friendship.run_callbacks(:update)
    end
  end
end