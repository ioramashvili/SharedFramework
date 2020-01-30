
open class AppCollectionViewController: UICollectionViewController {
    
    open var dataProvider: AppListDataProvider? {
        didSet {
            collectionView?.reloadData()
        }
    }
    
    public var flowLayout: UICollectionViewFlowLayout? {
        return collectionView?.collectionViewLayout as? UICollectionViewFlowLayout
    }
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView?.showsHorizontalScrollIndicator = false
        collectionView?.showsVerticalScrollIndicator = false
        
        if let layout = flowLayout {
            layout.minimumInteritemSpacing = 0
            layout.minimumLineSpacing = 0
            layout.sectionInset = .zero
        }
    }
    
    open override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return dataProvider?.count ?? 0
    }
    
    open override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataProvider?.sectionDataProvider(at: section).count ?? 0
    }
    
    open override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let sectionDataProvider = dataProvider?.sectionDataProvider(at: indexPath.section) else {fatalError("section not found at index \(indexPath.section)")}

        let reusableDataProvider = kind == AppSupplementaryKind.header.value ? sectionDataProvider.header : sectionDataProvider.footer
        
        if reusableDataProvider == nil { return UICollectionReusableView() }
        
        guard let supplementaryViewDataProvider = reusableDataProvider as? AppSupplementaryViewDataProvider else {
            fatalError("header or footer dataProvider is not AppSupplementaryViewDataProvider")
        }
        
        let cell = collectionView.dequeueReusableSupplementary(dataProvider: supplementaryViewDataProvider, for: indexPath)
        cell.dataProvider = supplementaryViewDataProvider
        return cell
    }
    
    open override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let dataProvider = dataProvider?[indexPath] else {fatalError("item not found at indexPath \(indexPath)")}
        let cell = collectionView.dequeueReusable(dataProvider: dataProvider, for: indexPath)
        cell.dataProvider = dataProvider
        return cell
    }
    
    open override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        (dataProvider?[indexPath] as? AppCellDelegate)?.didSelect(at: indexPath)
    }
}





