//
//  ContentView.swift
//  FromRight
//
//  Created by SoNice! on 2020/04/20.
//  Copyright © 2020 com.d1v1b. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var offset = CGFloat.zero
    @State private var closeOffset = CGFloat.zero
    @State private var openOffset = CGFloat.zero
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                VStack () {
                    HStack () {
                        Spacer()
                        Text("This Is Bar")
                        Spacer()
                        Button(action: {
                            self.offset = self.openOffset
                        }){
                            Image(systemName: "list.bullet")
                        }
                    }
                    .padding(.horizontal)
                    Divider()
                    Spacer()
                    Text("This is main contents")
                        .font(.largeTitle)
                    Spacer()
                }
                .background(Color.white)
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center)
                Color.gray.opacity(
                    Double((self.closeOffset - self.offset)/self.closeOffset) - 0.4
                )
                MenuView()
                    .background(Color.white)
                    .frame(width: geometry.size.width * 0.7)
                    .onAppear(perform: {
                        self.offset = geometry.size.width
                        self.closeOffset = self.offset
                        self.openOffset = geometry.size.width - geometry.size.width * 0.7
                    })
                    .offset(x: self.offset)
                    .animation(.default)
            }
                .gesture(DragGesture(minimumDistance: 5)
                    .onChanged{ value in
                        if (self.offset > self.openOffset) {
                            self.offset = self.closeOffset + value.translation.width
                        }
                    }
                    .onEnded { value in
                        if (value.translation.width < 0) {
                            self.offset = self.openOffset
                        } else {
                            self.offset = self.closeOffset
                        }
                    }
                )
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
