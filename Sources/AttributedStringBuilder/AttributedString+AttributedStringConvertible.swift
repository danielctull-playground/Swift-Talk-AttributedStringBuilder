
import Foundation

extension AttributedString: AttributedStringConvertible {

    func attributedString(environment: Environment) -> [NSAttributedString] {
        [NSAttributedString(self)]
    }
}
