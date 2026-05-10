
import AuthenticationKit
import ProductKit
import OrderKit
import SwiftUI

@MainActor
struct ProductQuantityView: View {
    let feedbackGenerator = UIImpactFeedbackGenerator(style: .medium)
    @Environment(MenuManager.self) var menuManager
    @Environment(OrderBuilder.self) var orderBuilder
    @StateObject var orderProduct: OrderProduct

    var body: some View {
        HStack {
            Stepper("\(orderProduct.quantity) x \(orderProduct.product.name)") {
                orderProduct.quantity += 1
                feedbackGenerator.impactOccurred()
                orderBuilder.updateQuantity(of: orderProduct)
            } onDecrement: {
                orderProduct.quantity -= 1
                feedbackGenerator.impactOccurred()
                orderBuilder.updateQuantity(of: orderProduct)
            }
            .fontWeight(.semibold)
            .italic()

            Spacer()

            Text(CurrencyFormatter.formatAmount(orderProduct.price))
                .italic()

        }.frame(
            height: 60
        )
        .padding(.leading, 8)
    }
}

#Preview {
    let keychain = DefaultKeychainManager()
    let databaseAPI: DatabaseAPI = .dev
    let baseURL = databaseAPI.baseURL.appendingPathComponent("authentication")
    let authenticationManager = AutenticationManager(keychain: keychain, databaseAPI: databaseAPI)
    let webserviceProvider = WebserviceProvider(inMode: databaseAPI, autheticationManager: authenticationManager)
    
    ProductQuantityView(orderProduct: OrderProduct())
        .environment(MenuManager(from: webserviceProvider))
        .environment(OrderBuilder(for: UUID()))
}
