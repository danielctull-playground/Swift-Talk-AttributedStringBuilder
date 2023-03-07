
import Markdown
import Foundation

private struct AttributedStringWalker: MarkupWalker {

    let result = NSMutableAttributedString()
    var attributes: Attributes

    func visitText(_ text: Text) -> () {
        result.append(NSAttributedString(string: text.string, attributes: attributes.dictionary))
    }

    mutating func visitStrong(_ strong: Strong) -> () {
        let original = attributes
        defer { attributes = original }
        attributes.bold = true
        descendInto(strong)
    }

    mutating func visitEmphasis(_ emphasis: Emphasis) -> () {
        let original = attributes
        defer { attributes = original }
        attributes.italic = true
        descendInto(emphasis)
    }

    mutating func visitDocument(_ document: Document) -> () {
        for child in document.children {
            if !result.string.isEmpty {
                result.append(.init(string: "\n", attributes: attributes.dictionary))
            }
            visit(child)
        }
    }
}

private struct Markdown: AttributedStringConvertible {
    let content: String

    func attributedString(environment: Environment) -> [NSAttributedString] {
        let document = Document(parsing: content)
        var walker = AttributedStringWalker(attributes: environment.attributes)
        walker.visit(document)
        return [walker.result]
    }
}

extension String {

    func markdown() -> some AttributedStringConvertible {
        Markdown(content: self)
    }
}
