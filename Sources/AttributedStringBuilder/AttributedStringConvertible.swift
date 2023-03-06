
import Foundation

protocol AttributedStringConvertible {
    func attributedString(environment: Environment) -> [NSAttributedString]
}

extension AttributedStringConvertible {

    func run(environment: Environment) -> NSAttributedString {
        Joined(content: self, separator: "")
            .single(environment: environment)
    }
}
