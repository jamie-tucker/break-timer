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
        htmlString = "<meta name=\"viewport\" content=\"initial-scale=1.0\" />" +
          (self.assetAsString() ?? "image loading failed")
      }
  }

  func assetAsString() -> String? {
    let randomValue = Int.random(in: 1...12)
    let asset = NSDataAsset(name: "bg" + String(randomValue))
    if let data = asset?.data {
      let base64string = data.base64EncodedString()
      let format = "gif"
      return
        """
          <div style='
            position: fixed;
            top: -50%;
            left: -50%;
            width: 200%;
            height: 200%;
          '>
            <img src='data:image/\(format);base64,\(base64string)' style='
              position:absolute;
              top:0;
              left:0;
              right: 0;
              bottom: 0;
              margin: auto;
              min-width: 50%;
              min-height: 50%;
            '>
          </div>
        """
    } else {
      return nil
    }
  }
}
