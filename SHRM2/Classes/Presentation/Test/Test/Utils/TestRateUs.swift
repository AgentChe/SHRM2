//
//  TestRateUs.swift
//  ITExams
//
//  Created by Андрей Чернышев on 08.06.2022.
//

import StoreKit

final class TestRateUs {
    enum Constants {
        static let showFirstAfterPass = "test_rate_us_first_after_pass"
    }
    
    func showFirstAfterPassRateAlert() {
        let isFirstAfterPass = UserDefaults.standard.bool(forKey: Constants.showFirstAfterPass)
        
        guard !isFirstAfterPass else {
            return
        }
        
        SKStoreReviewController.requestReview()
        
        UserDefaults.standard.setValue(true, forKey: Constants.showFirstAfterPass)
    }
}
