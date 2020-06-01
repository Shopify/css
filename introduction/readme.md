# Introduction

This document outlines the concepts required to write CSS at Shopify. We have a large development team, but our code shouldn't reflect that! In a perfect world, it should look like 1 crafter writes all our code. In a realistic world, using this document will help ensure that writing and reading CSS at Shopify feels consistent and familiar regardless of which team you are on.

## In this section

* [Tools and frameworks](#tools-and-frameworks)
* [Philosophy and structure](#philosophy-and-structure)

## Tools and frameworks

* Preprocessor: [Sass](http://sass-lang.com/)
* Autoprefixer: [Autoprefixer](https://github.com/postcss/autoprefixer)
* Linter: [stylelint](https://github.com/stylelint/stylelint) (1)
* Documentation: [SassDoc](https://github.com/SassDoc/sassdoc) (2)

(1) See our [linting rules here](https://github.com/Shopify/web-foundation/tree/master/packages/stylelint-plugin).
(2) Used for our Polaris documentation.

## Philosophy

We strive to write readable, reuseable CSS with clear separation of concerns. Like the UIs we are building, our code must be accessible to all crafters, no matter what their experience level.

Key things to keep in mind when developing are:

1. Keep it reuseable: Build with and contribute to [Polaris](https://github.com/Shopify/polaris-react) if at all possible, otherwise, [create and share your own experimental pattern](https://docs.google.com/document/d/1p4mEiNQi0zPrcHWyGkTvbVQIuD5M4DjNky30M3z-YKM/edit). One-off or project-specific patterns should only be considered when your solution cannot be achieved by code and components that already exist.
1. Keep it forward-thinking: If pre-existing patterns don't offer the best user experience, update them! We need crafters to contribute back to the system to keep it moving forward.
2. Keep it accessible: Comment and document your code, so that other crafters understand why and how.

Back to [Table of contents](TOC)