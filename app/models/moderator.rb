class Moderator < ApplicationRecord
    validates :name, presence: true, length: { maximum: 50 }
    validates :accessCode, presence: true, length: { is: 6 }
    belongs_to :room, foreign_key: "accessCode"
    validates_uniqueness_of :name, :scope => :accessCode

    attr_accessor :virtual_password #virtual attribute that is not saved to the DB
end
