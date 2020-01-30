
public protocol ExpandableDataProvider: AppCellDataProvider {
    var expandedHeight: CGFloat? { get set }
    var collapsedHeight: CGFloat? { get set }
    var state: AppTableViewCellState { get set }
}

public extension ExpandableDataProvider {
    var isExpanedHeightSet: Bool {
        return expandedHeight != nil
    }
    
    var isCollapsedHeightSet: Bool {
        return collapsedHeight != nil
    }
    
    var height: CGFloat {
        return state == .expanded ? (expandedHeight ?? 0) : (collapsedHeight ?? 0)
    }
}

public enum AppTableViewCellState {
    case expanded, collapsed
}

