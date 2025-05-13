//
//  ProgressView+extension.swift
//  iOSTakeHomeChallenge
//
//  Created by Hashim Akhtar on 13/05/2025.
//

import SwiftUI

extension ProgressView {
    @ViewBuilder public func isHidden(_ isHidden: Binding<Bool>) -> some View {
        if isHidden.wrappedValue {
            self.hidden()
        }
        else {
            self
        }
    }
}
