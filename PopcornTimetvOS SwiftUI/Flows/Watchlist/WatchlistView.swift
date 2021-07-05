//
//  WatchlistView.swift
//  PopcornTimetvOS SwiftUI
//
//  Created by Alexandru Tudose on 19.06.2021.
//  Copyright © 2021 PopcornTime. All rights reserved.
//

import SwiftUI

struct WatchlistView: View {
    @StateObject var viewModel = WatchlistViewModel()
    
    var body: some View {
        ZStack {
            emptyView
            ScrollView {
                if viewModel.movies.count > 0 {
                    movieSection
                }
                if viewModel.shows.count > 0 {
                    showSection
                }
            }
            .padding(.leading, 90)
            .padding(.horizontal)
            .ignoresSafeArea(edges: [.leading, .trailing])
            .onAppear {
                viewModel.load()
            }
        }
    }
    
    @ViewBuilder
    var movieSection: some View {
        VStack(alignment: .leading) {
            Text("Movies".localized)
                .font(.callout)
                .foregroundColor(.init(white: 1.0, opacity: 0.667)) // light text color
                .padding(.top, 14)
            ScrollView(.horizontal) {
                HStack(spacing: 40) {
                    ForEach(viewModel.movies, id: \.self) { movie in
                        NavigationLink(
                            destination: MovieDetailsView(viewModel: MovieDetailsViewModel(movie: movie)),
                            label: {
                                MovieView(movie: movie)
                                    .frame(width: 240)
                            })
                            .buttonStyle(PlainNavigationLinkButtonStyle())
//                            .padding([.leading, .trailing], 10)
                    }
                    .padding(20) // allow zoom
                }.padding(.all, 0)
            }
        }
    }
    
    @ViewBuilder
    var showSection: some View {
        VStack(alignment: .leading) {
            Text("Shows".localized)
                .font(.callout)
                .foregroundColor(.init(white: 1.0, opacity: 0.667)) // light text color
                .padding(.top, 14)
            ScrollView(.horizontal) {
                HStack(spacing: 40) {
                    ForEach(viewModel.shows, id: \.self) { show in
                        NavigationLink(
                            destination: EmptyView(),
                            label: {
                                ShowView(show: show)
                                    .frame(width: 240)
                            })
                            .buttonStyle(PlainNavigationLinkButtonStyle())
//                            .padding([.leading, .trailing], 10)
                    }
                    .padding(20) // allow zoom
                }.padding(.all, 0)
            }
        }
    }
    
    @ViewBuilder
    var emptyView: some View {
        if viewModel.shows.isEmpty && viewModel.movies.isEmpty {
            VStack {
                Text("Watchlist Empty".localized)
                    .font(.title2)
                    .padding()
                Text("Try adding movies or shows to your watchlist.".localized)
                    .font(.callout)
                    .foregroundColor(.init(white: 1.0, opacity: 0.667))
                    .frame(maxWidth: 400)
                    .multilineTextAlignment(.center)
            }
        }
    }
}

struct WatchlistView_Previews: PreviewProvider {
    static var previews: some View {
        WatchlistView(viewModel: WatchlistViewModel())
    }
}
