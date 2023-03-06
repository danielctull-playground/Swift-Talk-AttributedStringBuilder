
import AppKit

struct Attributes {
    var family: String = "Helvetica"
    var size: CGFloat = 14
    var traits: NSFontTraitMask = []
    var weight: Int = 5
    var foregroundColor: NSColor = .textColor

    var bold: Bool {
        get {
            traits.contains(.boldFontMask)
        }
        set {
            if newValue {
                traits.insert(.boldFontMask)
            } else {
                traits.remove(.boldFontMask)
            }
        }
    }
}

extension Attributes {

    var dictionary: [NSAttributedString.Key: Any] {
        let fm = NSFontManager.shared
        let font = fm.font(withFamily: family, traits: traits, weight: weight, size: size)
        return [
            .font: font as Any,
            .foregroundColor: foregroundColor as Any,
        ]
    }
}

// MARK: - Modify

extension AttributedStringConvertible {

    func bold() -> some AttributedStringConvertible {
        Modify(content: self) { $0.bold = true }
    }

    func foregroundColor(_ color: NSColor) -> some AttributedStringConvertible {
        Modify(content: self) { $0.foregroundColor = color }
    }
}

private struct Modify: AttributedStringConvertible {

    let content: AttributedStringConvertible
    let modify: (inout Attributes) -> ()

    func attributedString(environment: Environment) -> [NSAttributedString] {
        var environment = environment
        modify(&environment.attributes)
        return content.attributedString(environment: environment)
    }
}
