//
//  ContentView.swift
//  DownloadJSONCombine
//
//  Created by Weerawut Chaiyasomboon on 13/03/2568.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var vm = DownloadWithCombine()
    
    var body: some View {
        NavigationStack {
            List(vm.posts) { post in
                VStack(alignment: .leading) {
                    Text(post.title.capitalized)
                        .fontWeight(.bold)
                    
                    Text(post.body)
                }
            }
            .listStyle(.plain)
            .navigationTitle("Posts")
        }
    }
}

#Preview {
    ContentView()
}
