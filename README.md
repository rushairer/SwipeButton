# SwipeButton

![GitHub code size in bytes](https://img.shields.io/github/languages/code-size/rushairer/SwipeButton) ![GitHub](https://img.shields.io/github/license/rushairer/SwipeButton) ![GitHub release (latest by date including pre-releases)](https://img.shields.io/github/v/release/rushairer/SwipeButton?include_prereleases) ![GitHub tag (latest by date)](https://img.shields.io/github/v/tag/rushairer/SwipeButton.svg)

A swipe button for SwiftUI if you do not using `<List>`.

### Declaration

```swift
SwipeButtonModifier(leftButtonLabel: (() -> SwipeActionContent)? = nil,
                    leftButtonColor: Color = .green,
                    leftButtonAction: (() -> Void)? = nil,
                    rightButtonLabel: (() -> SwipeActionContent)? = nil,
                    rightButtonColor: Color = .red,
                    rightButtonAction: (() -> Void)? = nil,
                    style: SwipeButtonStyle = .wave)
            
public enum SwipeButtonStyle {
    case wave
    case rectangle
}
```

### Usage

```swift
struct SwipeButtonView_Previews: PreviewProvider {
    static var previews: some View {
        Text("Swipe Button")
            .foregroundColor(.white)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.pink)
            .modifier(SwipeButtonModifier(leftButtonLabel: {
                Image(systemName: "heart")
                    .font(.system(size: 16, weight: .bold))
                    .foregroundColor(.white)
                    .opacity(1)
            },
            leftButtonAction: {
                
            },
            rightButtonLabel: {
                Image(systemName: "xmark")
                    .font(.system(size: 16, weight: .bold))
                    .foregroundColor(.white)
                    .opacity(1)
            },
            rightButtonAction: {
                
            },
            style: .rectangle))
            .frame(height: 150)
            .preferredColorScheme(.dark)
        
    }
}
```

### Screenshot

<img src="https://github.com/rushairer/SwipeButton/raw/screenshot/screenshot.gif"/>

### History

[History](./HISTORY.md)


### LICENSE

[The MIT License (MIT)](./LICENSE)