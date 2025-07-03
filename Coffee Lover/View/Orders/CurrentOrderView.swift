//
//  CurrentOrderView.swift
//  Coffee Lover
//
//  Created by Christoph Rohde on 16.03.25.
//

import Coffee_Kit
import SwiftUI

struct CurrentOrderView: View {
    @Binding var currentOrder: Order
    @Binding var isExpanded: Bool
    @State var totalPrice: Double = 10.0
    @State var totalItems = 3
    @State private var orderStatus: OrderStatus = .ordered
    @State private var paymentStatus: PaymentStatus = .pending
    @State private var id: String = UUID().uuidString.substring(to: String.Index(encodedOffset: 18))

    var body: some View {
        VStack(spacing: 0) {
            // Header mit Order ID
            HStack {
                VStack(alignment: .leading) {
                    Text("Current Order")
                        .font(.headline)
                        .fontWeight(.semibold)
                    Text("Order #\(id)")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
                Spacer()

                // Status Badge
                StatusBadge(orderStatus: orderStatus)
            }
            .padding(.horizontal, 20)
            .padding(.top, 20)
            .padding(.bottom, 16)

            if isExpanded {

                Divider()

                // Order Details
                VStack(spacing: 16) {
                    OrderDetailRow(
                        icon: "clock",
                        title: "Ordered on",
                        value: formatDateTime(currentOrder.orderDate)
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
                        value: currentOrder.paymentOption.description
                    )

                    OrderDetailRow(
                        icon: "checkmark.shield",
                        title: "Payment Status",
                        value: currentOrder.paymentStatus.description,
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

struct OrderDetailRow: View {
    let icon: String
    let title: String
    let value: String
    var isHighlighted: Bool = false
    var statusColor: Color = .primary

    var body: some View {
        HStack {
            Image(systemName: icon)
                .foregroundColor(.blue)
                .frame(width: 20, height: 20)

            Text(title)
                .font(.subheadline)
                .foregroundColor(.secondary)

            Spacer()

            Text(value)
                .font(isHighlighted ? .headline : .subheadline)
                .fontWeight(isHighlighted ? .semibold : .regular)
                .foregroundColor(statusColor)
        }
        .padding(.vertical, 4)
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

enum OrderStatus: String, CaseIterable, Identifiable {
    case ordered = "ordered"
    case inPreparation = "in preparation"
    case inDelivery = "in delivery"
    case delivered = "delivered"
    case cancelled = "cancelled"
    case unknown = "unknown"

    var id: Self { self }

    public static func get(by name: String) -> Self {
        let name = name.lowercased()
        return allCases.first { $0.rawValue == name } ?? .unknown
    }

}

enum PaymentStatus: String, CaseIterable, Identifiable {
    case pending = "pending"
    case paid = "paid"
    case failed = "failed"
    case unknown = "unknown"

    var id: Self { self }

    public static func get(by name: String) -> Self {
        let name = name.lowercased()
        return allCases.first { $0.rawValue == name } ?? .unknown
    }
}





#Preview {
    @Previewable var isExpanded: Bool = true
    CurrentOrderView(currentOrder: .constant(Order()), isExpanded: .constant(isExpanded))


}
