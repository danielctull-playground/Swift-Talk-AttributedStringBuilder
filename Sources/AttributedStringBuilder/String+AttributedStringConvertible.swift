
import Foundation

extension String: AttributedStringConvertible {

    func attributedString(environment: Environment) -> [NSAttributedString] {
        [NSAttributedString(string: self, attributes: environment.attributes.dictionary)]
    }
}
