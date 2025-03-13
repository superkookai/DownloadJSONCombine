//
//  DownloadWithCombine.swift
//  DownloadJSONCombine
//
//  Created by Weerawut Chaiyasomboon on 13/03/2568.
//

import Foundation
import Combine

class DownloadWithCombine: ObservableObject {
    let baseURL = "https://jsonplaceholder.typicode.com/posts"
    var cancellable: Set<AnyCancellable> = []
    
    @Published var posts: [Post] = []
    
    init() {
        getPosts()
    }
    
    func getPosts() {
        guard let url = URL(string: baseURL) else {
            fatalError("Bad URL")
        }
        
        URLSession.shared.dataTaskPublisher(for: url)
            .subscribe(on: DispatchQueue.global(qos: .background))
            .receive(on: DispatchQueue.main)
            .tryMap(handleOutput)
            .decode(type: [Post].self, decoder: JSONDecoder())
            .replaceError(with: [])
            .sink(receiveValue: { [weak self] posts in
                self?.posts = posts
            })
            .store(in: &cancellable)
    }
    
    func handleOutput(output: URLSession.DataTaskPublisher.Output) throws -> Data {
        guard let httpResponse = output.response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }
        return output.data
    }
}
