//
//  DownloadButton.swift
//  AstroGlance
//
//  Created by Umesh Basnet on 2025-06-10.
//

import SwiftUI

struct DownloadButton: View {
    let status: DownloadStatus
    let action: () -> Void
    
    var body: some View {
        Group {
            switch status {
            case .initial:
                Button {
                    action()
                } label: {
                    Image(systemName: "arrow.down.circle")
                        .font(.system(size: 32))
                        .foregroundColor(.white)
                }
                
            case .downloading:
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle())
                    .tint(.primary)
                    .scaleEffect(2)
                
            case .completed:
                Image(systemName: "checkmark.circle.fill")
                    .font(.system(size: 32))
                    .foregroundColor(.green)
            }
        }
        .animation(.easeInOut, value: status)
    }
}

#Preview {
    DownloadButton(status: .downloading, action: {})
//        .background(.black)
}

