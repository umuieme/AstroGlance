//
//  HomeViewModel.swift
//  AstroGlance
//
//  Created by Umesh Basnet on 2025-06-09.
//

import Foundation

@MainActor class HomeViewModel: ObservableObject {

    @Published var apodList: [AstroDailyImage] = []
    @Published var isLoading = false

    private let intervalDays = -14
    /// The current “window” we’re fetching:
    private var endDate: Date
    private var startDate: Date

    /// Format dates as "YYYY-MM-DD" for the API
    private let dateFormatter: DateFormatter = {
        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd"
        df.timeZone = TimeZone(identifier: "UTC")
        return df
    }()

    init() {
        let today = Date()
        self.endDate = today
        // 14 days before today
        self.startDate = Calendar.current.date(
            byAdding: .day,
            value: intervalDays,
            to: today)!
    }

    func getApodData() async {
        guard !isLoading else { return }
        isLoading = true
        defer { isLoading = false }

        let startString = dateFormatter.string(from: startDate)
        let endString = dateFormatter.string(from: endDate)

        do {
            let data = try await NetworkManager.shared
                .fetchDailyImageList(
                    startDate: startString,
                    endDate: endString)

           
            apodList.append(contentsOf: data.reversed())

           
            endDate = Calendar.current.date(
                byAdding: .day,
                value: -1,
                to: startDate)!
            startDate = Calendar.current.date(
                byAdding: .day,
                value: intervalDays,
                to: endDate)!
        } catch {
        }

    }
    
    func onItemChanged(apod: AstroDailyImage) async {
        if(apod.id == apodList[apodList.endIndex - 2].id) {
            await getApodData()
        }
    }

}
