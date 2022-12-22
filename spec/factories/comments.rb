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
#  user_id          :bigint           not null
#
# Indexes
#
#  index_comments_on_commentable_id  (commentable_id)
#  index_comments_on_user_id         (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (commentable_id => comments.id)
#  fk_rails_...  (user_id => users.id)
#
FactoryBot.define do
  factory :comment do
    body { "MyText" }
    user { nil }
    post { nil }
    parent { nil }
  end
end
