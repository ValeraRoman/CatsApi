//
//  CatView.swift
//  CatPhotos
//
//  Created by Dream Store on 26.10.2021.
//

import SwiftUI

struct CatView: View {
    
    @State var cat: Cat
    
    var body: some View {
        ZStack {
            RemoteImage(url: cat.url)
            ZStack {
                Color.white.opacity(cat.breeds.first != nil ? 0.3: 0)
                Text(cat.breeds.first?.name ?? "")
                    .foregroundColor(.black)
                    .frame(alignment:.center)
                    .font(.largeTitle)
            }.frame(height: 25, alignment: .top)
        }
    }
}
