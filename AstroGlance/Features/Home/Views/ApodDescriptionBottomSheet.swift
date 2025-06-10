//
//  ApodDescriptionBottomSheet.swift
//  AstroGlance
//
//  Created by Umesh Basnet on 2025-06-09.
//

import SwiftUI

struct ApodDescriptionBottomSheet: View {
    let apod : AstroDailyImage
    var body: some View {
            VStack(alignment: .leading) {
                Text(apod.title)
                    .font(.title)
                    .foregroundStyle(.white)
                    .fontWeight(.bold)
                if let owner = apod.owner {
                    Text(owner)
                        .font(.title3)
                        .fontWeight(.bold)
                        .foregroundStyle(.white.opacity(0.7))
                }
                Text(apod.date)
                    .font(.body)
                    .fontWeight(.bold)
                    .foregroundStyle(.white.opacity(0.7))
                ScrollView {
                    Text(apod.explanation)
                        .font(.title3)
                        .foregroundStyle(.white)
                }
                .padding(.bottom, 16)
            }
            .padding()
            .background(.black)
            .ignoresSafeArea()
            
        
    }
}

#Preview {
    ApodDescriptionBottomSheet(apod: DummyData.shared.getDummyAstroImage())
}
