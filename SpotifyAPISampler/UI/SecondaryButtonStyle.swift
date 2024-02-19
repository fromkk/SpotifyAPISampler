//
//  SecondaryButtonStyle.swift
//  SpotifyAPISampler
//
//  Created by Kazuya Ueoka on 2024/02/19.
//

import SwiftUI

struct SecondaryButtonStyle: ButtonStyle {
    public init() {}
    @Environment(\.isEnabled) public var isEnabled: Bool
    func makeBody(configuration: Configuration) -> some View {
        configuration
            .label
            .font(.body.bold())
            .foregroundStyle(Color(uiColor: .label))
            .padding(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16))
            .background(
                isEnabled
                ? .green : Color(uiColor: .secondaryLabel)
            )
            .overlay {
                Capsule()
                    .stroke(
                        .green,
                        style: StrokeStyle(lineWidth: 1)
                    )
            }
            .mask {
                Capsule()
            }
    }
}

