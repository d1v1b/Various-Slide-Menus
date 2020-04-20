//
//  ContentView.swift
//  FromLeft
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
                NavigationView {
                    ZStack {
                        VStack () {
                            Spacer()
                            Text("This is main contents")
                                .font(.largeTitle)
                            Spacer()
                        }
                        Color.gray.opacity(
                            Double((self.closeOffset - self.offset)/self.closeOffset) - 0.4
                        )
                    }
                    .navigationBarTitle("This is bar", displayMode: .inline)
                    .navigationBarItems(leading: Button(action: {
                            self.offset = self.openOffset
                        }){
                            Image(systemName: "list.bullet")
                        })
                    .edgesIgnoringSafeArea(.vertical)
                }
                MenuView()
                    .background(Color.white)
                    .frame(width: geometry.size.width * 0.7)
                    .edgesIgnoringSafeArea(.bottom)
                    .onAppear(perform: {
                        self.offset = geometry.size.width * -1
                        self.closeOffset = self.offset
                        self.openOffset = .zero
                    })
                    .offset(x: self.offset)
                    .animation(.default)
            }
            .gesture(DragGesture(minimumDistance: 5)
                    .onChanged{ value in
                        if (self.offset < self.openOffset) {
                            self.offset = self.closeOffset + value.translation.width
                        }
                    }
                    .onEnded { value in
                        if (value.location.x > value.startLocation.x) {
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
