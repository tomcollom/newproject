class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
end


class Category < ActiveRecord::Base

self.table_name = 'categoriesnew'
  has_many :posts
  belongs_to :upload


  validates :name, :description, :slug, presence: true
  validates :slug, uniqueness: true

  

end