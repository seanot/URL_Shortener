class Url < ActiveRecord::Base
  # Remember to create a migration!
  validates :long_url, length: {minimum: 1}
  validates :long_url, format: { with: /https*:\/\/\S+/, message: "Must be a website"}

  

  def self.random_generator
     ('a'..'z').to_a.sample(5).join
  end

end
