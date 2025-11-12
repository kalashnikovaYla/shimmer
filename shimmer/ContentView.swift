//
//  ContentView.swift
//  shimmer
//
//  Created by Юлия Калашникова on 12.11.2025.
//

import SwiftUI

struct ContentView: View {
    @State private var showShimmer = true

    var body: some View {
        VStack(alignment: .leading) {
            Text("Title")
                .font(.largeTitle)
            VStack{}.frame(width: 300, height: 120).background(Color.gray).cornerRadius(20)
            VStack{}.frame(width: 250, height: 100).background(Color.gray).cornerRadius(20)
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .addModifier(showShimmer) { view in
            view.modifier(ShimmerModifier())
        }
        .onTapGesture {
            showShimmer.toggle()
        }
    }
}

extension View {
    @ViewBuilder func addModifier<Content: View>(_ condition: Bool, apply: (Self) -> Content) -> some View {
        if condition {
            apply(self)
        } else {
            self
        }
    }
}

#Preview {
    ContentView()
}

public struct ShimmerModifier: ViewModifier {
    
    @State var isInitialState: Bool = true
    let mainColor = Color.accentColor
    
    public func body(content: Content) -> some View {
        content
            .mask {
                LinearGradient(
                    gradient: .init(colors: [
                        mainColor.opacity(0.3),
                        mainColor.opacity(0.4),
                        mainColor.opacity(0.3)
                    ]
                    ),
                    
                    startPoint: (isInitialState ? 
                        .init(x: 0, y: 0) : .init(x: 1.3, y: 1.3)),
                    endPoint: (isInitialState ? 
                        .init(x: -0.5, y: -0.5) : .init(x: 1, y: 1))
                )
            }
            .animation(.linear(duration: 1.5)
                .delay(0.25).repeatForever(autoreverses: false),
                       value: isInitialState)
            .onAppear() {
                isInitialState = false
            }
    }
}
