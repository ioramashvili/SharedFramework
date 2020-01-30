
extension Int {
    public var random: Int {
        return Int(arc4random_uniform(UInt32(self)))
    }
    
    public static func random(from: Int, to: Int) -> Int {
        return Int(arc4random_uniform(UInt32(to - from + 1))) + from
    }
}
