//
//  PickerStyle.swift
//  Coffee Lover
//
//  Created by Christoph Rohde on 09.03.25.
//

//
//  PickerStyle.swift
//  SegmentedControlPicker
//
//  Created by Marwa Abou Niaaj on 01/01/2024.
//

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
