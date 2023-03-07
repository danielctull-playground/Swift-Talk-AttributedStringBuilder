
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
        .foregroundColor(.red)

    NSImage(systemSymbolName: "hand.wave", accessibilityDescription: nil)!

    Embed {
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

let sampleAttributes = Attributes(family: "Times New Roman", size: 30)

import SwiftUI

struct TextView: NSViewRepresentable {

    let attributedString: NSAttributedString

    func makeNSView(context: Context) -> NSTextView {
        let view = NSTextView()
        view.isEditable = false
        view.textContainer!.lineFragmentPadding = 0
        view.textContainer!.widthTracksTextView = false
        return view
    }

    func updateNSView(_ view: NSTextView, context: Context) {
        view.textStorage?.setAttributedString(attributedString)
    }

    func sizeThatFits(_ proposal: ProposedViewSize, view: NSTextView, context: Context) -> CGSize? {
        let container = view.textContainer!
        container.size = proposal.replacingUnspecifiedDimensions(by: .zero)
        view.layoutManager?.ensureLayout(for: container)
        return view.layoutManager?.usedRect(for: container).size
    }
}

struct DebugPreview: PreviewProvider {
    static var previews: some View {

        let string = example
            .joined()
            .run(environment: Environment(attributes: sampleAttributes))

        TextView(attributedString: string)
            .previewLayout(.sizeThatFits)
    }
}
#endif
