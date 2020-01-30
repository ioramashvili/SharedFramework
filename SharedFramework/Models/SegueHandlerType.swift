
public protocol SegueHandlerType: class {
    associatedtype SeguaIdentifier: RawRepresentable
}

extension SegueHandlerType where Self: UIViewController, SeguaIdentifier.RawValue == String {

    public func performSegueWithIdentifier(segueIdentifier: SeguaIdentifier, sender: Any? = nil) {
        performSegue(withIdentifier: segueIdentifier.rawValue, sender: sender)
    }
    
    public func identifier(for segue: UIStoryboardSegue) -> SeguaIdentifier {
        guard let id = segue.identifier, let segueIdentifier = SeguaIdentifier(rawValue: id) else {
            fatalError("identifier is not implemented")
        }
        
        return segueIdentifier
    }
}

