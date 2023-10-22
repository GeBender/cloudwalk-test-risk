class TransactionsIntegrationTest < ActionDispatch::IntegrationTest
  test 'POST /transactions with valid data' do
    transaction_data = {
      "transaction_id": 2342357,
      "merchant_id": 29744,
      "user_id": 97051,
      "card_number": "434505******9116",
      "transaction_date": "2019-11-31T23:16:32.812632",
      "transaction_amount": 373,
      "device_id": 285475
    }

    post '/transactions', params: transaction_data.to_json, headers: { 'Content-Type' => 'application/json' }

    assert_response :success
    response_json = JSON.parse(response.body)

    assert_equal 2342357, response_json['transaction_id']
    assert_equal 'approve', response_json['recommendation']
  end

  test 'POST /transactions with invalid data' do
    transaction_data = {
      "transaction_id": "",
      "merchant_id": 29744,
      "user_id": 97051,
      "card_number": "434505******9116",
      "transaction_date": "2019-11-31T23:16:32.812632",
      "transaction_amount": 373,
      "device_id": 285475
    }

    post '/transactions', params: transaction_data.to_json, headers: { 'Content-Type' => 'application/json' }

    assert_response :unprocessable_entity
  end
end