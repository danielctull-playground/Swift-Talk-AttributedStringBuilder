
import Foundation

@resultBuilder
struct AttributedStringBuilder {

    static func buildBlock(_ components: AttributedStringConvertible...) -> some AttributedStringConvertible {
        components
    }

    static func buildOptional(_ component: AttributedStringConvertible?) -> some AttributedStringConvertible {
        component.map { [$0] } ?? []
    }
}

extension Array: AttributedStringConvertible where Element == AttributedStringConvertible {

    func attributedString(environment: Environment) -> [NSAttributedString] {
        flatMap { $0.attributedString(environment: environment) }
    }
}

#if DEBUG

@AttributedStringBuilder
var example: some AttributedStringConvertible {
    "Hello, World!"
        .bold()
    "Another String"
}

let sampleAttributes = Attributes(family: "Times New Roman", size: 30)

import SwiftUI

struct DebugPreview: PreviewProvider {
    static var previews: some View {

        let string = example
            .joined()
            .run(environment: Environment(attributes: sampleAttributes))

        Text(AttributedString(string))
    }
}
#endif
