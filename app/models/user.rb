class User < ApplicationRecord
    before_save :email_downcase
    validates :name, presence: true, length: { maximum: 255}
    validates :email, presence: true, length: { maximum: 255},
                        format: { with: Constants::VALID_EMAIL_REGEX  },
                        uniqueness: { case_sensitive: false }
    validates :password, confirmation: true, presence: true,on: :create
    validates :phone, numericality: true, length: { minimum: 9, maximum: 12 }, allow_blank: true
    validates :address, length: {maximum: 255}, allow_blank: true
    validates_inclusion_of :super_user_flag, :in => [true, false]
    validates :birthday, format: { with: Constants::VALID_DATE_FORMAT }, allow_blank: true

    has_secure_password

    private
 
    def email_downcase
        self.email = email.downcase
    end

end
