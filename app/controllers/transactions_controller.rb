class TransactionsController < ApplicationController
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
end
