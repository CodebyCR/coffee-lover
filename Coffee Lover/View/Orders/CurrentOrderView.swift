
import Coffee_Kit
import SwiftUI


struct CurrentOrderView: View {
    @State private var isExpanded: Bool = false
    @State public var order: Order
    @State var totalPrice: Double = 10.0
    @State var totalItems = 3
    @State private var orderStatus: OrderStatus = .ordered
    @State private var paymentStatus: PaymentStatus = .pending
    @State private var id: String = {
        let s = UUID().uuidString;
        let end = String.Index(utf16Offset: min(18, s.utf16.count), in: s);
        return String(s[..<end])
    }()

    var body: some View {
        
        VStack(spacing: 0) {
            HStack {
                VStack(alignment: .leading) {
                    Text("Current Order")
                        .font(.headline)
                        .fontWeight(.semibold)
                    Text("Order #\(order.id)")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
                Spacer()

                StatusBadge(orderStatus: OrderStatus.get(by: order.orderStatus) )
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
                        value: formatDateTime(order.orderDate)
                    )

                    OrderDetailRow(
                        icon: "bag",
                        title: "Products",
                        value: "\(totalItems) Units"
                    )

                    OrderDetailRow(
                        icon: "dollarsign.circle",
                        title: "Total Price",
                        value: totalPrice.formatted(.currency(code: "USD")),
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
                        statusColor: paymentStatusColor(paymentStatus)
                    )
                }
                .padding(.horizontal, 20)
                .padding(.vertical, 20)
            }
        }
        .background(Color(.systemBackground))
        .cornerRadius(16)
        .shadow(color: Color.black.opacity(0.1), radius: 8, x: 0, y: 4)
        .padding(.horizontal, 16)
        .contentShape(Rectangle())
        .onTapGesture {
            withAnimation(.spring(response: 0.4, dampingFraction: 0.7)) {
                isExpanded.toggle()
            }
        }
    }

    private func formatDateTime(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }

    private func paymentStatusColor(_ status: PaymentStatus) -> Color {
        switch status {
        case .paid:
            return .green
        case .pending:
            return .orange
        case .failed:
            return .red
        case .unknown:
            return .gray
        }
    }
}



struct StatusBadge: View {
    @State var orderStatus: OrderStatus

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
        .cornerRadius(12)
    }

    private var statusColor: Color {
        switch orderStatus {
        case .ordered:
            return .orange
        case .inPreparation:
            return .yellow
        case .inDelivery:
            return .green
        case .delivered:
            return .blue
        case .cancelled:
            return .red
        case .unknown:
            return .gray
        }
    }
}

#Preview {
    CurrentOrderView(order: Order())
        .environment(OrderManager(from: WebserviceProvider(inMode: .dev)))
}
