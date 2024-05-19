// https://clevertap.com/blog/improve-ios-app-ratings-with-skstorereviewcontroller/

import StoreKit

public class StoreReviewManager {
    private init() { }

    static let step = 1
    public static let shared = StoreReviewManager()
    public weak var delegate: StoreReviewManagerDelegate?

    fileprivate(set) var count: Int {
        get {
            return UserDefaults.standard.integer(forKey: Key.count.value)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: Key.count.value)
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2)) {
                self.requestReviewIfNeeded()
            }
        }
    }

    private func requestReview() {
        if #available(iOS 10.3, *) {
            SKStoreReviewController.requestReview()
        }
    }

    private func requestReviewIfNeeded() {
        if let delegate = delegate, delegate.cycles.contains(count) {
            requestReview()
        }
    }

    public func increaseTargetCount() {
        count += StoreReviewManager.step
    }
}
