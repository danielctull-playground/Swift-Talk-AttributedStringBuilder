
import Foundation

protocol AttributedStringConvertible {

    @MainActor
    func attributedString(environment: Environment) -> [NSAttributedString]
}

extension AttributedStringConvertible {

    @MainActor
    func run(environment: Environment) -> NSAttributedString {
        Joined(content: self, separator: "")
            .single(environment: environment)
    }
}
