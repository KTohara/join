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
FactoryBot.define do
  factory :friendship do
    status { 1 }
    friend { create(:user) }
    user { create(:user) }
  end
end
