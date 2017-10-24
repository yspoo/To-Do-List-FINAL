class Tasklist < ApplicationRecord
  has_many :tasks, dependent: :destroy
  validates :name, uniqueness: true, presence: true,
                                    length: {minimum: 4}


end
