//
//  AstroGralnceItemViewModel.swift
//  AstroGlance
//
//  Created by Umesh Basnet on 2025-06-10.
//

import Foundation
import UIKit
import Photos

enum DownloadStatus {
    case initial
    case downloading
    case completed
    
}


enum ImageSaveError: LocalizedError {
    case permissionDenied
    case saveFailed(Error)

    var errorDescription: String? {
        switch self {
        case .permissionDenied:
            return "Permission to save to Photos was denied."
        case .saveFailed(let err):
            return "Failed to save image: \(err.localizedDescription)"
        }
    }
}


@MainActor
class AstroGralnceItemViewModel : ObservableObject {
    
    let apod : AstroDailyImage
    
    @Published var downloadStatus : DownloadStatus = .initial
    
    @Published var showDetailModal = false
    @Published var shouldHideText = false
    @Published var alertMessage: String = ""
    @Published var showingAlert = false
    
    init(apod: AstroDailyImage ){
        self.apod = apod
    }
    
    func downloadImage() async {
        do {
            let data = try await NetworkManager.shared.saveImage(
                from: apod.hdurl!
            )
            
            guard let uiImage = UIImage(data: data) else { return }
            downloadStatus = .downloading
            
            // a) Request Add-Only access
            let status = PHPhotoLibrary.authorizationStatus(for: .addOnly)
            if status == .notDetermined {
                let new = await PHPhotoLibrary.requestAuthorization(for: .addOnly)
                guard new == .authorized else {
                    alertMessage = ImageSaveError.permissionDenied.localizedDescription
                    showingAlert = true
                    return
                }
            } else if status != .authorized {
                alertMessage = ImageSaveError.permissionDenied.localizedDescription
                showingAlert = true
                return
            }
            
            // b) Perform save
            do {
                try await PHPhotoLibrary.shared().performChanges {
                    PHAssetCreationRequest.creationRequestForAsset(from: uiImage)
                }
                alertMessage = "Image saved to your Photos library."
                downloadStatus = .completed
            } catch {
                alertMessage = ImageSaveError.saveFailed(error).localizedDescription
            }
            showingAlert = true
        } catch let error {
            print("Error ==== ", error)
        }
            
    }

}
