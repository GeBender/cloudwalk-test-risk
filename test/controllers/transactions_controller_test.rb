require "test_helper"

class TransactionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @transaction = transactions(:one)
  end

  test "should approve a valid and safe transaction" do
    valid_transaction_data = {
      "transaction_id": 2342357,
      "merchant_id": 29744,
      "user_id": 97051,
      "card_number": "434505******9116",
      "transaction_date": "2019-11-31T23:16:32.812632",
      "transaction_amount": 373,
      "device_id": 285475
    }

    post transactions_url, params: valid_transaction_data, as: :json
    assert_response :success

    response_data = JSON.parse(response.body)
    assert_equal 'approve', response_data['recommendation']
  end

  test 'should show erros when transaction is invalid' do
    invalid_transaction_data = {
      "transaction_id": 'string',
      "transaction_date": '2019-11-31T23:16:32.812632'
    }

    post transactions_url, params: invalid_transaction_data, as: :json
    assert_response :unprocessable_entity
  end

  # test 'should deny an invalid or unsafe transaction' do
  #   invalid_transaction_data = {
  #     "transaction_id": 2_342_357,
  #     "merchant_id": 29_744,
  #     "user_id": 97_051,
  #     "card_number": '434505******9116',
  #     "transaction_date": '2019-11-31T23:16:32.812632',
  #     "transaction_amount": 373,
  #     "device_id": 285_475
  #   }

  #   post transactions_url, params: invalid_transaction_data, as: :json
  #   assert_response :success

  #   response_data = JSON.parse(response.body)
  #   assert_equal 'deny', response_data['recommendation']
  # end
end
