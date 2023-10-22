class Transaction < ApplicationRecord

  validates :transaction_id, presence: true
  validates :transaction_id, numericality: { only_integer: true }

  validates :merchant_id, presence: true
  validates :merchant_id, numericality: { only_integer: true }

  validates :user_id, presence: true
  validates :user_id, numericality: { only_integer: true }

  validates :card_number, presence: true
  validates :card_number, format: { with: /\A[\d*]{16}\z/, message: 'must be 16 characters of numbers or * character' }
  validates :card_number, length: { is: 16, message: 'must be exactly 16 characters' }

  validates :transaction_date, presence: true
  validate :valid_datetime_format

  validates :transaction_amount, presence: true
  validates :transaction_amount, numericality: { greater_than: 0, message: 'must be a positive number' }

  validates :device_id, numericality: { only_integer: true, allow_blank: true }

  def safe?
    true
  end

  def valid_datetime_format
    begin
      DateTime.parse(transaction_date.to_s)
    rescue ArgumentError
      errors.add(:transaction_date, 'must be a valid datetime string')
    end
  end
end
