namespace :import do
  desc 'Import data from CSV file'
  task csv: :environment do
    require 'csv'

    csv_file = 'db/seeds/transactional-sample.csv'

    CSV.foreach(csv_file, headers: true) do |row|
      Transaction.create!(
        transaction_id: row['transaction_id'],
        merchant_id: row['merchant_id'],
        user_id: row['user_id'],
        card_number: row['card_number'],
        transaction_date: row['transaction_date'],
        transaction_amount: row['transaction_amount'],
        device_id: row['device_id'],
        has_cbk: row['has_cbk']
      )
    end

    puts 'CSV data imported successfully!'
  end
end
