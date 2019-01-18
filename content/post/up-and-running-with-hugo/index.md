+++
title = "Up and Running with Hugo"
date = 2018-07-15T03:11:01+02:00
description = "From A to Z for my new blog setup."
categories = ["fullstack"]
tags = ["hugo"]
images = [
  "/post/up-and-running-with-hugo/images/latency.png"
] # overrides the site-wide open graph image
[[resources]]
  src = "images/latency.bpg"
  name = "latency"
+++
<span></span>
<!--more-->
# Formula
1. Hugo
2. Github Pages
3. Github Actions

# Result
Total time spent on setup : **4-6 hours**

Total time spent on benchmarking*: **100+ hours**

_by benchmarking I mean hopping framework (no matter the language) every other day because I didn't "feel like it"_

{{< lazy name="latency" caption="latency comparison between different countries" alt="screenshot of apex.sh latency test, lowest is 6ms for Virginia, highest at 330 for Mumbai" title="latency.apex.sh screenshot" >}}

That's 6 ms without any kind of CDN (that I know of at least, maybe Github Pages has one but the only thing I see in my request headers is `x-cache: MISS`)
