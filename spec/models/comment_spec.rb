# == Schema Information
#
# Table name: comments
#
#  id               :bigint           not null, primary key
#  body             :text             not null
#  commentable_type :string
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  commentable_id   :bigint
#  parent_id        :bigint
#  user_id          :bigint           not null
#
# Indexes
#
#  index_comments_on_commentable_type_and_commentable_id  (commentable_type,commentable_id)
#  index_comments_on_parent_id                            (parent_id)
#  index_comments_on_user_id                              (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
require 'rails_helper'

RSpec.describe Comment, type: :model do
  describe 'associations' do
    it { should belong_to(:user) }
    it { should belong_to(:commentable) }
    it { should belong_to(:parent).optional(true).class_name('Comment') }

    let!(:user_one) { create(:user) }
    let!(:user_two) { create(:user) }
    let!(:post) { user_one.posts.create(body: 'a post!') }
    let!(:comment) { post.comments.create(body: 'a comment!', user: user_two) }
    let!(:comment_reply) { comment.comments.create(body: 'a reply to the comment!', user: user_one) }

    it 'is expected to have many comments' do
      expect(comment.comments).to include(comment_reply)
    end
  end

  describe 'validations' do
    it { should validate_presence_of(:body) }
    it { should validate_length_of(:body).is_at_most(8_000) }
  end
end
