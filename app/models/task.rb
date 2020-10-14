class Task < ApplicationRecord
  validates :name, presence: true
  validates :detail, presence: true
  validates :deadline,presence: true
  enum status: { not_yet: 0, in_progress: 1, completed: 2 }
  scope :get_by_name, -> (name) { where('name LIKE ?', "%#{name}%")}
  scope :get_by_status, -> (status) { where(status: status)}
end
