// Copyright 2023 Itty Bitty Apps Pty Ltd. See LICENSE file.

import SwiftUI

public extension Constructor {
  var color: Color {
    Color(colorName, bundle: .module)
  }
}
