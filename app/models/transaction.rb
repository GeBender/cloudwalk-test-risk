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
    return false if critical_issues? ||
                    !device_id.present?

    true
  end

  def critical_issues?
    card_chargeback? ||
      user_chargeback(1, 7.days) ||
      user_chargeback(2, 1.month) ||
      attempts(1, 1.minute) ||
      attempts(5, 1.hour)

    #                request_issues(5, transaction_date - 1.hour) ||
    #                similar_request_issues(1, transaction_date - 15.minutes)
  end

  def card_chargeback?
    Transaction.where(card_number:)
               .where(has_cbk: true)
               .count.positive?
  end

  def user_chargeback(count, date)
    Transaction.where(user_id:)
               .where('transaction_date > ?', transaction_date - date)
               .where(has_cbk: true)
               .count >= count
  end

  def attempts(count, date)
    Transaction.where(user_id:)
               .where('transaction_date > ?', transaction_date - date)
               .count >= count
  end

  # check if card_number has been used more than count in the last date
  def cards_used_issues(count, date)
    # select the total diff cards used in the last date
    return true if Transaction.where(user_id:)
                              .where('transaction_date > ?', date)
                              .distinct.count(:card_number) > count

    false
  end

  def valid_datetime_format
    begin
      DateTime.parse(transaction_date.to_s)
    rescue ArgumentError
      errors.add(:transaction_date, 'must be a valid datetime string')
    end
  end
end
