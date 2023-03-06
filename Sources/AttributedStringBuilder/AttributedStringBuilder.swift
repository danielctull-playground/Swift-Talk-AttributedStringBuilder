
import Foundation

@resultBuilder
struct AttributedStringBuilder {

    static func buildBlock(_ components: AttributedStringConvertible...) -> some AttributedStringConvertible {
        Build { environment in
            components.flatMap { $0.attributedString(environment: environment) }
        }
    }

    static func buildOptional(_ component: AttributedStringConvertible?) -> some AttributedStringConvertible {
        Build { environment in
            component?.attributedString(environment: environment) ?? []
        }
    }
}

struct Build: AttributedStringConvertible {

    let content: (Environment) -> [NSAttributedString]

    func attributedString(environment: Environment) -> [NSAttributedString] {
        content(environment)
    }
}

#if DEBUG

@AttributedStringBuilder
var example: some AttributedStringConvertible {
    "Hello, World!"
    "Another String"
}

import SwiftUI

struct DebugPreview: PreviewProvider {
    static var previews: some View {

        let string = Lines {
            example
        }.single(environment: .init())

        Text(AttributedString(string))
    }
}
#endif
