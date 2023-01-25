import System.Random
import Text.Printf

width :: Int
width = 1920

height :: Int
height = 1080

getSize :: IO Int
getSize = do
    let size = min width height `div` 5
    return size
  
----

randomBetween :: Int -> Int -> IO Int
randomBetween low high = getStdRandom (randomR (low, high))

svgBegin :: Float -> Float -> String
svgBegin w h = printf "<svg width='%.2f' height='%.2f' xmlns='http://www.w3.org/2000/svg'>\n" w h 

svgEnd :: String
svgEnd = "</svg>"

svgCircle :: Int -> Int -> Int -> String -> String 
svgCircle x y r style =
    printf "<circle cx='%d' cy='%d' r='%d' fill='%s' />\n" x y r style

svgRectangle :: Int -> Int -> Int -> Int -> String -> String
svgRectangle x y w h color = printf "<rect x='%d' y='%d' width='%d' height='%d' fill='%s' />\n" x y w h color

svgLine :: Int -> Int -> Int -> Int -> String -> String
svgLine x1 y1 x2 y2 color = printf "<line x1='%d' y1='%d' x2='%d' y2='%d' style='stroke:%s;stroke-width:2' />\n" x1 y1 x2 y2 color

randomColor :: IO String
randomColor = do
    r <- randomBetween 0 255
    g <- randomBetween 0 255
    b <- randomBetween 0 255
    return $ "rgb(" ++ (show r) ++ ", " ++ (show g) ++ ", " ++ (show b) ++ ")"

randomCircle :: IO String
randomCircle = do
    size <- getSize
    x <- randomBetween 0 width
    y <- randomBetween 0 height
    r <- randomBetween 1 size
    color <- randomColor
    return $ svgCircle x y r color

randomRectangle :: IO String
randomRectangle = do
    size <- getSize
    x <- randomBetween 0 width
    y <- randomBetween 0 height
    w <- randomBetween 1 size
    h <- randomBetween 1 size
    color <- randomColor
    return $ svgRectangle x y w h color

randomLine :: IO String
randomLine = do
    x1 <- randomBetween 0 width
    y1 <- randomBetween 0 height
    x2 <- randomBetween 0 width
    y2 <- randomBetween 0 height
    color <- randomColor
    return $ svgLine x1 y1 x2 y2 color

createSVG :: Int -> Int -> Int -> IO String
createSVG nCircles nRectangles nLines = do
    circles <- sequence (replicate nCircles randomCircle)
    rectangles <- sequence (replicate nRectangles randomRectangle)
    lines <- sequence (replicate nLines randomLine)
    return $ svgBegin (fromIntegral width) (fromIntegral height) ++ (concat circles) ++ (concat rectangles) ++ (concat lines) ++ svgEnd

main :: IO ()
main = do
    nCircles <- randomBetween 1 333
    nRectangles <- randomBetween 1 333
    nLines <- randomBetween 1 333
    svg <- createSVG nCircles nRectangles nLines
    writeFile "output.svg" svg