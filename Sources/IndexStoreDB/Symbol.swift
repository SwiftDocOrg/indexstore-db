//===----------------------------------------------------------------------===//
//
// This source file is part of the Swift.org open source project
//
// Copyright (c) 2014 - 2019 Apple Inc. and the Swift project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See https://swift.org/LICENSE.txt for license information
// See https://swift.org/CONTRIBUTORS.txt for the list of Swift project authors
//
//===----------------------------------------------------------------------===//

import CIndexStoreDB

public enum IndexSymbolKind: Hashable {
  case unknown
  case module
  case namespace
  case namespaceAlias
  case macro
  case `enum`
  case `struct`
  case `class`
  case `protocol`
  case `extension`
  case union
  case `typealias`
  case function
  case variable
  case field
  case enumConstant
  case instanceMethod
  case classMethod
  case staticMethod
  case instanceProperty
  case classProperty
  case staticProperty
  case constructor
  case destructor
  case conversionFunction
  case parameter
  case using
  case commentTag
}

public struct Symbol: Equatable {

  public var usr: String
  public var name: String
  public var kind: IndexSymbolKind

  public init(usr: String, name: String, kind: IndexSymbolKind) {
    self.usr = usr
    self.name = name
    self.kind = kind
  }
}

extension Symbol: Comparable {
  public static func <(a: Symbol, b: Symbol) -> Bool {
    return (a.usr, a.name) < (b.usr, b.name)
  }
}

extension Symbol: CustomStringConvertible {
  public var description: String {
    "\(name) | \(kind) | \(usr)"
  }
}

extension Symbol {

  /// Returns a copy of the symbol with the new name, usr, and/or kind.
  public func with(
    name: String? = nil,
    usr: String? = nil,
    kind: IndexSymbolKind? = nil) -> Symbol
  {
    return Symbol(usr: usr ?? self.usr, name: name ?? self.name, kind: kind ?? self.kind)
  }

  /// Returns a SymbolOccurrence with the given location and roles.
  public func at(_ location: SymbolLocation, roles: SymbolRole) -> SymbolOccurrence {
    return SymbolOccurrence(symbol: self, location: location, roles: roles)
  }
}

// MARK: CIndexStoreDB conversions

extension Symbol {

  /// Note: `value` is expected to be passed +1.
  init(_ value: indexstoredb_symbol_t) {
    self.init(
      usr: String(cString: indexstoredb_symbol_usr(value)),
      name: String(cString: indexstoredb_symbol_name(value)),
      kind: IndexSymbolKind(rawValue: indexstoredb_symbol_kind(value)))
  }
}

extension IndexSymbolKind: RawRepresentable {
  public init(rawValue: indexstoredb_symbol_kind_t) {
    switch rawValue {
    case INDEXSTOREDB_SYMBOL_KIND_UNKNOWN:
      self = .unknown
    case INDEXSTOREDB_SYMBOL_KIND_MODULE:
      self = .module
    case INDEXSTOREDB_SYMBOL_KIND_NAMESPACE:
      self = .namespace
    case INDEXSTOREDB_SYMBOL_KIND_NAMESPACEALIAS:
      self = .namespaceAlias
    case INDEXSTOREDB_SYMBOL_KIND_MACRO:
      self = .macro
    case INDEXSTOREDB_SYMBOL_KIND_ENUM:
      self = .enum
    case INDEXSTOREDB_SYMBOL_KIND_STRUCT:
      self = .struct
    case INDEXSTOREDB_SYMBOL_KIND_CLASS:
      self = .class
    case INDEXSTOREDB_SYMBOL_KIND_PROTOCOL:
      self = .protocol
    case INDEXSTOREDB_SYMBOL_KIND_EXTENSION:
      self = .extension
    case INDEXSTOREDB_SYMBOL_KIND_UNION:
      self = .union
    case INDEXSTOREDB_SYMBOL_KIND_TYPEALIAS:
      self = .typealias
    case INDEXSTOREDB_SYMBOL_KIND_FUNCTION:
      self = .function
    case INDEXSTOREDB_SYMBOL_KIND_VARIABLE:
      self = .variable
    case INDEXSTOREDB_SYMBOL_KIND_FIELD:
      self = .field
    case INDEXSTOREDB_SYMBOL_KIND_ENUMCONSTANT:
      self = .enumConstant
    case INDEXSTOREDB_SYMBOL_KIND_INSTANCEMETHOD:
      self = .instanceMethod
    case INDEXSTOREDB_SYMBOL_KIND_CLASSMETHOD:
      self = .classMethod
    case INDEXSTOREDB_SYMBOL_KIND_STATICMETHOD:
      self = .staticMethod
    case INDEXSTOREDB_SYMBOL_KIND_INSTANCEPROPERTY:
      self = .instanceProperty
    case INDEXSTOREDB_SYMBOL_KIND_CLASSPROPERTY:
      self = .classProperty
    case INDEXSTOREDB_SYMBOL_KIND_STATICPROPERTY:
      self = .staticProperty
    case INDEXSTOREDB_SYMBOL_KIND_CONSTRUCTOR:
      self = .constructor
    case INDEXSTOREDB_SYMBOL_KIND_DESTRUCTOR:
      self = .destructor
    case INDEXSTOREDB_SYMBOL_KIND_CONVERSIONFUNCTION:
      self = .conversionFunction
    case INDEXSTOREDB_SYMBOL_KIND_PARAMETER:
      self = .parameter
    case INDEXSTOREDB_SYMBOL_KIND_USING:
      self = .using
    case INDEXSTOREDB_SYMBOL_KIND_COMMENTTAG:
      self = .commentTag
    default:
      self = .unknown
    }
  }

    public var rawValue: indexstoredb_symbol_kind_t {
        switch self {

        case .unknown:
            return INDEXSTOREDB_SYMBOL_KIND_UNKNOWN
        case .module:
            return INDEXSTOREDB_SYMBOL_KIND_MODULE
        case .namespace:
            return INDEXSTOREDB_SYMBOL_KIND_NAMESPACE
        case .namespaceAlias:
            return INDEXSTOREDB_SYMBOL_KIND_NAMESPACEALIAS
        case .macro:
            return INDEXSTOREDB_SYMBOL_KIND_MACRO
        case .enum:
            return INDEXSTOREDB_SYMBOL_KIND_ENUM
        case .struct:
            return INDEXSTOREDB_SYMBOL_KIND_STRUCT
        case .class:
            return INDEXSTOREDB_SYMBOL_KIND_CLASS
        case .protocol:
            return INDEXSTOREDB_SYMBOL_KIND_PROTOCOL
        case .extension:
            return INDEXSTOREDB_SYMBOL_KIND_EXTENSION
        case .union:
            return INDEXSTOREDB_SYMBOL_KIND_UNION
        case .typealias:
            return INDEXSTOREDB_SYMBOL_KIND_TYPEALIAS
        case .function:
            return INDEXSTOREDB_SYMBOL_KIND_FUNCTION
        case .variable:
            return INDEXSTOREDB_SYMBOL_KIND_VARIABLE
        case .field:
            return INDEXSTOREDB_SYMBOL_KIND_FIELD
        case .enumConstant:
            return INDEXSTOREDB_SYMBOL_KIND_ENUMCONSTANT
        case .instanceMethod:
            return INDEXSTOREDB_SYMBOL_KIND_INSTANCEMETHOD
        case .classMethod:
            return INDEXSTOREDB_SYMBOL_KIND_CLASSMETHOD
        case .staticMethod:
            return INDEXSTOREDB_SYMBOL_KIND_STATICMETHOD
        case .instanceProperty:
            return INDEXSTOREDB_SYMBOL_KIND_INSTANCEPROPERTY
        case .classProperty:
            return INDEXSTOREDB_SYMBOL_KIND_CLASSPROPERTY
        case .staticProperty:
            return INDEXSTOREDB_SYMBOL_KIND_STATICPROPERTY
        case .constructor:
            return INDEXSTOREDB_SYMBOL_KIND_CONSTRUCTOR
        case .destructor:
            return INDEXSTOREDB_SYMBOL_KIND_DESTRUCTOR
        case .conversionFunction:
            return INDEXSTOREDB_SYMBOL_KIND_CONVERSIONFUNCTION
        case .parameter:
            return INDEXSTOREDB_SYMBOL_KIND_PARAMETER
        case .using:
            return INDEXSTOREDB_SYMBOL_KIND_USING
        case .commentTag:
            return INDEXSTOREDB_SYMBOL_KIND_COMMENTTAG
        }
    }
}
