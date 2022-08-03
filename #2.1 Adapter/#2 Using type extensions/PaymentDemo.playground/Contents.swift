protocol PaymentGateway {
    func receivePayment(amount: Double)
    var totalPayments: Double {get}
}

class PayPal: PaymentGateway {
    private var total = 0.0
    
    func receivePayment(amount: Double) {
        total += amount
    }
    
    var totalPayments: Double {
        print("Total payments received via PayPal: \(total)")
        return total
    }
}

class Stripe: PaymentGateway {
    private var total = 0.0
    
    func receivePayment(amount: Double) {
        total += amount
    }
    
    var totalPayments: Double {
        print("Total payments received via Stripe: \(total)")
        return total
    }
}


let paypal = PayPal()
paypal.receivePayment(amount: 100)
paypal.receivePayment(amount: 200)
paypal.receivePayment(amount: 499)

let stripe = Stripe()
stripe.receivePayment(amount: 5.99)
stripe.receivePayment(amount: 25)
stripe.receivePayment(amount: 9.99)

var paymentGateways: [PaymentGateway] = [paypal, stripe]


// third-party class, that doesn't conform to PaymentGateway
class AmazonPayments {
    var payments = 0.0
    
    func paid(value: Double, currency: String) {
        payments += value
        print("Paid \(currency)\(value) via Amazon Payments")
    }
    
    func fulfilledTransactions() -> Double {
        return payments
    }
}

extension AmazonPayments: PaymentGateway {
    func receivePayment(amount: Double) {
        self.paid(value: amount, currency: "USD")
    }
    
    var totalPayments: Double {
        let total = self.payments
        print("Total payments received via Amazon Payments: \(total)")
        return total
    }
}

let amazonPayments = AmazonPayments()
amazonPayments.receivePayment(amount: 120)
amazonPayments.receivePayment(amount: 74.99)

paymentGateways.append(amazonPayments)

var total = 0.0
for gateway in paymentGateways {
    total += gateway.totalPayments
}

print(total)

