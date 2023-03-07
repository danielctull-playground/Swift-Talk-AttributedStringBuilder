
import AppKit
import SwiftUI

@MainActor
struct Embed<Content: View>: AttributedStringConvertible {
    
    @ViewBuilder let content: Content

    func attributedString(environment: Environment) -> [NSAttributedString] {
        let renderer = ImageRenderer(content: content)
        return renderer.nsImage!.attributedString(environment: environment)
    }
}
