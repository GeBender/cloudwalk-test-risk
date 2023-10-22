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
    return true if chargeback_issues(1, transaction_date - 1.year) ||
                   chargeback_issues(2, transaction_date - 2.year) ||
                   chargeback_issues(3, transaction_date - 20.year) ||
                   cards_used_issues(1, transaction_date - 1.month) ||
                   cards_used_issues(3, transaction_date - 1.year) ||
                   request_issues(5, transaction_date - 1.hour) ||
                   similar_request_issues(1, transaction_date - 15.minutes)

    false
  end

  def request_issues(count, date)
    return true if Transaction.where(user_id:)
                              .where('transaction_date > ?', date)
                              .count >= count

    false
  end

  def similar_request_issues(count, date)
    return true if Transaction.where(user_id:)
                              .where(merchant_id:)
                              .where(transaction_amount:)
                              .count >= count

    false
  end

  # check if user or card_number has more chargebacks than count in the last date
  def chargeback_issues(count, date)
    return true if Transaction.where(card_number:)
                              .where('transaction_date > ?', date)
                              .where(has_cbk: true)
                              .count >= count ||
                   Transaction.where(user_id:)
                              .where('transaction_date > ?', date)
                              .where(has_cbk: true)
                              .count >= count

    false
  end

  # check if card_number has been used more than count in the last date
  def cards_used_issues(count, date)
    # select the total diff cards used in the last date
    return true if Transaction.where(user_id:)
                              .where('transaction_date > ?', date)
                              .distinct.count(:card_number) >= count

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
