//
//  AstroGlanceItemView.swift
//  AstroGlance
//
//  Created by Umesh Basnet on 2025-06-08.
//

import Kingfisher
import SwiftUI

struct AstroGlanceItemView: View {

    let astroImage: AstroDailyImage

    var body: some View {
        GeometryReader { geo in

            ZStack {
                KFImage
                    .url(URL(string: astroImage.url))
                    .setProcessor(
                        DownsamplingImageProcessor(size: geo.size)
                    )
                    .resizable()
                    .placeholder {
                        ProgressView().tint(.white)
                    }
                    .cancelOnDisappear(true)
                    .aspectRatio(contentMode: .fill)
                    .frame(
                        width: geo.size.width,
                        height: geo.size.height
                    )  // full width & height
                    .clipped()  // crop any overflow
                VStack {
                    Spacer()
                    VStack(alignment: .leading) {
                        Text(astroImage.title)
                            .font(.title)
                            .foregroundStyle(.white)
                            .fontWeight(.bold)
                            .padding(.bottom, 8)
                        if let copyright = astroImage.copyright {
                            Text(copyright)
                                .font(.title3)
                                .fontWeight(.bold)
                                .padding(.bottom, 8)
                                .foregroundStyle(.white.opacity(0.7))
                        }
                        Text(astroImage.date)
                            .font(.body)
                            .fontWeight(.bold)
                            .padding(.bottom, 8)
                            .foregroundStyle(.white.opacity(0.7))
                        Text(astroImage.explanation)
                            .lineLimit(3)
                            .font(.title3)
                            .foregroundStyle(.white)
                        Spacer()
                            .frame(height: 32)
                    }
                    .padding()
                    .frame(width: geo.size.width)
                    .background {
                        LinearGradient(
                            colors: [.black, .black.opacity(0)],
                            startPoint: .bottom,
                            endPoint: .top
                        )
                    }

                }
                .padding(0)
                .frame(width: geo.size.width, height: geo.size.height)

            }  // ZStack
            .frame(width: geo.size.width, height: geo.size.height)
        }
        .ignoresSafeArea()
        .foregroundStyle(.white)
        .background(.black)

    }
}

#Preview {
    AstroGlanceItemView(astroImage: DummyData.shared.getDummyAstroImage())
}
