# == Schema Information
#
# Table name: profiles
#
#  id         :bigint           not null, primary key
#  bio        :string
#  first_name :string
#  last_name  :string
#  location   :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_profiles_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class Profile < ApplicationRecord
  belongs_to :user

  has_one_attached :avatar, dependent: :destroy do |attachable|
    attachable.variant :thumb, resize_to_limit: [50, 50]
    attachable.variant :display, resize_to_limit: [168, 168]
  end

  validates :first_name, :last_name, length: { maximum: 15 }
  validates :location, length: { maximum: 30 }
  validates :bio, length: { maximum: 500 }

  validates :avatar, content_type: { in: %w[image/png image/jpg image/jpeg], message: 'image must be a valid format' },
                     size: { less_than: 5.megabytes, message: 'image must be less than 5MB' }
end
