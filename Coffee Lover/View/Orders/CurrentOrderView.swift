

import SwiftUI
import OrderKit



struct CurrentOrderView: View {
    @Environment(OrderManager.self) private var orderManager
    @State private var viewState: OrderViewState = .noOrderPending

    var body: some View {
        Group {
            switch viewState {
            case .noOrderPending:
                HStack {
                    Image(systemName: "cart.badge.minus")
                        .font(.title2)
                        .foregroundStyle(.secondary)
                    Text("No active order")
                        .font(.headline)
                        .foregroundStyle(.secondary)
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color(uiColor: .systemBackground).opacity(0.8))
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .padding(.horizontal)
                
            case .loading:
                ProgressView("Lade Bestellung...")
                    .controlSize(.large)
                
            case .loaded(let order):
                OrderCardView(order: order)
                
            case .error(let error):
                ContentUnavailableView(
                    "Fehler beim Laden",
                    systemImage: "exclamationmark.triangle",
                    description: Text(error.localizedDescription)
                )
            }
        }
        .task(id: orderManager.pendingOrderId) {
            await loadOrder()
        }
    }
    
    // MARK: - Structured Concurrency
    private func loadOrder() async {
        guard let orderId = orderManager.pendingOrderId else {
            viewState = .noOrderPending
            return
        }

        viewState = .loading
        
        do {
            let fetchedOrder = try await orderManager.getOrder(by: orderId)
            viewState = .loaded(fetchedOrder)
        } catch {
            viewState = .error(error)
        }
    }
    
    
}

public enum OrderViewState {
    case noOrderPending
    case loading
    case loaded(Order)
    case error(Error)
}

struct OrderCardView: View {
    let order: Order
    @State private var isExpanded: Bool = false

    var body: some View {
        VStack(spacing: 0) {
            HStack {
                VStack(alignment: .leading) {
                    Text("Current Order")
                        .font(.headline)
                        .fontWeight(.semibold)
                    Text("Order #\(order.id)")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
                Spacer()

                StatusBadge(orderStatus: OrderStatus.get(by: order.orderStatus))
            }
            .padding(.horizontal, 20)
            .padding(.top, 20)
            .padding(.bottom, 16)
            
            if isExpanded {
                Divider()

                VStack(spacing: 16) {
                    OrderDetailRow(
                        icon: "clock",
                        title: "Ordered on",
                        // Moderne Swift API für Daten statt DateFormatter!
                        value: order.orderDate.formatted(date: .abbreviated, time: .shortened)
                    )

                    OrderDetailRow(
                        icon: "bag",
                        title: "Products",
                        value: "\(order.totalItems) Units"
                    )

                    OrderDetailRow(
                        icon: "dollarsign.circle",
                        title: "Total Price",
                        // Moderne Währungsformatierung
                        value: order.totalPrice.formatted(.currency(code: "USD")),
                        isHighlighted: true
                    )

                    OrderDetailRow(
                        icon: "creditcard",
                        title: "Payment Method",
                        value: order.paymentOption.description
                    )

                    OrderDetailRow(
                        icon: "checkmark.shield",
                        title: "Payment Status",
                        value: order.paymentStatus.description,
                        statusColor: paymentStatusColor(PaymentStatus.get(by: order.paymentStatus))
                    )
                }
                .padding(20)
            }
        }
        .background(Color(uiColor: .systemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .shadow(color: .black.opacity(0.1), radius: 8, x: 0, y: 4)
        .padding(.horizontal, 16)
        .contentShape(Rectangle())
        .onTapGesture {
            withAnimation(.spring(response: 0.4, dampingFraction: 0.7)) {
                isExpanded.toggle()
            }
        }
    }

    private func paymentStatusColor(_ status: PaymentStatus) -> Color {
        switch status {
        case .paid: return .green
        case .pending: return .orange
        case .failed: return .red
        case .unknown: return .gray
        }
    }
}

struct StatusBadge: View {
    let orderStatus: OrderStatus

    var body: some View {
        HStack(spacing: 4) {
            Circle()
                .fill(statusColor)
                .frame(width: 8, height: 8)

            Text(orderStatus.rawValue)
                .font(.caption)
                .fontWeight(.medium)
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 6)
        .background(statusColor.opacity(0.1))
        .clipShape(Capsule())
    }

    private var statusColor: Color {
        switch orderStatus {
        case .ordered: return .orange
        case .inPreparation: return .yellow
        case .inDelivery: return .green
        case .delivered: return .blue
        case .cancelled: return .red
        case .unknown: return .gray
        }
    }
}
