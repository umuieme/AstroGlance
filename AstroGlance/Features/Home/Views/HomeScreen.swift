//
//  HomeScreen.swift
//  AstroGlance
//
//  Created by Umesh Basnet on 2025-06-08.
//

import Kingfisher
import SwiftUI

struct HomeScreen: View {

    @StateObject private var homeViewModel = HomeViewModel()

    var body: some View {

        GeometryReader { geo in
            ZStack {
                ScrollView(.vertical, showsIndicators: false) {
                    LazyVStack(spacing: 0) {
                        ForEach(
                            homeViewModel.apodList
                        ) { item in
                            AstroGlanceItemView(astroImage: item)
                                .frame(
                                    width: geo.size.width,
                                    height: geo.size.height
                                )
                                .task {
                                    await homeViewModel.onItemChanged(
                                        apod: item)
                                }
                        }

                    }

                }
                .scrollTargetBehavior(.paging)

                if homeViewModel.isLoading {
                    ProgressView()
                }
            }
        }
        .ignoresSafeArea()
        .task {
            await homeViewModel.getApodData()
        }

    }
}

#Preview {
    HomeScreen()
}
