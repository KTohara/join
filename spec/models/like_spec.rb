# == Schema Information
#
# Table name: likes
#
#  id            :bigint           not null, primary key
#  likeable_type :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  likeable_id   :bigint
#  user_id       :bigint           not null
#
# Indexes
#
#  index_likes_on_likeable                                   (likeable_type,likeable_id)
#  index_likes_on_user_id                                    (user_id)
#  index_likes_on_user_id_and_likeable_type_and_likeable_id  (user_id,likeable_type,likeable_id) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
require 'rails_helper'

RSpec.describe Like, type: :model do
  let!(:like) { create(:like, :post_like) }

  describe 'validations' do
    it { should validate_presence_of(:user) }
    it { should validate_uniqueness_of(:user).scoped_to([:likeable_id, :likeable_type]) }
  end

  describe 'associations' do
    it { should belong_to(:user) }
    it { should belong_to(:likeable) }
  end
end
