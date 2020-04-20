//
//  MenuView.swift
//  FromLeft
//
//  Created by SoNice! on 2020/04/20.
//  Copyright © 2020 com.d1v1b. All rights reserved.
//

import SwiftUI

struct MenuView: View {

    var body: some View {
        VStack(alignment: .leading) {
            Image("icon")
                .resizable()
                .overlay(
                    Circle().stroke(Color.gray, lineWidth: 1))
                .frame(width: 60, height: 60)
                .clipShape(Circle())
            Text("Road2SwiftUI")
                .font(.largeTitle)
            Text("@SoNiceInfo - d1v1b.com")
                .font(.caption)
            Divider()
            ScrollView (.vertical, showsIndicators: true) {
                HStack {
                    Image(systemName: "person")
                    Text("Profile")
                }
                HStack {
                    Image(systemName: "list.dash")
                    Text("Lists")
                }
                HStack {
                    Image(systemName: "text.bubble")
                    Text("Topics")
                }
            }
            Divider()
            Text("Settings and privacy")
        }
        .padding(.horizontal, 20)
    }
}


struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView()
    }
}
