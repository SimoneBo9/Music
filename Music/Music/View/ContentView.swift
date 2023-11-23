//
//  ContentView.swift
//  Music
//
//  Created by Simone Boni on 14/11/23.
//

import SwiftUI

struct ContentView: View {
    @Binding var tabSelection: Int
    @State var showModal =  false
    @Environment(\.dismiss) var dismiss
    let categories = CategoriesModel.categories
    let songs = SongsModel.songs
    
    var body: some View {
        
        NavigationStack {
            List {
                ForEach(categories) { category in
                    NavigationLink(destination: SecondView()) {
                        Label {
                            Text(category.category)
                        } icon: {
                            Image(systemName: category.image)
                                .renderingMode(.template)
                                .foregroundStyle(.red)
                            
                        }
                    }
                }
                LazyVGrid(columns: [
                    GridItem(.flexible()),
                        GridItem(.flexible())
                ], spacing: 16) {
                    ForEach(songs, id: \.id) { song in
                            VStack {
                                Text(song.title)
                                    .font(.title3)
                                    .fontWeight(.semibold)
                                    .multilineTextAlignment(.center)
                                    .padding(.horizontal)
                                Image(song.image)
                                    .resizable()
                                    .frame(width: 150, height: 150)
                            }
                            .frame(maxWidth: .infinity)
                        
                    }
                }
            }
            .listStyle(.plain)
            .navigationTitle("Library")
            .toolbar {
                ToolbarItem{
                    EditButton()
                        .tint(.red)
                    
                }
            }
            Button(action: { self.showModal = true }) {
                PlayerView()
            }
            .tint(.black)
            .sheet(isPresented: $showModal, onDismiss: {
                self.showModal = false
            })
            {
                CloseModalView()
                    
            }
            
            
        }
    }
}

#Preview {
    TabBarView()
}
