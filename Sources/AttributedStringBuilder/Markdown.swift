
import Markdown
import Foundation

protocol Stylesheet {
    func strong(attributes: inout Attributes)
    func emphasis(attributes: inout Attributes)
}

extension Stylesheet {

    func strong(attributes: inout Attributes) {
        attributes.bold = true
    }

    func emphasis(attributes: inout Attributes) {
        attributes.italic = true
    }
}

struct DefaultStylesheet: Stylesheet {}

private struct AttributedStringWalker: MarkupWalker {

    let result = NSMutableAttributedString()
    var attributes: Attributes
    var stylesheet: any Stylesheet = DefaultStylesheet()

    func visitText(_ text: Text) -> () {
        result.append(NSAttributedString(string: text.string, attributes: attributes.dictionary))
    }

    mutating func visitStrong(_ strong: Strong) -> () {
        let original = attributes
        defer { attributes = original }
        stylesheet.strong(attributes: &attributes)
        descendInto(strong)
    }

    mutating func visitEmphasis(_ emphasis: Emphasis) -> () {
        let original = attributes
        defer { attributes = original }
        stylesheet.emphasis(attributes: &attributes)
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
