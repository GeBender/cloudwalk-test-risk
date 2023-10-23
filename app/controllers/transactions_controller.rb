class TransactionsController < ApplicationController
  TOKEN = ENV['TOKEN']

  before_action :authenticate

  # method to create a new transaction
  def validate
    # create a new transaction from the raw post data
    transaction_data = JSON.parse(request.raw_post)
    transaction = Transaction.new(transaction_data)

    if !transaction.valid?
      # return errros in case of invalid transaction
      render json: { errors: transaction.errors.full_messages }, status: :unprocessable_entity
    elsif transaction.safe?
      # if the transaction is valid and safe, approve the transaction
      render json: approve_transaction(transaction)
    else
      # otherwise, deny the transaction
      render json: deny_transaction(transaction)
    end
  end

  def set_chargeback
    # find a transaction by the transaction_id or return a 404
    transaction_data = JSON.parse(request.raw_post)
    transaction = Transaction.find_by(transaction_id: transaction_data['transaction_id'])
    return render json: { error: 'Transaction not found' }, status: :not_found unless transaction

    # set the transaction as chargeback
    transaction.has_cbk = true

    # save the transaction
    transaction.save

    # return the transaction data
    render json: {
      transaction_id: transaction.transaction_id,
      has_cbk: true
    }
  end

  def create
    # create a new transaction from the raw post data
    transaction_data = JSON.parse(request.raw_post)
    transaction = Transaction.new(transaction_data)

    if !transaction.valid?
      # return errros in case of invalid transaction
      render json: { errors: transaction.errors.full_messages }, status: :unprocessable_entity
    elsif transaction.safe?
      # save the transaction
      transaction.save
      render json: {
        "transaction_id": transaction.transaction_id,
        "approved": true,
        "created": true
      }
    else
      render json: {
        "transaction_id": transaction.transaction_id,
        "denied": true,
        "created": false
      }
    end
  end

  private

  def approve_transaction(transaction)
    {
      transaction_id: transaction.transaction_id,
      recommendation: 'approve'
    }
  end

  def deny_transaction(transaction)
    {
      transaction_id: transaction.transaction_id,
      recommendation: 'deny'
    }
  end

  def authenticate
    authenticate_or_request_with_http_token do |token, options|
      ActiveSupport::SecurityUtils.secure_compare(token, TOKEN)
    end
  end
end
