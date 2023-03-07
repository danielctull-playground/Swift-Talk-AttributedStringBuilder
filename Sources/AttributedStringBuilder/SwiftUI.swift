
import AppKit
import SwiftUI

@MainActor
struct Embed<Content: View>: AttributedStringConvertible {

    var proposedSize: ProposedViewSize = .unspecified
    @ViewBuilder let content: Content

    func attributedString(environment: Environment) -> [NSAttributedString] {
        let renderer = ImageRenderer(content: content)
        renderer.proposedSize = proposedSize

        let data = NSMutableData()

        renderer.render { size, renderer in

            var mediaBox = CGRect(origin: .zero, size: size)

            guard
                let consumer = CGDataConsumer(data: data),
                let pdfContext = CGContext(consumer: consumer, mediaBox: &mediaBox, nil)
            else {
                return
            }

            pdfContext.beginPDFPage(nil)

            pdfContext.translateBy(
                x: mediaBox.size.width / 2 - size.width / 2,
                y: mediaBox.size.height / 2 - size.height / 2)

            renderer(pdfContext)
            pdfContext.endPDFPage()
            pdfContext.closePDF()
        }

        return NSImage(data: data as Data)!.attributedString(environment: environment)
    }
}
