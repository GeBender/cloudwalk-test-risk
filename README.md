# Software Engineer - Risk test to CloudWalk

A versioned project designed to serve as an evaluation basis for **CloudWalk** in the selection process for the **Software Engineer** position to work with **Ruby on Rails**.
  
Below are the essay answers proposed in the test:

## Understand the Industry

 1. **Explain the money flow and the information flow in the acquirer market and the role of the main players:**

    \
    The ultimate goal of the money flow is simple: to move from the **customer's** account to the **merchant's** account. Although simple, this process requires that **information** and **money** flow through a secure and defined path, depending on various **players** with their defined roles. Here's how it works:
    \
    First, the **customer** swipes their card at a point of sale terminal in the merchant's establishment. The merchant is the one contracting services from the acquiring bank.
    \
    The **acquiring bank** then performs the necessary verifications to ensure the transaction's security and authenticity on the customer's side. This process is known as Anti-fraud, and it authorizes or denies the transaction. If authorized based on its security criteria, the acquiring bank sends the transaction through communication with the card network that issued the customer's card, such as Visa or Mastercard. If denied, it informs the point of sale that the transaction was not authorized.
    \
    The **card network**, upon receiving the execution command for the transaction, securely communicates it to the issuing bank, following its own rules and standards for processing the request.
    \
    The **issuing bank**, which is the one that issued the customer's card used in the transaction, verifies the card details, checks if the customer has sufficient funds for the transaction, and, if positive, reserves the amount for later payment to the acquiring bank.
    \
    Once the transaction is authorized, the acquiring bank sends a new communication to the card network, which proceeds to transfer the funds from the issuing bank to the acquiring bank, which finally transfers the funds to the merchant's account, thus completing the flow.

    ##### Summarizing the information flow (in a successful case)
    1. Card, customer, and sales data are received by the point of sale.
    2. The point of sale device sends the information to the acquiring bank.
    3. The acquiring bank validates the transaction's security and sends the information to the card network used.
    4. The card network forwards the information to the issuing bank.
    5. The issuing bank verifies the information and responds to the card network.
    6. The card network receives the response, performs the operation, and responds to the acquiring bank.
    7. The acquiring bank performs its part of the operation and responds to the merchant through the point of sale.
    
    ##### Summarizing the money flow (in a successful case)
    1. After verifying card information, customer details, and available balance, the issuing bank reserves the requested amount in the customer's account.
    2. The card network transfers the funds from the issuing bank to the acquiring bank.
    3. The acquiring bank transfers the funds to the merchant's account.

    ##### Summarizing the roles of the main players
    - **Customer**: The end consumer, cardholder, who uses the card as a form of payment, with the role of consuming :)
    - **Merchant**: A customer of the acquiring bank and the holder of the point of sale provided by the acquiring bank for their transactions. It is their responsibility to carry out transactions and receive payments.
    - **Acquiring Bank**: An intermediary responsible for secure communication between the merchant and the card network through the point of sale, for risk analysis and anti-fraud procedures, and for receiving funds from the card network and passing them to the merchant.
    - **Card Network**: Responsible for card brands, communication of transactions to the issuing bank, and the execution of transactions between the issuing bank and the acquiring bank when approved.
    - **Issuer Bank**: The bank that issued the card, holding the customer's account. It is responsible for verifying card details, the customer's balance, reserving the transaction amount in the customer's account, and communicating with the card network.

    ##

 2. **Explain the difference between acquirer, sub-acquirer and payment gateway and how the flow explained in question 1 changes for these players:**

    The definition of an **acquirer** follows as given in the answer above. The **sub-acquirer** is an additional player in the payment flow, acting between the merchant and the acquirer, providing additional services aimed at facilitating the acquisition of payment services for specific market niches, such as smaller clients, for example.
    \
    A **payment gateway**, on the other hand, is also a player that can exist in the flow, positioned between the merchant and the acquirer or sub-acquirer. It optimizes and ensures greater security in the communication process between these parts of the process, providing functions such as data encryption and decryption, ensuring that data is transmitted securely and correctly formatted. It serves as a communication bridge in the established flow.
    \
    Basically, with the entry of these players, the flow looks like this: Customer > Merchant > Payment Gateway > Sub-acquirer > Acquirer > Card Network > Issuing Bank.
    
    ##


3. **Explain what chargebacks are, how they differ from cancellations and what is their connection with fraud in the acquiring world.**

    A **chargeback** is a procedure usually initiated by the cardholder when they want to dispute a purchase. It may be due to reasons such as an unrecognized purchase, non-delivery of a purchase, or a purchase that was delivered in a damaged or incomplete condition. It is a mechanism designed to protect the cardholder from any problems they may have experienced during a transaction. Chargebacks are received by the issuing bank, validated, and, if deemed valid, the amount is refunded to the cardholder.
    \
    **Cancellations**, on the other hand, generally occur before the final settlement of the operation, that is, before the movement of funds. It is, therefore, a simpler and less bureaucratic procedure that can occur for various reasons during one of the stages of the previously presented flow, such as a lack of funds, communication delays, or errors, and so on.
    \
    These factors are directly related to **fraud**, fraud attempts, and anti-fraud policies that need to exist throughout the acquiring market, highlighting the following points:
    1. Chargebacks are undesirable occurrences, mainly for merchants, as they may carry the burden in case a chargeback is confirmed. To avoid this, all possible precautions must be taken to prevent fraudulent transactions from being executed.
    2. In cases where a legitimate purchase is disputed, the cardholder may act in bad faith, resulting in an unjust refund. Chargeback dispute procedures, i.e., proving the absence of fraud, are necessary in this ecosystem to ensure the reliability of the entire payment system.
    3. Anti-fraud systems, therefore, prove extremely important for all players in the payment market, as they will ensure the security and reliability of the entire market.

## Get your hands dirty

Using this [**csv**](https://gist.github.com/cloudwalk-tests/76993838e65d7e0f988f40f1b1909c97#file-transactional-sample-csv) with hypothetical transactional data, imagine that you are trying to understand if there is any kind of suspicious behavior.

1. **Analyze the data provided and present your conclusions (consider that all transactions are made using a mobile device):**

    Considering the following possible risk factors among those available:
    1. The number of different cards used by the same user.
    2. The number of different devices used by the same user.
    The number of previous chargebacks by the user.

    It is concluded that out of the **3,199** transactions presented, 97 transactions from only 5 users are extremely suspicious because they use a disproportionately high number of different cards and an equally disproportionate number of previous chargebacks. These users are: **11750, 91637, 79054, 96025, and 78262**.
    \
    Continuing the analysis, forming a kind of score, approximately 47 users exhibit less aggressive but still suspicious activity, as they use more than one card and have some previous chargebacks.
    \
    Beyond this, there are also a total of 830 transactions without an identified device, which can be a warning sign regarding the transaction's reliability.
    ##

2. **In addition to the spreadsheet data, what other data would you look at to try to find patterns of possible frauds?**

    Additional factors to consider for fraud detection include:
    1. Geolocation data, such as the delivery address for non-face-to-face purchases in public, suspicious, or high-risk areas.
    2. Comparing area codes (DDDs) with delivery postal codes, where different area codes from the delivery postal code may be considered suspicious.
    3. Lack of customer information, such as phone numbers or email addresses.
    4. Comparing the device's IP address with the area code, destination postal code, residence, or customer's location history.
    5. The number of attempts indicating brute force validation.
    6. Sudden changes in buying behavior, such as location, purchase amounts, online purchases, and purchase intervals.
    7. Checking other financial data sources to verify card cancellation histories, defaults, and more.
    ##
    Among other factors...


## Solution App

Instructions for installing and running the application designed to solve the problem presented in the challenge statement, as per section 3.3 of the **[Software Engineer - risk test](https://gist.github.com/cloudwalk-tests/76993838e65d7e0f988f40f1b1909c97#33---solve-the-problem)**

## README

1. Clone this repo
2. Config your database the way you wants (You can try the standard Sqlite3, it's slow but works to our goals)
3. Import the Transaction seeds: ```rails import:csv```
4. Start the server: ```rails s```

---

