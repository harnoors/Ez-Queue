class Room < ApplicationRecord
    validates :accessCode, presence: true, length: { is: 6 }, uniqueness: true
    validates :password, presence: true

    #when room is deleted that is associated with certain guests and moderators, they will be deleted too
    has_many :guest, dependent: :destroy 
    has_many :moderator, dependent: :destroy

    self.primary_key = "accessCode"
end
