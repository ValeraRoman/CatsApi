//
//  CatViewModel.swift
//  CatsApi
//
//  Created by Dream Store on 26.10.2021.
//

import Foundation

final class CatViewModel: ObservableObject {
    
    var session: URLSession!
    
    func getListOfCats(compliction: @escaping([Cat]) ->()){
        guard  let url = URL(string: "https://api.thecatapi.com/v1/images/search?limit=10") else {return}
        URLSession.shared.dataTask(with: url) { data, urlsession, error in
            let post = try! JSONDecoder().decode([Cat].self, from: data!)
            DispatchQueue.main.async {
                compliction(post)
            }
        }
        .resume()
    }
    
}
