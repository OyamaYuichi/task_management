class Task < ApplicationRecord
  validates :name, presence: true
  validates :detail, presence: true
  validates :deadline, presence: true
  validates :status, presence: true
  validates :priority, presence: true
  enum status: { not_yet: 0, in_progress: 1, completed: 2 }
  enum priority: { high: 0, middle: 1, low: 2 }

  scope :get_by_name, -> (name) { where('name LIKE ?', "%#{name}%")}
  scope :get_by_status, -> (status) { where(status: status)}
  scope :get_by_label, -> (label) { where(id: Labeling.where(label_id: label).pluck(:task_id))}

  belongs_to :user
  has_many :labelings, dependent: :destroy
  has_many :labels, through: :labelings, source: :label
end
