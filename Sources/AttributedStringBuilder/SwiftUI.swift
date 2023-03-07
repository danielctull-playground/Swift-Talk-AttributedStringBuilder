
import AppKit
import SwiftUI

@MainActor
struct Embed<Content: View>: AttributedStringConvertible {

    var proposedSize: ProposedViewSize = .unspecified
    @ViewBuilder let content: Content

    func attributedString(environment: Environment) -> [NSAttributedString] {
        let renderer = ImageRenderer(content: content)
        renderer.proposedSize = proposedSize
        return renderer.nsImage!.attributedString(environment: environment)
    }
}
