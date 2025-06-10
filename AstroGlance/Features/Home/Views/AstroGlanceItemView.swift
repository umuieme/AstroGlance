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
    @StateObject private var viewModel : AstroGralnceItemViewModel
    
    init(astroImage: AstroDailyImage) {
        self.astroImage = astroImage
        _viewModel = StateObject(
            wrappedValue:  AstroGralnceItemViewModel(apod: astroImage)
        )
    }
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                AppNetworkImageView(
                    imageUrl: astroImage.imageUrl,
                    size: geo.size
                )
                .onTapGesture {
                    withAnimation(.easeInOut) {
                        viewModel.shouldHideText.toggle()
                    }
                }
                VStack {
                    Spacer()
                    if !viewModel.shouldHideText {
                        VStack(alignment: .leading) {
                           
                            HStack {
                                Text(astroImage.title)
                                    .font(.title)
                                    .foregroundStyle(.white)
                                    .lineLimit(2)
                                    .fontWeight(.bold)
                                Spacer(minLength: 10)
                                if(astroImage.hdurl != nil){
                                    DownloadButton(
                                        status: viewModel.downloadStatus) {
                                            Task {
                                                await viewModel.downloadImage()
                                            }
                                            
                                        }
                                }
                            }
                            Text(astroImage.date)
                                .font(.body)
                                .fontWeight(.bold)
                                .foregroundStyle(.white.opacity(0.7))
                            Text(astroImage.explanation)
                                .lineLimit(3)
                                .font(.title3)
                                .foregroundStyle(.white)
                                .onTapGesture {
                                    viewModel.showDetailModal = true
                                }

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
                        .transition(
                            .move(edge: .bottom).combined(with: .opacity))
                    }
                }
                .padding(0)
                .frame(width: geo.size.width, height: geo.size.height)
                .sheet(isPresented: $viewModel.showDetailModal) {
                    ApodDescriptionBottomSheet(apod: astroImage)
                }

            }  // ZStack
            .frame(width: geo.size.width, height: geo.size.height)
        }
        .ignoresSafeArea()
        .foregroundStyle(.white)
        .background(.black)
        .alert("Image Download", isPresented: $viewModel.showingAlert) {
                    Button("OK", role: .cancel) { }
                } message: {
                    Text(viewModel.alertMessage)
                }

    }
}

#Preview {
    AstroGlanceItemView(astroImage: DummyData.shared.getDummyAstroImage())
}
