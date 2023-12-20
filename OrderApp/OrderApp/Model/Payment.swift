import Foundation

struct CheckoutSession: Codable {
    let data: CheckoutSessionData
}

struct CheckoutSessionData: Codable {
    let id: String
    let type: String
    let attributes: CheckoutSessionAttributes
}

struct CheckoutSessionAttributes: Codable {
    let checkoutUrl: URL
    
    private enum CodingKeys: String, CodingKey {
            case checkoutUrl = "checkout_url"
        }
}

struct Billing: Codable {
    let address: Address
    let email: String
    let name: String
    let phone: String?
}

struct Address: Codable {
    let city: String
    let country: String
    let line1: String
    let line2: String
    let postalCode: String
    let state: String
}

struct LineItem: Codable {
    let amount: Int
    let currency: String
    let description: String
    let images: [String] // Fix: Use an array of images
    let name: String
    let quantity: Int
}

struct Payment: Codable {
    let id: String
    let type: String
    let attributes: PaymentAttributes
}

struct PaymentAttributes: Codable {
    // Add properties according to your needs
}

struct PaymentIntent: Codable {
    let id: String
    let type: String
    let attributes: PaymentIntentAttributes
}

struct PaymentIntentAttributes: Codable {
    // Add properties according to your needs
}

struct SessionMetadata: Codable {
    let notes: String
    let customerNumber: String
    let remarks: String
}
