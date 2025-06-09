//
//  HomeScreen.swift
//  AstroGlance
//
//  Created by Umesh Basnet on 2025-06-08.
//

import Kingfisher
import SwiftUI

struct HomeScreen: View {
    
    
    var body: some View {
    
        GeometryReader { geo in
                   ScrollView(.vertical, showsIndicators: false) {
                       LazyVStack(spacing: 0) {
                           ForEach(
                            DummyData.shared.getDummyAstroImageList()
                           ) { item in
                               AstroGlanceItemView(astroImage: item)
                                                 .frame(width: geo.size.width, height: geo.size.height)
                                                 .onAppear(){
                                                     print("zzz ===== ")
                                                 }
                                 // make each item fill the screen
                                 
                           }
                       }
                       
                   }
                   // snap to each full-screen “page”
                   .scrollTargetBehavior(.paging)
               }
        .ignoresSafeArea()

    }
}

#Preview {
    HomeScreen()
}
