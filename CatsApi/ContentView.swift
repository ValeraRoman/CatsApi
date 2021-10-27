//
//  ContentView.swift
//  CatsApi
//
//  Created by Dream Store on 26.10.2021.
//

import SwiftUI

struct ContentView: View {
    
    //MARK: - Property
    
    @State private var cats: [Cat] = []
    
    var body: some View {
        ZStack {
            Color(.systemBackground).edgesIgnoringSafeArea(.all)
            VStack {
                ScrollView(.vertical, showsIndicators: false, content: {
                    VStack(alignment: .center, spacing: 15) {
                        ForEach(cats){ cat in
                            CatView(cat: cat)
                        }
                    }.padding([.trailing, .leading], 16)
                } ).padding(.bottom)
            }
        }
        .onAppear {
            CatViewModel().getListOfCats { catsModel in
                self.cats = catsModel
            }
            timer()
        }
    }
    
    //MARK: Timer for reload every 20 sec.
    
    func timer() {
        DispatchQueue.main.async {
            _ = Timer.scheduledTimer(withTimeInterval: 20, repeats: true) { timer in
                CatViewModel().getListOfCats { catsModel in
                    self.cats = catsModel
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
