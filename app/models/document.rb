class Document < ApplicationRecord
  belongs_to :document_type
  belongs_to :statu
  belongs_to :user
  has_one_attached :file

  validates :user_id, :document_type_id, presence: true
  # numero de documento ?
  # que sucede con la fecha de expiracion del documento ?
  validates :user_id, uniqueness: { scope: %i[statu_id document_type_id active approved] }

  before_create :default_values
  def default_values
    self.approved = false
    self.active ||= false
    # cual sera el estado inicial ?
  end
end
