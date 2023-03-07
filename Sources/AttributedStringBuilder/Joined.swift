
import Foundation

extension AttributedStringConvertible {

    func joined(separator: AttributedStringConvertible = "\n") -> some AttributedStringConvertible {
        Joined(content: self, separator: separator)
    }
}

struct Joined<Content: AttributedStringConvertible>: AttributedStringConvertible {

    let content: Content
    let separator: AttributedStringConvertible

    func attributedString(environment: Environment) -> [NSAttributedString] {
        [single(environment: environment)]
    }

    @MainActor
    func single(environment: Environment) -> NSAttributedString {
        let pieces = content.attributedString(environment: environment)
        guard let first = pieces.first else { return .init() }
        let result = NSMutableAttributedString(attributedString: first)
        let separators = separator.attributedString(environment: environment)
        for piece in pieces.dropFirst() {
            for separator in separators {
                result.append(separator)
            }
            result.append(piece)
        }
        return result
    }
}
