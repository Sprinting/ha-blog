-- hello.hs

main :: IO ()
main = putStrLn (render myhtml)

myhtml :: Html
myhtml =
  html_
    "My title"
    ( append_
      (h1_ "Heading")
      ( append_
        (p_ "Paragraph #1")
        (p_ "Paragraph #2")
      )
    )

newtype Html = 
  Html String
newtype HtmlElement = 
  HtmlElement String
type Title = 
  String

append_ :: HtmlElement -> HtmlElement -> HtmlElement
append_ (HtmlElement a) (HtmlElement b) =
  HtmlElement (a <> b)

render :: Html -> String
render (Html h) = 
  h

getHtmlElementString :: HtmlElement -> String
getHtmlElementString content =
  case content of
    HtmlElement str -> str

html_ :: Title -> HtmlElement -> Html
html_ title content = 
  Html
    ( el "html"
      (  el "head" (el "title" title )
            <> el "body" (getHtmlElementString content)
      )
    )

p_ :: String -> HtmlElement
p_ = HtmlElement . el "p"

h1_ :: String -> HtmlElement
h1_ = HtmlElement . el "h1"

el :: String -> String -> String
el tag content =
  "<" <> tag <> ">" <> content <> "</" <> tag <> ">"