
import AuthenticationKit
import ProductKit
import OrderKit
import OSLog
import SwiftUI

@MainActor
struct OrderButtonView: View {
    let feedbackGenerator = UINotificationFeedbackGenerator()
    let logger = Logger(subsystem: "codebyCR.coffee.lover", category: "OrderButtonView")

    @Environment(OrderBuilder.self) var orderBuilder
    @Environment(OrderManager.self) var orderManager
    @State private var activePopover: Bool = false
    @State private var orderResultMessage = ""


    var body: some View {
        Button {
            takeOrder()
        } label: {
            OrderButtonLabel()
        }
        .disabled(orderBuilder.products.isEmpty)
        .alert("Order Confirmed 🎉", isPresented: $activePopover) {
            Button("OK") {
                activePopover.toggle()
            }
        } message: {
            Text(orderResultMessage)
        }
    }

    fileprivate func takeOrder() {
        feedbackGenerator.prepare()
        let result = orderManager.takeOrder(from: orderBuilder)


        switch result {
        case .success(let message):
            logger.info("Order successfully taken.")
            feedbackGenerator.notificationOccurred(.success)
            orderResultMessage = message
            activePopover.toggle()

        case .failure(let error):
            logger.error("Failed to take order: \(error.localizedDescription)")
            feedbackGenerator.notificationOccurred(.error)
            orderResultMessage = "Something went wrong, please try again."
        }

    }
}

#Preview("OrderButtonView (Darkmode)") {
    let keychain = DefaultKeychainManager()
    let databaseAPI: DatabaseAPI = .dev
    let baseURL = databaseAPI.baseURL.appendingPathComponent("authentication")
    let authenticationManager = AutenticationManager(keychain: keychain, databaseAPI: databaseAPI)
    let webserviceProvider = WebserviceProvider(inMode: databaseAPI, autheticationManager: authenticationManager)
    
    OrderButtonView()
        .environment(MenuManager(from: webserviceProvider))
        .environment(OrderManager(from: webserviceProvider))
        .preferredColorScheme(.dark)
}

@MainActor
struct OrderButtonLabel: View {
    @Environment(OrderBuilder.self) var orderBuilder

    var body: some View {
        RoundedRectangle(cornerRadius: 16)
            .fill(Color.green)
            .frame(height: 50)
            .opacity(0.8)
            .overlay(
                Text(String(format: "Order (%@)", CurrencyFormatter.formatAmount(orderBuilder.totalAmount)))
                    .foregroundColor(.white)
                    .font(.headline)
            )
            .padding([.bottom, .horizontal], 8)
    }
}
