# Introduction

This document outlines the way our team is expected to write their SCSS. Following this document ensures that everyone is writing markup and styling that feels familiar and can be maintained by anyone with little overhead.

## Table of contents

* [Tools & frameworks](#tools--frameworks)
* [Philosophy & structure](#philosophy--structure)

## Tools & frameworks

* [Sass](http://sass-lang.com/) is our preprocessor of choice
* [PostCSS](https://github.com/postcss/postcss) for its [Autoprefixer](https://github.com/postcss/autoprefixer) plugin
* [SCSS-Lint](https://github.com/causes/scss-lint) is our preferred linter for `SCSS`. See our custom linting rules [here](https://github.com/Shopify/markup-and-styling-style-guide/blob/master/.scss-lint.yml))

## Philosophy & structure

We strive to write modular, component driven CSS with a clear separation of concerns, structured so they are reusable and easy to find. In the end, our code should be easy to maintain by anyone – even for new people entering a project.

These guidelines are a summary of our base principles: Our code bases should all be:

* Composed as if written by only one person
* Components first
* Page specific only as a last resort
* Written with nesting (preferably) no deeper than 2 levels

For more specific information on our markup and CSS code styles see our (Markup and Styling Style Guide)[https://github.com/Shopify/markup-and-styling-style-guide].

It is also a good idea to read up on [SMACSS](http://smacss.com/) and [BEM](https://en.bem.info/method/key-concepts/) if you are not already familiar with them.

Continue on to [Building a component →](../building-a-component)
