import GdsKit

/*
 If these colors collide with colors provided by GdsKit, then GdsKit always wins.
 */
extension GdsColor {
    static let l2Neutral04 = GdsColor(rawValue: "l2Neutral04")
    static let l3Tonal01 = GdsColor(rawValue: "l3Tonal01")
    static let stateTonal01 = GdsColor(rawValue: "stateTonal01")
    
    static let tempCritical = GdsColor(rawValue: "tempCritical")
    static let tempWarning = GdsColor(rawValue: "tempWarning")
    static let tempNotice = GdsColor(rawValue: "tempNotice")
}
