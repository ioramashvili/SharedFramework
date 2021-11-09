import UIKit

public protocol ExpandableDataProvider: AppCellDataProvider {
    var expandedHeight: CGFloat? { get set }
    var collapsedHeight: CGFloat? { get set }
    var state: AppTableViewCellState { get set }
}

public extension ExpandableDataProvider {
    var isExpanedHeightSet: Bool {
        expandedHeight != nil
    }

    var isCollapsedHeightSet: Bool {
        collapsedHeight != nil
    }

    var height: CGFloat {
        state == .expanded ? (expandedHeight ?? 0) : (collapsedHeight ?? 0)
    }
}

public enum AppTableViewCellState {
    case expanded, collapsed
}
