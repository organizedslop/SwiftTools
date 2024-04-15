# Swift Tools
v0.1
by Blake Davis / organizedSlop

A collection of Swift type extensions, SwiftUI views, and other utilities.


---

## Type Extensions

### String Extensions

#### alphanumeric(keepWhiteSpace:)
Returns the string stripped of all non-alphanumeric characters.

```
public func alphanumeric(keepWhiteSpace: Bool = false) -> String
```

#### handleHTML()
Returns the string stripped of all HTML entities (both encoded and decoded).

```
public func handleHTML() -> String
```

#### decodeHTML()
Returns the string with all HTML entities decoded.
(E.g. “\&lt;p\&gt;Example\&lt;/p\&gt;” becomes “\<p>Example\</p>”.)

```
func decodeHTML() -> String
```

#### stripHTML()
Returns the string stripped of all HTML entities.

```
func stripHTML() -> String
```

#### toBool()
Returns the equivalent optional boolean value for the string, or nil if not applicable.

```
func toBool() -> Bool?
```

#### emptyIfNil(_:)
Returns the wrapped value of an optional string, or an empty string if the input is nil.

```
static func emptyIfNil(_ optionalString: String?) -> String
```

#### width(usingFont:)
Returns the calculated width (in points) of a string rendered with a given font.

```
func width(usingFont font: UIFont) -> CGFloat
```

#### height(usingFont:)
Returns the calculated height (in points) of a string rendered with a given font.

```
func height(usingFont font: UIFont) -> CGFloat
```

#### size(usingFont:)
Returns the calculated width and height (in points) of a string rendered with a given font.

```
func size(usingFont font: UIFont) -> CGSize
```


---

## Views

#### MarqueeText
A view that cycles through a string of text.

```
struct MarqueeText: View
```
```
init (_ text: String)
```

#### AttributedText
A view that renders text with HTML formatting.

```
AttributedText("""
    <h1>Attributed Text</h1>
    <h2>Convert HTML tags</h2>
    <h3>Heading3</h3>
    <p>This is a paragraph.</p>
    <b>Bold</b>
    <i>Italics</i>
    <u>Underline</u>
    <s>Strikethrough</s>
    <sup>Superscript</sup>
    <sub>Subscript</sub>
""")
```
```
init(_ htmlString: String, tags: Dictionary<String, (Text) -> (Text)>? = nil)
```

#### DynamicStack
A view that arranges its subviews in a horizontal or vertical line, depending on its orientation.

```
struct DynamicStack<Content: View>: View
```
```
init(_ orientation:        Axis.Set,
    horizontalAlignment:  HorizontalAlignment = .center,
    verticalAlignment:    VerticalAlignment   = .center,
    spacing:              CGFloat?            = nil,
    isShowingDividers:    Bool                = false,
    @ViewBuilder content: @escaping () -> Content)
```

