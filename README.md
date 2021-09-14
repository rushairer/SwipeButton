# SwipeButton

A swipe button for SwiftUI.

## Usage


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

## Screenshot

<img src="https://github.com/rushairer/SwipeButton/raw/screenshot/screenshot.gif"/>
