//
//  LogManager.swift
//  MovieDbDemo
//
//  Created by Erdi Tunçalp on 19.08.2021.
//  Copyright © 2021 Erdi Tunçalp. All rights reserved.
//

import Foundation

typealias log = LogManager

public class LogManager {

    public static let isLoggingEnabled = true

    class func print(_ object: Any) {
        #if DEBUG
        Swift.print(object)
        #endif
    }

    public class func verbose(_ object: Any, filename: String = #file, line: Int = #line, column: Int = #column, funcName: String = #function) {
        logln(.verbose, object, filename: filename, line: line, column: column, funcName: funcName)
    }

    public class func debug(_ object: Any, filename: String = #file, line: Int = #line, column: Int = #column, funcName: String = #function) {
        logln(.debug, object, filename: filename, line: line, column: column, funcName: funcName)
    }

    public class func info(_ object: Any, filename: String = #file, line: Int = #line, column: Int = #column, funcName: String = #function) {
        logln(.info, object, filename: filename, line: line, column: column, funcName: funcName)
    }

    public class func warning(_ object: Any, filename: String = #file, line: Int = #line, column: Int = #column, funcName: String = #function) {
        logln(.warning, object, filename: filename, line: line, column: column, funcName: funcName)
    }

    public class func error(_ object: Any, filename: String = #file, line: Int = #line, column: Int = #column, funcName: String = #function) {
        logln(.error, object, filename: filename, line: line, column: column, funcName: funcName)
    }

    private class func logln(_ level: Level, _ object: Any, filename: String = #file, line: Int = #line, column: Int = #column, funcName: String = #function) {
        guard isLoggingEnabled else { return }
        self.print("\(Date().string("HH:mm:ss.SSS")!) " +
                    "\(level.icon) " +
                    "\(level.rawValue) " +
                    "\(sourceFileName(filePath: filename)).\(funcName):\(line) -> " +
                    "\(object)")
    }

    private class func sourceFileName(filePath: String) -> String {
        let components = filePath.components(separatedBy: "/")
        return (components.last as NSString?)?.deletingPathExtension ?? ""
    }

    enum Level: String {
        case verbose = "VERBOSE"
        case debug = "DEBUG"
        case info = "INFO"
        case warning = "WARNING"
        case error = "ERROR"

        var icon: String {
            switch self {
            case .verbose: return "💜"
            case .debug: return "💚"
            case .info: return "💙"
            case .warning: return "💛"
            case .error: return "❤️"
            }
        }
    }

}

extension Date {

    func string(_ format: String = "dd.MM.yyyy") -> String? {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        formatter.locale = Locale.current
        return formatter.string(from: self)
    }

}
