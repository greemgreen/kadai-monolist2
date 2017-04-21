class User < ApplicationRecord
  before_save { self.email.downcase! }
  validates :name, presence: true, length: { maximum: 50 }
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                    uniqueness: { case_sensitive: false }
  has_secure_password
  
  def want(item)
    self.wants.find_or_create_by(item_id: item.id)
  end

  def unwant(item)
    want = self.wants.find_by(item_id: item.id)
    want.destroy if want
  end

  def want?(item)
    self.want_items.include?(item)
  end
  
  def hold(item)
    self.holds.find_or_create_by(item_id: item.id)
  end

  def unhold(item)
    hold = self.holds.find_by(item_id: item.id)
    hold.destroy if hold
  end

  def hold?(item)
    self.hold_items.include?(item)
  end
    
  has_many :ownerships
  has_many :items, through: :ownerships
  has_many :wants
  has_many :want_items, through: :wants, class_name: 'Item', source: :item
  has_many :holds
  has_many :hold_items, through: :holds, class_name: 'Item', source: :item
end
