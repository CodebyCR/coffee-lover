
import SwiftUI

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
