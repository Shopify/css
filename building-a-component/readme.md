# Building a component


## Table of contents
* [Basic conventions](#basic-conventions)
* [CSM](#csm)
  * [Components](#components)
  * [Sub-components](#sub-components)
  * [Modifiers](#modifiers)
  * [Component modifiers that affect subcomponents](#component-modifiers-that-affect-subcomponents)
  * [State](#state)
* [When to split a component](#when-to-split-a-component)
* [Contextual styles](#contextual-styles)
* [Functional variables](#functional-variables)
* [Layout subcomponents](#layout-subcomponents)


## Basic conventions
Components should be named and created based on their primary function or use.
This repository includes a [sample component](_sample-component.scss) to use as a reference when building out a new component.

## CSM

Our convention (which we call CSM or Component, Sub-Component, Modifier) uses [BEM principles](http://csswizardry.com/2013/01/mindbemding-getting-your-head-round-bem-syntax/) to denote types of classes while still maintaining full use of the cascade.

> BEM stands for Block, Element, Modifier. Because Block and Element already have meaning in CSS, we use the terms Component and Subcomponent instead.

```html
<div class="blog">
  <h1 class="blog__title">Blog title</h1>
  <div class="blog-post blog-post--featured">
    <h2 class="blog-post__title">Blog post title</h2>
    <div class="blog-post__date">
      <p class="blog-post__time">12:03pm</p>
    </div>
  </div>
</div>
```

If a component or modifier requires more than one word to describe its purpose, a single hyphen is used as a substitute for "spaces". Try to be concise – minimize the need for single hyphens whenever possible without sacrificing comprehension.

`.blog` This is a component. It describes a high-level module. In this instance, it describes the container for all of our blog posts.

`.blog__title` This is a sub-component. It's always a child of a component. In this instance, it is a title for our blog post container

`.blog-post` This is another component. This one describes a specific blog post. We make this its own component because a blog post is not necessarily a child of the blog container. It can and should be able to live independently.

`.blog-post--featured` This is a modifier. It is always chained to a component or sub-component. In this instance, it describes a different way of displaying a component.

`.blog-post__time` Like before, this is another sub-component. This time it belongs to the blog-post. It's still a subcomponent even though it is not a direct child of the component.

### Components

This is the base of the independent component that you are creating. Components should be able to exist on their own or within other components. They should always live at the root level of a file.

* Single hyphenated naming.
* Not nested.

```scss
.blog-post {
}
```

### Sub-components

This is a secondary element inside of a component. It is always written as a chain of its parent component to avoid any inheritance issues. Your subcomponents should be named in a way that keeps them from having to have subcomponents of their own. If you find you need to write a subcomponent for a subcomponent, consider breaking the parent out into its own component.

Just like components, these should always live at the root level of a file. Do not nest these within the parent component or another subcomponent. The class name should do all the work necessary.

* Prefixed by the parent component and two underscores `component-name__`.
* Live below the parent component in the root of the file. Not nested.
* Subcomponents do not have to be direct children of the component in the markup. They can be any descendent.

```scss
// Good!
.blog-post__title {
}

// Bad!
//
// Note how .blog-post__title is nested inside it's parent class
.blog-post {
  .blog-post__title {
  }
}
```

### Modifiers

These are used to modify components or subcomponents. They use `--` to signify they are modifying the component or subcomponent name that comes before it. You should not need to scope the selector to the component because it is already in the class name.

```scss
// Good!
//
// Note how .blog-post--featured is a selector all by itself?
.blog-post--featured {
}

// Bad!
//
// Note how we use the parent selector (&) to chain the modifier class to .blog-post
.blog-post {
  &.blog-post--featured {
  }
}
```

### Component modifiers that affect subcomponents

Sometimes a component modifier will affect its sub-components. There are several methods you can use to accomplish this. As much as possible, stick to one method.

```html
<div class="blog-post blog-post--featured">
  <h2 class="blog-post__title">Blog post title</h2>
  <div class="blog-post__date">
    <p class="blog-post__time">12:03pm</p>
  </div>
</div>
```


#### 1. Styles grouped with modifier
Nest the `.component__sub-component` elements inside the `.component` SCSS.

This method allows you to quickly update or edit the styles for all elements affected by a modifier.

```scss
.blog-post--featured {
  ...

  .blog-post__title {
    ...
  }
}
```

#### 2. Styles grouped with sub-component
Nest the modifier code inside the sub-component using `.component--modifier &`.

This method makes it easier to visualize the differences between a sub-component and its modified states.

```scss
.blog-post__title {
  ...

  .blog-post--featured & {
    ...
  }
}
```

### State

When a component or sub-component changes state (in response to a user action or other dynamic behaviour), we often add a class so the state can be styled and made visible to the user. These are almost always added and removed by UI scripts as the user interacts with the page. If a class is being added or removed via JS, chances are it’s a state. Name these state classes similarly to modifiers but with an additional prefix of `is`. Since states will have the same CSS specificity as modifiers, define your states after modifiers in source-order to avoid modifiers accidentally overriding states.

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
.select__option--tall {} // modifier

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
.select--large {} // modifier
.select--has-selection {} // state
```

## When to split a component
There are two basic rules when deciding whether to break a subcomponent into a new top-level component:
  1. Could it be used elsewhere?
  2. Does it have variations?
If either of these conditions are true, it is probably better to split it into its own component.

```scss
// Good!

.post__title {
}

.post__title--is-selected {
}

.post__title--primary {
}

// Bad!
//
// You should never end up with subcomponents of subcomponents like this

.blog__post__title {
}

.blog__post__title--is-selected {
}

.blog__post__title--primary {
}
```


## Contextual styles
It is best to avoid contextual styles (high-level components "reaching into" other high-level components) — use modifiers instead.

```scss
.home-page {
  // ...some styles...
}

.blog-post {
  // ...some styles...
}

// Good!
//
.blog-post--home {
  // ...some MORE styles...
}

// Bad!
//
.home-page {
  .blog-post {
    // ...some MORE styles...
  }
}
```


## Functional variables
All variables used in a component should be functional instead of just visual. Functional variables can only refer to a visual variable.


```scss
// Good!

$success-color: $green;

.badge--success {
  background: $success-color;
}

// Bad!
//
// You should never use a visual variable directly in your component
$green: #96bf48;

.badge--success {
  background: $green;
}
```


## Layout subcomponents
Dedicated subcomponents should be used for layout and separate from other visual styles.

```scss
// Good!
.post__header {
  flex: 1 1 auto;
}

.post__title {
  font-size: $font-size-large;
  color: $black;
}

// Bad!
//
// You should never use a subcomponent for both layout and visual treatments

.post__title {
  flex: 1 1 auto;
  font-size: $font-size-large;
  color: $black;
}
```

Continue on to [CSS best practices →](../css-best-practices#css-best-practices)
