//
//  ContentView.swift
//  FromTop
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
            NavigationView {
                ZStack(alignment: .topLeading) {
                    VStack () {
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
                        .frame(width: geometry.size.width, height: geometry.size.height * 0.7)
                        .onAppear(perform: {
                            self.offset = (geometry.frame(in: .global).origin.y + geometry.size.height) * -1
                            self.closeOffset = self.offset
                            self.openOffset = .zero
                        })
                        .offset(y: self.offset)
                        .animation(.default)
                }
                .gesture(DragGesture(minimumDistance: 5)
                    .onChanged{ value in
                        if (self.offset != self.openOffset && value.startLocation.y < 30) {
                            self.offset = self.closeOffset + value.translation.height
                        }
                    }
                    .onEnded { value in
                        if (value.startLocation.y < value.location.y) {
                            if (value.startLocation.y < 30) {
                                self.offset = self.openOffset
                            }
                        } else {
                            self.offset = self.closeOffset
                        }
                    }
                )
                .navigationBarTitle("This is bar", displayMode: .inline)
                .navigationBarItems(trailing: Button(action: {
                        if (self.offset == self.openOffset) {
                            self.offset = self.closeOffset
                        } else {
                            self.offset = self.openOffset
                        }
                    }){
                        Image(systemName: "list.bullet")
                    })
                    .edgesIgnoringSafeArea(.bottom)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
