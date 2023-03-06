
import AppKit

struct Attributes {
    var family: String = "Helvetica"
    var size: CGFloat = 14
    var traits: NSFontTraitMask = []
    var weight: Int = 5

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
            .font: font as Any
        ]
    }
}

// MARK: - Bold

extension AttributedStringConvertible {

    func bold() -> some AttributedStringConvertible {
        Bold(content: self)
    }
}

private struct Bold: AttributedStringConvertible {

    let content: AttributedStringConvertible

    func attributedString(environment: Environment) -> [NSAttributedString] {
        var environment = environment
        environment.attributes.bold = true
        return content.attributedString(environment: environment)
    }
}
