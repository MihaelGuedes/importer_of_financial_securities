class Title < ApplicationRecord
  has_one :title_criticism, dependent: :destroy

  validates :title_number, :value, :due_date, :cnpj_assignor, :cnpj_drawee, presence: true
  validates :title_number, format: { with: /\A[A-Za-z0-9\/\.\s]+\z/, message: 'allows only numbers and/or letters.'}
  validates :title_number, uniqueness: { scope: :cnpj_assignor, message: 'must be unique for each assigner.' }

  validates :value, comparison: { greater_than: 0.0, message: 'must be greater than 0.0' }

  validate :validate_date_greater_than_today
  validates :due_date, format: { with: /\d{4}-\d{2}-\d{2}/, message: 'invalid format, try YYYY-MM-DD.' }

  validates :cnpj_assignor, format: { with: /\A\d{2}\.\d{3}.\d{3}\/\d{4}-\d{2}\Z/, message: 'incorrect formatting, try: 00.000.000/0000-00' }
  validates :cnpj_drawee, format: { with: /\A\d{2}\.\d{3}.\d{3}\/\d{4}-\d{2}\Z/, message: 'incorrect formatting, try: 00.000.000/0000-00' }
  
  after_save :external_validations_async

  def validate_date_greater_than_today
    if due_date.present? && due_date.to_date <= Date.today
      errors.add(:due_date, "must be greater than today.")
    end
  end

  def external_validations_async
    TitleJob.perform_later(self)
  end
end
