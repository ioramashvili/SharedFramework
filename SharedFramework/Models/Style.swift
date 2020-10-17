import Foundation

public struct Style<View: UIView> {

    public typealias Style = (View) -> Void
    public let style: Style

    public init(_ style: @escaping Style) {
        self.style = style
    }

    public func apply(to view: View) {
        style(view)
    }
}

extension UIView {
    public convenience init<V>(style: Style<V>) {
        self.init(frame: .zero)
        apply(style)
    }

    public convenience init<V>(frame: CGRect, style: Style<V>) {
        self.init(frame: frame)
        apply(style)
    }

    public func apply<V>(_ style: Style<V>) {
        guard let view = self as? V else {
            print("Can't apply \(V.self) to \(type(of: self))")
            return
        }

        style.apply(to: view)
    }
}
