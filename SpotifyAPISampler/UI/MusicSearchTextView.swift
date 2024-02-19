//
//  MusicSearchTextView.swift
//  SpotifyAPISampler
//
//  Created by Kazuya Ueoka on 2024/02/19.
//

import SwiftUI

public struct MusicSearchTextView: View {
    let text: Binding<String>
    let onSubmit: () -> Void

    public init(text: Binding<String>, onSubmit: @escaping () -> Void) {
        self.text = text
        self.onSubmit = onSubmit
    }

    public var body: some View {
        VStack {
            Text("Search")
                .font(.body)
                .foregroundStyle(Color(uiColor: .label))
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(EdgeInsets(top: 8, leading: 8, bottom: 4, trailing: 8))

            HStack {
                TextField(
                    "Search",
                    text: text,
                    prompt: Text("Search for music you love")
                )
                .onSubmit(onSubmit)
                .font(.body)
                .foregroundStyle(Color(uiColor: .label))

                Image(systemName: "magnifyingglass")
                    .font(.system(size: 18, weight: .light))
                    .foregroundStyle(Color(uiColor: .label))
            }
            .padding(EdgeInsets(top: 12, leading: 16, bottom: 12, trailing: 16))
            .background(Color(uiColor: .systemBackground))
            .clipShape(RoundedRectangle(cornerSize: CGSize(width: 8, height: 8)))
        }
        .padding(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16))
        .background(Color(uiColor: .secondarySystemBackground))
    }
}

#Preview {
    MusicSearchTextView(text: Binding<String>.init(get: { "" }, set: { _ in }), onSubmit: {})
}
