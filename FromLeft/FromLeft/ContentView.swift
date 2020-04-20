//
//  ContentView.swift
//  FromLeft
//
//  Created by SoNice! on 2020/04/20.
//  Copyright © 2020 com.d1v1b. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    // offset変数でメニューを表示・非表示するためのオフセットを保持します
    @State private var offset = CGFloat.zero
    @State private var closeOffset = CGFloat.zero
    @State private var openOffset = CGFloat.zero
    
    var body: some View {
        // 画面サイズの取得にGeometoryReaderを利用します
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                // メインコンテンツ
                VStack () {
                    HStack () {
                        Button(action: {
                            self.offset = self.openOffset
                        }){
                            Image(systemName: "list.bullet")
                        }
                        Spacer()
                        Text("This Is Bar")
                        Spacer()
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
                // スライドメニューがでてきたらメインコンテンツをグレイアウトします
                Color.gray.opacity(
                    Double((self.closeOffset - self.offset)/self.closeOffset) - 0.4
                )
                // スライドメニュー
                MenuView()
                    .background(Color.white)
                    .frame(width: geometry.size.width * 0.7)
                    // 最初に画面のオフセットの値をスライドメニュー分マイナスします。
                    .onAppear(perform: {
                        self.offset = geometry.size.width * -1
                        self.closeOffset = self.offset
                        self.openOffset = .zero
                    })
                    .offset(x: self.offset)
                    // スライドのアニメーションを設定します
                    .animation(.default)
            }
            // ジェスチャーに関する実装をします
            // スワイプのしきい値を設定してユーザの思わぬメニューの出現を防ぎます
            .gesture(DragGesture(minimumDistance: 5)
                .onChanged{ value in
                    // オフセットの値(メニューの位置)をスワイプした距離に応じて狭めていきます
                    if (self.offset < self.openOffset) {
                        self.offset = self.closeOffset + value.translation.width
                    }
                }
                .onEnded { value in
                    // スワイプ終了位置が開始位置よりも右にあればメニューを開く
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
