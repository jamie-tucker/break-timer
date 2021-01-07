//
//  GifViewer.swift
//  BreakTimer
//
//  Created by Jamie Tucker on 2021-01-03.
//

import SwiftUI
import WebKit

struct HTMLRenderingWebView: NSViewRepresentable {
  @Binding var htmlString: String
  @Binding var baseURL: URL?

  func makeNSView(context: Context) -> WKWebView {
    let webView = WKWebView()
    return webView
  }

  func updateNSView(_ uiView: WKWebView, context: Context) {
    if self.htmlString != context.coordinator.lastLoadedHTML {
      context.coordinator.lastLoadedHTML = self.htmlString
      uiView.loadHTMLString(self.htmlString, baseURL: self.baseURL)
    }
  }

  func makeCoordinator() -> Coordinator {
    Coordinator(self)
  }

  class Coordinator: NSObject {
    var parent: HTMLRenderingWebView
    var lastLoadedHTML = ""

    init(_ parent: HTMLRenderingWebView) {
      self.parent = parent
    }
  }
}

struct HTMLRenderingWebViewExample: View {
  @State var htmlString = ""

  var body: some View {
    HTMLRenderingWebView(htmlString: self.$htmlString, baseURL: .constant(nil))
      .onAppear {
        var url = AppDelegate.getDocumentsDirectory()
        url.appendPathComponent("Backgrounds")
        // TODO: do {} catch {} remvoe optional try?
        let dirContents = try? FileManager.default.contentsOfDirectory(at: url, includingPropertiesForKeys: nil)
        let imageFiles = dirContents!.filter { $0.pathExtension == "gif" }
        downloadImage(from: imageFiles.randomElement()!)
      }
  }

  func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> Void) {
    URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
  }

  func downloadImage(from url: URL) {
    getData(from: url) { data, _, error in
      guard let data = data, error == nil else {
        return
      }
      DispatchQueue.main.async {
        let imageData = data.base64EncodedString()
        let format = url.pathExtension
          htmlString = "<meta name=\"viewport\" content=\"initial-scale=1.0\" />" +
            """
        <div style='
          position: absolute;
          top: 0;
          left: 0;
          bottom: 0;
          right: 0;
          overflow: hidden;
        '>
          <img src='data:image/\(format);base64,\(imageData)' style='
            position: fixed;
            top: 75%;
            left: 50%;
            min-width: 960px;
            min-height: 540px;
            transform: translate(-50%, -50%);
          '>
        </div>
        """
      }
    }
  }
}
