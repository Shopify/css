# Building a component

## Table of contents
* [Basic conventions](#basic-conventions)
* [CSV](#csv)
  * [Components](#components)
  * [Sub-components](#sub-components)
  * [Variations](#variations)
  * [Component variations that affect sub-components](#component-variations-that-affect-sub-components)
  * [State](#state)
* [When to split a component](#when-to-split-a-component)
* [Contextual styles](#contextual-styles)
* [Layout sub-components](#layout-sub-components)
* [Using media queries](#using-media-queries)

## Basic conventions
Components should be named based on their primary function.
This repository includes a [sample Sass component](sample-component.scss) to use as a reference when building out a new component.

## CSV

Our convention (which we call CSV or Component, Sub-Component, Variation) uses [BEM principles](https://en.bem.info/method/key-concepts/) to denote types of classes while still maintaining full use of the cascade.

> BEM stands for Block, Element, Modifier. Because Block and Element already have meaning in CSS, we use the terms Component, Sub-component instead. We also prefer the term variation to modifier.

```html
<main class="blog">
  <h1 class="blog__title">Blog title</h1>
  <article class="blog-post blog-post--featured">
    <h2 class="blog-post__title">Blog post title</h2>
    <div class="blog-post__date">
      <p class="blog-post__time">12:03pm</p>
    </div>
  </article>
</main>
```

`.blog` This is a [component](#components). It describes a high-level module. In this instance, it describes the container for all of our blog posts.

`.blog__title` This is a [sub-component](#sub-components). It’s always a child of a component. In this instance, it is a title for our blog post container

`.blog-post` This is another component. This one describes a specific blog post. We make this its own component because a blog post is not necessarily a child of the blog container. It can and should be able to live independently. When a component or variation requires more than one word to describe its purpose, a single hyphen is used as a substitute for spaces.

`.blog-post--featured` This is a [variation](#variations). We combine the name of component `blog-post` with the variation `featured`, separated with double dashes `--`. This describes a different way of displaying a component.

`.blog-post__time` Like before, this is another sub-component. This time it belongs to the `blog-post`. It’s still a sub-component even though it is not a direct child of the component. We prefer this to `blog-post__date__time` to keep the class names simple and easier to read.

### Components

This is the base of the independent component that you are creating. Components should be able to exist on their own or within other components. They should always live at the root level of a Sass file.

* Single hyphenated naming.
* Not nested.

```scss
.blog-post {
}
```

### Sub-components

This is a secondary element inside of a component. We include the root component class in the name to help scope it without adding specificity. Your sub-components should be named in a way that keeps them from having to have sub-components of their own. If you find you need to write a sub-component for a sub-component, consider breaking the parent out into its own component.

You don’t need to nest these within the parent component or another sub-component. The class name should do all the work necessary. The one exception is when a variation effects a sub-component. We will talk more about this after.

* Prefixed by the parent component and two underscores `component-name__`.
* Live below the parent component in the root of the file. Not nested.
* Sub-components do not have to be direct children of the component in the markup. They can be any descendent.

```scss
// Bad!
//
// Note how .blog-post__title is nested inside it’s parent class
.blog-post {
  .blog-post__title {
  }
}

// Good!
.blog-post__title {
}
```

### Variations

These are used to create a new variation of a components or sub-component. They use `--` to signify they are modifying the component or sub-component name that comes before it. You should not need to scope the selector to the component because it is already in the class name.

```scss
// Bad!
//
// Note how we use the parent selector (&) to chain the variation class to .blog-post
.blog-post {
  &.blog-post--featured {
  }
}

// Good!
//
// Note how .blog-post--featured is a selector all by itself
.blog-post--featured {
}
```

### Component variations that affect sub-components

Sometimes a component variation will affect its sub-components. To do this we place all the selectors for the variation in one place. This makes it easier to see all the styles a variation is effecting.

```html
<article class="blog-post blog-post--featured">
  <h2 class="blog-post__title">Blog post title</h2>
  <div class="blog-post__date">
    <p class="blog-post__time">12:03pm</p>
  </div>
</article>
```

```scss
// Bad!
//
// You shouldn't declare styles for a component variation in multiple places
.blog-post__title {
  ...
  &.blog-post--featured {
    ...
  }
}

.blog-post__time {
  ...
  &.blog-post--featured {
    ...
  }
}

// Good!
.blog-post--featured {
  ...
  .blog-post__title {
    ...
  }
  .blog-post__time {
    ...
  }
}
```

### State

When a component or sub-component changes state (in response to a user action or other dynamic behaviour), we often add a class so the state can be styled and made visible to the user. These are almost always added and removed by JS as the user interacts with the page. If a class is being added or removed via JS, chances are it’s a state. Name these state classes similarly to variations but with an additional prefix of `is`. Since states will have the same CSS specificity as variations, define your states after variations in source-order to avoid variations accidentally overriding states.

```html
<ul class="select">
  <li class="select__option select__option--is-selected">Item 1</li>
  <li class="select__option">Item 2</li>
  <li class="select__option">Item 3</li>
</ul>
```

```scss
.select {}

.select__option {}
.select__option--tall {} // variation

.select__option--is-selected {} // state
.select__option--tall.select__option--is-selected {} // state
```

An alternative construction using the `has` prefix is reserved for marking a parent component with a sub-component that is in a particular state. These cases should be rare, but when necessary, would look like this:

```html
<ul class="select select--has-selection">
  <li class="select__option select__option--is-selected">Item 1</li>
  <li class="select__option">Item 2</li>
  <li class="select__option">Item 3</li>
</ul>
```

```scss
.select {}
.select--large {} // variation
.select--has-selection {} // state
```

## When to split a component
There are two basic rules when deciding whether to break a sub-component into a new top-level component:
  1. Could it be used elsewhere?
  2. Does it have several variations?

If either of these conditions are true, it is probably better to split it into its own component.

```scss
// Bad!
//
// You should never end up with sub-components of sub-components like this
.blog__post__title {
}

.blog__post__title--is-selected {
}

.blog__post__title--primary {
}

// Good!
.post__title {
}

.post__title--is-selected {
}

.post__title--primary {
}
```

## Contextual styles
It is best to avoid contextual styles (high-level components "reaching into" other high-level components) — use variations instead.

```scss
.banner {
  // ...some styles...
}

.blog-post--featured {
  // ...some styles...
}

// Bad!
//
// You should never target a component inside another component
.blog-post--featured {
  .banner {
    // ...some MORE styles...
  }
}

// Good!
.banner--featured {
  // ...some MORE styles...
}
```

## Layout sub-components
Dedicated sub-components should be used for layout and separate from other visual styles. This creates a separation of concerns and prevents the visual styles from affecting layouts.

```scss
// Bad!
//
// Usually it is best to not use a sub-component for both layout and visual treatments

.post__title {
  flex: 1 1 auto;
  font-size: $font-size-large;
  color: $black;
}

// Good!
.post__header {
  flex: 1 1 auto;
}

.post__title {
  font-size: $font-size-large;
  color: $black;
}
```

## Using media-queries

```scss
// Bad!
//
// Breakpoint should be nested inside the component

.component {
  margin: spacing();
}

@media (min-width: $breakpoint) {
  .component {
    margin: 0;
  }
}

// Good!
.component {
  margin: spacing();

  @media (min-width: $breakpoint) {
    margin: 0;
  }
}
```

Continue on to [Variables, maps, and functions →](../variables-maps-and-functions)
