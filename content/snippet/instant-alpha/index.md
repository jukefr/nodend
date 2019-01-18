+++
title = "Instant Alpha on PNG"
date = 2018-07-15T03:11:01+02:00
description = "using the convert utility provided by imagemagick to remove an image background"
categories = ["optimization"]
tags = ["imagemagick"]
images = [
  "/opengraph.png"
] # overrides the site-wide open graph image
[[resources]]
  src = "images/before.bpg"
  name = "before"
[[resources]]
  src = "images/after.bpg"
  name = "after"
type = "article"

+++
<span></span>
<!--more-->

## Snippet
### Fish
{{< highlight fish "linenos=table" >}}
function instantalpha
	convert $argv[1] -fuzz $argv[2]% -transparent $argv[3] $argv[1].alpha.png
end
{{< /highlight >}}
### Bash
{{< highlight bash "linenos=table">}}
function instantalpha {
    convert "$1" -fuzz "$2"% -transparent "$3" "$1".alpha.png
} 
{{< /highlight >}}

## Usage
{{< highlight fish "linenos=table, hl_lines=4">}}
# file | source png, output will be .alpha.png
# -fuzz distance | colors within this distance are considered equal
# -transparent color | make this color transparent within the image
instantalpha image.png 50 black 
{{< /highlight >}}

## Requirements
Make sure you have {{<link "https://www.imagemagick.org/script/download.php" blank >}}ImageMagick installed {{< /link >}}.

## Add to Fish
Copy and paste the above [snippet](#fish) into your shell. **instantalpha** is now available in your current session.

To make it persistent (save it), use the following Fish function,
{{< highlight fish >}}
funcsave instantalpha
{{< /highlight >}}

## Add to Bash
Add the [function](#bash) to your **.bashrc** or **.bash_profile**.

## Demo
{{< size 50 >}}
    {{< lazy name="before" >}}
{{< /size>}}
We have the classic "hello mac" raster.

{{< size 50 >}}
    {{< lazy name="after" >}}
{{< /size>}}
No more background.
