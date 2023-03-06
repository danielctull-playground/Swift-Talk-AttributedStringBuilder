
import Foundation

@resultBuilder
struct AttributedStringBuilder {

    static func buildBlock(_ components: AttributedStringConvertible...) -> some AttributedStringConvertible {
        Build { environment in
            let result = NSMutableAttributedString()
            for component in components {
                let string = component.attributedString(environment: environment)
                result.append(string)
            }
            return result
        }
    }
}

struct Build: AttributedStringConvertible {

    let content: (Environment) -> NSAttributedString

    func attributedString(environment: Environment) -> NSAttributedString {
        content(environment)
    }
}

#if DEBUG

@AttributedStringBuilder
var example: AttributedStringConvertible {
    "Hello, World!"
    "Another String"
}

import SwiftUI

struct DebugPreview: PreviewProvider {
    static var previews: some View {
        Text(AttributedString(example.attributedString(environment: .init())))
    }
}
#endif
