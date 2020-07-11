//  Copyright © 2020 Erica Sadun. All rights reserved.

import Foundation

func usage() {
    print("""
    Usage: trash <files...>
    Move files to your Macintosh trash can.
    """)
}

func exit(because reason: String) -> Never {
    print("Error: \(reason)\n") // extra CR
    usage()
    exit(-1)
}

guard CommandLine.argc > 1
else { exit(because: "No files to process") }

var arguments = CommandLine.arguments.dropFirst()
let idx = arguments.partition(by: { $0.hasPrefix("-") })
let (paths, prefixed) = (arguments[..<idx], arguments[idx...])

guard prefixed.filter({ $0.hasPrefix("-h") || $0.hasPrefix("--h") }).isEmpty
else { usage(); exit(0) }

for path in paths {
    let url = URL(fileURLWithPath: path)
    guard FileManager.default.fileExists(atPath: url.path)
    else { print("Skipping: \(path) does not exist"); continue }
    do {
        try FileManager.default.trashItem(at: url, resultingItemURL: nil)
    } catch {
        print("Unable to remove \(path). \(error.localizedDescription)")
    }
}
