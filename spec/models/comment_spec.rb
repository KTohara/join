# == Schema Information
#
# Table name: comments
#
#  id         :bigint           not null, primary key
#  body       :text             not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  parent_id  :bigint
#  post_id    :bigint           not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_comments_on_parent_id  (parent_id)
#  index_comments_on_post_id    (post_id)
#  index_comments_on_user_id    (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (parent_id => comments.id)
#  fk_rails_...  (post_id => posts.id)
#  fk_rails_...  (user_id => users.id)
#
require 'rails_helper'

RSpec.describe Comment, type: :model do
  describe 'associations' do
    it { should belong_to(:user) }
    it { should belong_to(:post) }
    it { should belong_to(:parent).class_name('Comment').optional(true) }

    it { should have_many(:comments).with_foreign_key(:parent_id).dependent(:destroy) }
  end

  describe 'validations' do
    it { should validate_presence_of(:body) }
    it { should validate_length_of(:body).is_at_most(8_000) }
  end
end
