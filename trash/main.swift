//  Copyright © 2020 Erica Sadun. All rights reserved.

import Foundation
import Cocoa

func usage() {
    print("""
    Usage: trash <files...>
    Move files to your Macintosh trash can.

    -h/--help: This message
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
    do {
        let standardPath = URL(fileURLWithPath: path).standardizedFileURL.path
        let process = Process()
        let commandURL = URL(fileURLWithPath: "/usr/bin/osascript")
        if #available(macOS 10.13, *) { process.executableURL = commandURL }
        else { process.launchPath = commandURL.path }
        process.arguments = ["-e", #"tell app "Finder" to delete POSIX file "\#(standardPath)""#]
        let output = Pipe(); process.standardOutput = output
        let error = Pipe(); process.standardError = error
        if #available(macOS 10.13, *) {
            try process.run()
        } else {
            process.launch()
        }
        process.waitUntilExit()
    } catch {
        print("Error: \(error.localizedDescription)")
    }
}
