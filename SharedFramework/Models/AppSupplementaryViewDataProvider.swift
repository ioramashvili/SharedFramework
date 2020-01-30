
public protocol AppSupplementaryViewDataProvider: AppCellDataProvider {
    var kind: AppSupplementaryKind { get }
}

public enum AppSupplementaryKind {
    case header, footer
    
    var value: String {
        switch self {
        case .header: return UICollectionView.elementKindSectionHeader
        case .footer: return UICollectionView.elementKindSectionFooter
        }
    }
}
