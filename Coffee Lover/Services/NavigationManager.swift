
import Foundation
import SwiftUI
import Coffee_Kit
public enum NavigationTarget: Hashable {
    case login
    case register
    case content
    case productDetail(Product)
    case orderHistory
    case currentOrder(Order)
}

@Observable
public final class NavigationManager {
    public var menuPath = NavigationPath()
    public var ordersPath = NavigationPath()
    public var cartPath = NavigationPath()
    public var searchPath = NavigationPath()
    public var authentication = NavigationPath()

    private init() {}

    public static let shared = NavigationManager()

    public func navigate(to target: NavigationTarget, in pathType: PathType = .menu) {
        switch pathType {
        case .menu: menuPath.append(target)
        case .orders: ordersPath.append(target)
        case .cart: cartPath.append(target)
        case .search: searchPath.append(target)
        case .auth: authentication.append(target)
        }
    }

    public func popToRoot(in pathType: PathType) {
        switch pathType {
        case .menu: menuPath.removeLast(menuPath.count)
        case .orders: ordersPath.removeLast(ordersPath.count)
        case .cart: cartPath.removeLast(cartPath.count)
        case .search: searchPath.removeLast(searchPath.count)
        case .auth: authentication.removeLast(authentication.count)
        }
    }

    @ViewBuilder
    public func destinationView(for target: NavigationTarget) -> some View {
        switch target {
        case .login:
            LoginView()
        case .register:
            RegistrationView()
        case .content:
            ContentView()
        case .productDetail(let product):
            ProductDetailView(product: product)
        case .orderHistory:
            OrderHistoryView()
        case .currentOrder(let order):
            CurrentOrderView(order: order)
        }
    }
    
    public enum PathType {
        case menu, orders, cart, search, auth
    }
}
