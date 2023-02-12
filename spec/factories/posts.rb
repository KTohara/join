# == Schema Information
#
# Table name: posts
#
#  id            :bigint           not null, primary key
#  body          :text             not null
#  comment_count :integer          default(0)
#  gif_url       :string
#  like_count    :integer          default(0)
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  author_id     :bigint
#  user_id       :bigint           not null
#
# Indexes
#
#  index_posts_on_author_id  (author_id)
#  index_posts_on_user_id    (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (author_id => users.id)
#  fk_rails_...  (user_id => users.id)
#
FactoryBot.define do
  factory :post do
    body { Faker::Quote.yoda }
    user { create(:user) }
    author { create(:user) }
  end
end
