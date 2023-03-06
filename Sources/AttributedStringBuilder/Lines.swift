
import Foundation

struct Lines<Content: AttributedStringConvertible>: AttributedStringConvertible {

    @AttributedStringBuilder
    let content: Content

    func attributedString(environment: Environment) -> [NSAttributedString] {
        [single(environment: environment)]
    }

    func single(environment: Environment) -> NSAttributedString {
        let pieces = content.attributedString(environment: environment)
        guard let first = pieces.first else { return .init() }
        let result = NSMutableAttributedString(attributedString: first)
        for piece in pieces.dropFirst() {
            result.append(.init(string: "\n", attributes: environment.attributes))
            result.append(piece)
        }
        return result
    }
}
