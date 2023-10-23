require 'test_helper'

class TransactionTest < ActiveSupport::TestCase
  def setup
    @transaction = transactions(:one)
  end

  test 'transaction_id is a number mandatory' do
    @transaction.transaction_id = nil
    assert_not @transaction.valid?

    @transaction.transaction_id = 'string'
    assert_not @transaction.valid?

    @transaction.transaction_id = 1
    assert @transaction.valid?
  end

  test 'merchant_id is a number mandatory' do
    @transaction.merchant_id = nil
    assert_not @transaction.valid?

    @transaction.merchant_id = 'string'
    assert_not @transaction.valid?

    @transaction.merchant_id = 1
    assert @transaction.valid?
  end

  test 'user_id is a number mandatory' do
    @transaction.user_id = nil
    assert_not @transaction.valid?

    @transaction.user_id = 'string'
    assert_not @transaction.valid?

    @transaction.user_id = 1
    assert @transaction.valid?
  end

  test 'card_number is a 16 chars string and mandatory' do
    @transaction.card_number = nil
    assert_not @transaction.valid?

    @transaction.card_number = 'abc'
    assert_not @transaction.valid?

    @transaction.card_number = '434505******9116'
    assert @transaction.valid?
  end

  test 'transaction_date is a string with a datetime valid and is mandatory' do
    @transaction.transaction_date = nil
    assert_not @transaction.valid?

    @transaction.transaction_date = '2013-59-10'
    assert_not @transaction.valid?

    @transaction.transaction_date = '2019-11-31T23:16:32.812632'
    assert @transaction.valid?
  end

  test 'transaction_amount is a float with and is mandatory' do
    @transaction.transaction_amount = nil
    assert_not @transaction.valid?

    @transaction.transaction_amount = -10
    assert_not @transaction.valid?

    @transaction.transaction_amount = '-10'
    assert_not @transaction.valid?

    @transaction.transaction_amount = 10.5
    assert @transaction.valid?
  end

  test 'device is a integer with and is not mandatory' do
    @transaction.device_id = 'abc'
    assert_not @transaction.valid?

    @transaction.device_id = 105
    assert @transaction.valid?
  end

  test 'transaction whitout device is not safe' do
    @transaction.device_id = nil
    assert_not @transaction.safe?
  end

  test 'transaction with card chargeback is not safe' do
    assert @transaction.card_chargeback?
  end

  test 'transaction with no card chargeback is safe' do
    @transaction.card_number = '434505******9117'
    assert_not @transaction.card_chargeback?
  end

  test 'transaction with more or equal user chargebacks than given in period is not safe' do
    assert @transaction.user_chargeback(1, 1.month)
  end

  test 'transaction with less user chargebacks than given in period is not safe' do
    assert_not @transaction.user_chargeback(2, 1.month)
  end

  test 'transaction with more or equal attempts than given in period is not safe' do
    assert @transaction.attempts(1, 30.seconds)
  end

  test 'transaction with less attempts than given in period is safe' do
    @transaction.transaction_date = '2019-12-31T23:16:32.812632'
    assert_not @transaction.attempts(1, 30.minutes)
  end
end
