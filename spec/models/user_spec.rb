# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  username               :string           default(""), not null
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#  index_users_on_username              (username) UNIQUE
#
require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:username) }
    it { should validate_uniqueness_of(:username).case_insensitive }
    it { should validate_length_of(:username).is_at_least(3).is_at_most(50) }
    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email).case_insensitive }
  end

  describe 'post associations' do
    it { should have_many(:posts).dependent(:destroy) }
  end

  describe 'friend associations' do
    it { should have_many(:friendships).dependent(:destroy) }
    it { should have_many(:pending_requests).class_name('Friendship') }

    it { should have_many(:friends).through(:friendships).conditions(status: :accepted).source(:friend) }
    # it { should have_many(:pending_friends).through(:friendships).conditions(status: [:sent, :received]).source(:friend) }
  end

  describe 'comment associations' do
    it { should have_many(:comments).dependent(:destroy) }
  end

  describe 'like associations' do
    it { should have_many(:likes).dependent(:destroy) }
  end
end
