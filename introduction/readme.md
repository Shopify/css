# Introduction

This document outlines the way our team is expected to write their CSS. Following this document ensures that everyone is writing markup that feels familiar and can be maintained by anyone with little overhead.

We follow a mixture of various methodologies including, but not limited to: SMACSS' separation of concerns, OOCSS' modularity, Topcoat's coding guidelines, BEM naming conventions, and others.


## Table of contents

* [Tools & frameworks](#tools--frameworks)
* [Philosophy & structure](#philosophy--structure)


## Tools & frameworks

* [Sass](http://sass-lang.com/) is our preprocessor of choice
* [PostCSS](https://github.com/postcss/postcss) for its [Autoprefixer](https://github.com/postcss/autoprefixer) plugin
* [SCSS-Lint](https://github.com/causes/scss-lint) is our preferred linter for `SCSS`. See our custom linting rules are found [here](https://github.com/Shopify/markup-and-styling-style-guide/blob/master/.scss-lint.yml))


## Philosophy & structure

We strive to write modular, component driven CSS with a clear separation of concerns, structured so they are reuseable and easy to find. In the end, our code should be easy to maintain by anyone – even for new people entering a project.

These guidelines are a summary of our base principles: Our code bases should all be:

* Composed as if written by only one person
* Components first
* Page specific only as a last resort
* Written with nesting (preferably) no deeper than 2 levels

Our separation of concerns is reflected by our style directory structure as follows:

```
/stylesheets
  /admin
    /areas
    /components
    /foundation
    /global
    print.scss
    style.scss
```

> You may notice the heavy influence of methodologies like [SMACSS](http://smacss.com/) and [OOCSS](http://www.smashingmagazine.com/2011/12/12/an-introduction-to-object-oriented-css-oocss/).
>
> Familiarity with these concepts is crucial! If you are not, then we urge that you at least learn the basics: [Jonathan Snook's "CSS is a Mess"](http://vimeo.com/99877232) and [Andy Hume's "CSS For Grown Ups"](http://lanyrd.com/2012/sxsw-interactive/spmqc/) is a good place to start.

Continue on to [Building a component →](../building-a-component)
