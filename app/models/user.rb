class User < ActiveRecord::Base
  # Remember to create a migration!
  has_many :urls
  
  def self.authenticate(email, password)
    current_user = User.find_by_email(email)
    
    if current_user.email == email && current_user.password == password
      return current_user
    else
      return nil
    end
  end
end


 #In other words, a Url belongs to a User and a User has many Urls.
