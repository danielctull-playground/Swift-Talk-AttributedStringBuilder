
@testable import AttributedStringBuilder
import SwiftUI
import XCTest

final class AttributedStringBuilderTests: XCTestCase {

    @MainActor
    func testPDF() throws {

        let data = example.joined(separator: "\n")
            .run(environment: .init(attributes: sampleAttributes))
            .pdf()

        try data.write(to: .desktopDirectory.appendingPathComponent("output.pdf"))
    }
}

let sampleAttributes = Attributes(family: "Times New Roman", size: 30)

@AttributedStringBuilder
var example: some AttributedStringConvertible {
    "Hello, World!"
        .bold()
        .foregroundColor(.red)

    #"""
    This is some markdown with **strong** text.

    Another *paragraph*.
    """#
        .markdown()

    NSImage(systemSymbolName: "hand.wave", accessibilityDescription: nil)!

    Embed(proposedSize: ProposedViewSize(width: 200, height: nil)) {
        HStack {
            Image(systemName: "hand.wave")
            Text("Hello from SwiftUI")
            Color.red.frame(width: 100, height: 50)
        }
    }

    #"""
    static var previews: some View {

        let string = example
            .joined()
            .run(environment: Environment(attributes: sampleAttributes))

        Text(AttributedString(string))
    }
    """#
        .highlightSwift()

    "Another String"
}
