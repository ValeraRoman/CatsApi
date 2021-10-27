//
//  RemoteImage.swift
//  CatPhotos
//
//  Created by Dream Store on 25.10.2021.
//

import SwiftUI

struct RemoteImage: View {
    
    private enum LoadState {
        case loading, success, failure, staticImage
    }

    private class Loader: ObservableObject {
        var data: Data?
        @Published var state = LoadState.loading

        init(urlString: String) {
            if let parsedURL = URL(string: urlString)  {
                load(url: parsedURL)
            } else {
                state = .staticImage
            }
        }
        
        func load(url: URL) {
            self.state = .loading
            DispatchQueue.global().async {
                URLSession.shared.dataTask(with: url) { data, response, error in
                    DispatchQueue.main.async {
                        if let data = data, data.count > 0 {
                            self.data = data
                            self.state = .success
                        } else {
                            self.state = .failure
                        }
                        self.objectWillChange.send()
                    }
                }.resume()
            }
        }
    }

    @ObservedObject private var loader: Loader
    var staticImage: Image?
    var loading: Image?
    var failure: Image?

    var body: some View {
        if self.loader.state == .loading {
            ZStack {
                Color(.white).opacity(0.1)
                ProgressView().progressViewStyle(CircularProgressViewStyle(tint: Color(.white).opacity(0.6)))
            }
        } else {
            selectImage().resizable().scaledToFill()
        }
    }

    init(url: String, loading: Image = Image(systemName: "photo"), failure: Image = Image(systemName: "multiply.circle")) {
        self.loader = Loader(urlString: url)
        self.loading = loading
        self.failure = failure
    }

    private func selectImage() -> Image {
        switch loader.state {
        case .loading:
            return loading!
        case .failure:
            return failure!
        case .staticImage:
            return self.staticImage!
        default:
            if let data = loader.data {
                guard let image = UIImage(data: data) else { return Image("https://cdn2.thecatapi.com/images/ahu.jpg")}
                return Image(uiImage: image)
            } else {
                return failure!
            }
        }
    }
}

struct RemoteImage_Previews: PreviewProvider {
    static var previews: some View {
        RemoteImage(url: "https://cdn2.thecatapi.com/images/ahu.jpg")
    }
}
