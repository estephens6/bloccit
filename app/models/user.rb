class User < ActiveRecord::Base
    
    before_save { self.email = email.downcase if email.present? }
    before_save { self.name = format_name(self.name) if !self.name.nil? }
 # #3
#   validates :name, length: { minimum: 1, maximum: 100 }, presence: true
  NAME_REGEX = /\A([A-Z]{1})([a-z]*)\s{1}([A-Z]{1})([a-z]*)\z/

  validates :name,
            length: { minimum: 1, maximum: 100 },
            presence: true,
            format: { with: NAME_REGEX }


 # #4
  validates :password, presence: true, length: { minimum: 6 }, unless: :password_digest
  validates :password, length: { minimum: 6 }, allow_blank: true
 # #5
   validates :email,
             presence: true,
             uniqueness: { case_sensitive: false },
             length: { minimum: 3, maximum: 254 }

 # #6
   has_secure_password

  def format_name(name)
    name_array = name.split(' ')
    formatted_name_array = []
    name_array.each do |part_of_name|
      formatted_name_array << part_of_name.capitalize
    end
    name = formatted_name_array.join(' ')
  end
end