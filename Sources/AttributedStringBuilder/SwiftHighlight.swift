
import Foundation
import SwiftHighlighting

extension String {

    func highlightSwift() -> NSAttributedString {
        .highlightSwift(self, stylesheet: .xcodeDefault)
    }
}


extension NSAttributedString: AttributedStringConvertible {

    func attributedString(environment: Environment) -> [NSAttributedString] {
        [self]
    }
}
