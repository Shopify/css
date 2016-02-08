# Sass (SCSS) best practices

As mentioned earlier, we use [Sass](http://sass-lang.com/) using the `SCSS` syntax and [Autoprefixer](https://github.com/ai/autoprefixer) to build our CSS. We have some guidelines for this.


## Table of contents

* [Nest only when necessary](#nest-only-when-necessary)
    * [Beware nested comma separated selectors](#beware-nested-comma-separated-selectors)
* [Global vs. local variables/mixins](#global-vs-local-variablesmixins)
* [`@extends`](#extends)
* [Filename naming convention](#filename-naming-convention)
* [Commenting best practice](#commenting-best-practice)
    * [Common things to comment](#common-things-to-comment)
* [Variable naming convention](#variable-naming-convention)
    * [Exceptions](#exceptions)


## Nest only when necessary

Limit nesting as much as possible. Assess every single level of nesting that you use. This prevents increasing specificity and impacting performance. Before nesting, ask yourself "will this work without nesting?" Just because you *can* nest does not mean you should, or that it makes the code maintainable (Hint: it doesn't).

Try not to nest more than 2 levels deep.


### Beware nested comma separated selectors

[This example](http://sassmeister.com/gist/891f2002ef23bf8e4788) demonstrates a real-world scenario that happens when developers recklessly author code to match the markup too closely.

It is a bad habit to nest every selector as it appears in the markup. CSS is *not* HTML, so we don't treat it as such. We must be mindful of the selectors we are compiling.

Using the [sassmesiter.com](http://sassmeister.com/gist/891f2002ef23bf8e4788) example above, let's make some adjustments to clean this up:

* [Nest less](http://sassmeister.com/gist/12ca39f4fa72cafc5a75)
* [Don't nest at all](http://sassmeister.com/gist/67f8fd11522e1d4692a9) and use template classes
* or, [don't nest at all](http://sassmeister.com/gist/036b0a161a47f321b776) and use component classes

The approach you use depends on many factors.

* How much control do you have over the markup?
* How reusable are the styles that you are writing?
* Are there inline or @media styles that you must account for?

Chances are, you will be using a combination of these strategies that work best based on the state of your project and its markup.


## Global vs. local variables/mixins

Any `$variable` that is used in more than one file should be placed in the `foundation/_variables.scss` file. All other variables should be placed at the top of the file in which they are used.

Any `@mixin` that is used in more than one file should be placed in the `foundation/_mixins.scss` folder.


## `@extends`

Don't use them. When SASS compiles to CSS, any selectors that share an `@extend` will be grouped together – which could introduce conflicts in our production code. Another big concern is that `@extend` will not carry over into `@media` queries. Because of these limitations, we prefer to stick with `@include` mixins instead of `@extend` classes or placeholders.


## Filename naming convention

The file naming convention should be identical to the class naming convention as described below, but with the following difference:

Sass files (technical scss files) should be a Sass partial

* This means it's prepended with an underscore `_`

Sass files are named after their root class name

* Components: the base component will be the filename
  * `ui-color-picker` makes `_ui-color-picker.scss`
* Areas: the area controller will be the filename
  * `orders` makes `_orders.scss`


## Commenting best practice

When writing comments, it is best to follow a format that makes making changes easy, without having to clutter your code.

The first thing to keep in mind is that we section our styles based on components/templates and sub-components/templates.

*Each file* should have a main heading using a double underline (`=`) and *each sub-component/template* should have a second level heading using a single underline (`-`).

The second aspect of comments are the comments themselves! There are three types of comments...

1. General Comments

```scss
// My component
// ============
//
// This is a general comment that applies to the whole of this section. It can contain
// any information that is important to the file, styles and classes inside.

.my-component {
}
```

2. Direct Comments

Direct comments are those that apply to a single line of code as denoted by the number in the note. So the first note (1) will apply anywhere you see `// 1`.

Be aware that these notes typically only refer to the code directly beneath it, as far as just before the next section (i.e. the next sub-component). That next section could have it's own Direct Notes, but they will only apply to that section despite using the same numbers.

```scss
// My component
// ============
//
// Notes:
//
// 1. This is a direct comment about why we're using display: block
// 2. Absolutely positioned relative to the parent .my-component

.my-component {
  position: relative; // 2
  display: block; // 1

  .some-child {
    position: absolute; // 2
  }
}


// My component: inner
// -------------------
//
// Notes:
//
// 1. We see the number 1 again! But this note only counts for the code below and ignore the 1 above

.my-component__inner {
  display: block; // 1
}

```

3. Global Direct Comments

Global Direct Comments are used in the same way as normal Direct Comments with one crucial difference: these are declared once at the top of the file and can be used through any section!

So Note A will always refer to the same note.

This is a rare use case, but can be useful sometimes when you have the same set of changes that need to be applied across more than one section of code.

```scss
// My Component
// ============
//
// Notes:
//
// A. Hide these elements because it's unneeded desktop markup

.my-component {
  display: none; // A
}


// My Component: Inner
// -------------------

.my-component__inner {
  display: none; // A
}
```

### Common things to comment

* The parent relative position to an absolutely positioned element
* Explicit dimensions like widths or heights that don't appear based on any meaninful unit (like `$v-space` or `$h-space` and even font sizes)

## Variable naming convention

Variable names loosely resemble how we write `class` selectors, following this pattern: `${name}--{modifer(s)}`. We retain the `--` syntax of modifiers while forgoing the use of `__` to denote a sub-component or extension of the preceding "name".

The name of a variable should describe the application of the variable value. For example, instead of saying `$color` (which is too generic to be useful), you would write `$link-color` which gives the name meaning and purpose. You may find the need to chain names together with a single `-`, such as `$component-subcomponent--modifier`.

Similarly, the variable name can refer to specific properties such as `$border` or `$border-radius`.

Modifiers should be added after the name. So our above examples with modifiers appended to them will look like `$link-color--error`, `$border--dotted` and `$border-radius--large`.

Do note that variables without modifiers are implicitly the base version of that variable. As such, variables like `$link-color--default`, `$border--normal` and `$border-radius--base` are unnecessary and discouraged.

Continue on to [Block comment documentation guide →](../comments/Readme.md)
