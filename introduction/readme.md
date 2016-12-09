# Introduction

This document outlines the concepts required to write Sass in our design system. Following this document ensures that everyone is writing markup and styling that feels familiar and can be maintained by anyone with little overhead.

## Table of contents

* [Tools and frameworks](#tools-and-frameworks)
* [Philosophy and structure](#philosophy-and-structure)

## Tools and frameworks

* [Sass](http://sass-lang.com/) is our preprocessor of choice
* [PostCSS](https://github.com/postcss/postcss) for its [Autoprefixer](https://github.com/postcss/autoprefixer) plugin
* [SCSS-Lint](https://github.com/causes/scss-lint) is our preferred linter for `SCSS`. See our custom [linting rules](https://github.com/Shopify/css/blob/master/.scss-lint.yml) and plugins [linting rules](https://github.com/Shopify/css/blob/master/scss-lint-plugins)
* [SassDoc](https://github.com/SassDoc/) is our preferred form of documentation

## Philosophy and structure

We strive to write modular, component driven CSS that is reusable and has a clear separation of concerns. We want an accessible codebase that makes it easy for both newcomers and old-hands to understand, navigate, and change features.

Two of the key things to keep in mind when developing are:

1. Reusable components first
2. Page specific only as a last resort

Continue on to [Building a component →](../building-a-component)
