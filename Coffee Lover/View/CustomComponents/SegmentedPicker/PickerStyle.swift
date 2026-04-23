
import SwiftUI

struct PickerStyle: ViewModifier {
    var isSelected = true

    func body(content: Content) -> some View {
        content
            .foregroundStyle(isSelected ? .white : .black)
            .padding(.horizontal)
            .padding(.vertical, 8)
            .lineLimit(1)
            .clipShape(RoundedRectangle(cornerRadius: 4))
    }
}

extension View {
    func pickerTextStyle(isSelected: Bool) -> some View {
        modifier(PickerStyle(isSelected: isSelected))
    }
}
