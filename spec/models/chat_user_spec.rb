# == Schema Information
#
# Table name: chat_users
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  chat_id    :bigint           not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_chat_users_on_chat_id              (chat_id)
#  index_chat_users_on_chat_id_and_user_id  (chat_id,user_id) UNIQUE
#  index_chat_users_on_user_id              (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (chat_id => chats.id)
#  fk_rails_...  (user_id => users.id)
#
require 'rails_helper'

RSpec.describe ChatUser, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
